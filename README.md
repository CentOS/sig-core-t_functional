This Code is written for and used in the CentOS Automated QA tests process. We welcome all contributions.

See the doc directory for additional information on test writing.

## Nightly Test Status

| CentOS Version/Architecture | Build Status |
| --------------------------- | ------------ |
| CentOS 8 - x86_64           | [![Build Status](https://ci.centos.org/buildStatus/icon?job=CentOS-Core-QA-t_functional-c8-64)](https://ci.centos.org/job/CentOS-Core-QA-t_functional-c8-64/) |
| CentOS 7 - x86_64           | [![Build Status](https://ci.centos.org/buildStatus/icon?job=CentOS-Core-QA-t_functional-c7-64)](https://ci.centos.org/job/CentOS-Core-QA-t_functional-c7-64/) |
| CentOS 6 - x86_64           | [![Build Status](https://ci.centos.org/job/CentOS-Core-QA-t_functional-c6-64/badge/icon)](https://ci.centos.org/job/CentOS-Core-QA-t_functional-c6-64/) |
| CentOS 6 - i386             | [![Build Status](https://ci.centos.org/job/CentOS-Core-QA-t_functional-c6-32/badge/icon)](https://ci.centos.org/job/CentOS-Core-QA-t_functional-c6-32/) |

## Running tests

To run these tests on your local machine :
```
./runtests.sh
```

To only run a specific test ( eg. p_openssh ) : 
```
./runtests.sh p_openssh
```
## Writing tests

There is a dedicated [wiki page](http://wiki.centos.org/QaWiki/AutomatedTests/WritingTests/t_functional) covering that. As a newcomer, you should read this document from start to finish. 
Questions/comments/suggestions should be voiced in the #centos-devel channel on Freenode IRC, or via email on the centos-devel@centos.org mailing list.

## Disabling tests

While it's a very bad idea, sometimes , during major.minor release, our scripts really find issues that are then repored upstream.
For the time being, one can add tests to be skipped by our QA harness setup (validating all new installable trees)

See the [skipped-tests.list](skipped-tests.list) file.
