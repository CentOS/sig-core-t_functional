#!/bin/sh
# Author: Nikhil Lanjewar <nikhil@lanjewar.com>
# Author: Sahil Muthoo <sahilm@thoughtworks.com>
# Author: Sahil Aggarwal <sahilagg@gmail.com>
# Author: Saager Mhatre <saager.mhatre@gmail.com>

t_Log "Running $0 - attempting to install ruby, ruby-irb, ruby-ri and ruby-rdoc4"
t_InstallPackage ruby
t_InstallPackage ruby-irb
t_InstallPackage ruby-ri
t_InstallPackage ruby-rdoc

