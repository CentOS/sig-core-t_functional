from argparse import ArgumentParser
import io
import os
import tempfile

from duffy.client import DuffyClient
from fabric import Connection
from invoke import run as local

class DuffyWrapper:
    def __init__(self, auth_name, auth_key):
        self.c = DuffyClient(url="https://duffy.ci.centos.org/api/v1", auth_name=auth_name, auth_key=auth_key)
        self.last_session = None

    def get_hostnames(self, *query):
        if not self.last_session:
            self.request_session(*query)

        nodes = [n for n in self.last_session.session.nodes
                if all(q in n.pool for q in query)]
        return [n 
                 for n in [n.data.get('provision',{}).get('public_hostname',None) for n in nodes]
                 if n]

    def find_hostnames(self, *query):
        ls = self.c.list_sessions()
        nodes = [n for s in ls.sessions for n in s.nodes
                if all(q in n.pool for q in query)]
        return [n 
                 for n in [n.data.get('provision',{}).get('public_hostname',None) for n in nodes]
                 if n]

    def find_pool_name(self, *query):
        return [p.name for p in self.c.list_pools().pools if all(q in p.name for q in query)]

    def request_session(self, *query):
        pool = self.find_pool_name(*query)
        session = self.c.request_session([{"pool":pool[0], "quantity":"1"}])
        if hasattr(session, 'session'):
            self.last_session = session
            return session
        else:
            raise Exception(repr(session))

class TmuxWrapper:
    def __init__(self, host, session='default-session', private_key=None, **rest):
        self.host = host
        if private_key:
            self.c = Connection(host,connect_kwargs={
                "key_filename": private_key,
            }, **rest)
        else:
            self.c = Connection(host, **rest)

        self.c.run("dnf -y install git tmux")
        self.ensure_session(session)

    def ensure_session(self,session='default-session'):
        return self.c.run("tmux has-session -t {session} || tmux new -s {session} -d".format(session=session))

    def run(self, cmd, session='default-session'):
        return self.c.run("tmux send-keys -t {session}:0 '{cmd}' ENTER".format(session=session, cmd=cmd))

    def run_and_notify(self, cmd, session='default-session'):
        return self.c.run("tmux send-keys -t {session}:0 '{cmd}; tmux wait-for -S {session}' ENTER".format(session=session, cmd=cmd))

    def wait_for(self, session='default-session'):
        return self.c.run("tmux wait-for {session}".format(session=session))

    def send_folder(self, path, remote):
        with  tempfile.NamedTemporaryFile() as t:
            local("tar cf {to} -C {path} .".format(path=path, to=t.name))
            print(t.name)
            self.c.run("mkdir -p {}".format(remote))
            self.c.put(local=t.name, remote=remote)
            self.c.run("cd {path} && tar xf {name}".format(path=remote, name=t.name.split('/')[-1]))
    def get_pane(self):
        return tmux.c.run("tmux capture-pane -p -t default-session")
    def set_repo(self, baseurl="https://composes.stream.centos.org/development/latest-CentOS-Stream/compose/"):
        repo = io.StringIO("""
[baseos-compose]
name=CentOS Stream $releasever - BaseOS
baseurl={baseurl}/BaseOS/$arch/os/
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial
gpgcheck=0
repo_gpgcheck=0
metadata_expire=6h
countme=1
enabled=1

[appstream-compose]
name=CentOS Stream $releasever - AppStream
baseurl={baseurl}/AppStream/$arch/os/
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial
gpgcheck=0
repo_gpgcheck=0
metadata_expire=6h
countme=1
enabled=1
        """.format(baseurl=baseurl))
        self.c.put(repo, "/tmp/compose.repo")
        self.c.run("dnf repolist | awk '(NR>1) {print $1}' | xargs dnf config-manager --disable")
        self.c.run("dnf config-manager --add-repo /tmp/compose.repo")
        self.c.run("dnf config-manager --enable baseos-compose")
        self.c.run("dnf config-manager --enable appstream-compose")
        self.c.run("dnf clean all")



def runtests(auth_name, auth_key, query, path=None, compose=None, private_key=None):
    d = DuffyWrapper(auth_name=auth_name, auth_key=auth_key)
    print("Getting", *query)
    hostnames = d.get_hostnames(*query)
    if not hostnames:
        raise Exception("Didn't manage to find or provision matching machine.")

    hostname = hostnames[0] 
    print("root@"+hostname)
    tmux = TmuxWrapper("root@"+hostname, private_key=private_key)
    if compose:
        print("Setting compose", compose)
        tmux.set_repo(compose)
    if path:
        print("Sending local repo",path )
        tmux.send_folder(path, "/opt/t_functional")
    else:
        tmux.c.run("git clone https://github.com/CentOS/sig-core-t_functional /opt/t_functional")
    tmux.ensure_session()
    tmux.run("cd /opt/t_functional")
    tmux.run("export SYSTEMD_PAGER=")
    tmux.run("ls -l")
    tmux.c.run("cd /opt//t_functional && /bin/bash runtests.sh 0_common")
    return tmux


def main():
    parser = ArgumentParser(prog='My App')
    parser.add_argument('--arch', help="The duffy query.")
    parser.add_argument('--path', help="", default=None, required=False)
    parser.add_argument('--release', help="" )
    parser.add_argument('--compose', help="", default=None, required=False)
    parser.add_argument('--sshkey', help="", default=None, required=False)
    args = parser.parse_args()
    auth_name=os.getenv("DUFFY_AUTH_NAME")
    auth_key=os.getenv("DUFFY_AUTH_KEY")
    print("Running with args:",args.arch, args.release, args.path, args.compose, args.sshkey)
    if auth_name and auth_key:
        runtests(auth_name, auth_key, ['virt', args.arch, args.release], path=args.path, compose=args.compose, private_key=args.sshkey)
    else:
        raise Exception("Duffy key or auth name not available")

if __name__ == "__main__":
    print("Running tests")
    main()
