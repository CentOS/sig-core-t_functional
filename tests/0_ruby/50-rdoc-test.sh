#!/bin/sh
# Author: Nikhil Lanjewar <nikhil@lanjewar.com>
# Author: Sahil Muthoo <sahilm@thoughtworks.com>
# Author: Sahil Aggarwal <sahilagg@gmail.com>
# Author: Saager Mhatre <saager.mhatre@gmail.com>

t_Log "Running $0 - Check successful installation of ruby rdoc."

rdoc -v | grep 'V1.0.1'

t_CheckExitStatus $?

