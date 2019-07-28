#!/bin/sh
# Author: Nikhil Lanjewar <nikhil@lanjewar.com>
# Author: Sahil Muthoo <sahilm@thoughtworks.com>
# Author: Sahil Aggarwal <sahilagg@gmail.com>
# Author: Saager Mhatre <saager.mhatre@gmail.com>

t_Log "Running $0 - attempting to install ruby, ruby-irb, ruby-ri and ruby-rdoc4"
if [ "$centos_ver" -ge 8 ] ; then
t_InstallPackage ruby ruby-irb rubygem-rdoc
else
t_InstallPackage ruby ruby-irb ruby-ri ruby-rdoc
fi

