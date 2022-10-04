# Author: Piyush Kumar <piykumar@gmail.com>
# Author: Munish Kumar <munishktotech@gmail.com>
# Author: Ayush Gupta <ayush.001@gmail.com>
# Author: Konark Modi <modi.konark@gmail.com>

t_Log "Running $0 -installing libbpf and bcc-tools."
if [ "$centos_ver" -ge 8 ] ; then
 t_InstallPackage libbpf
 t_InstallPackage bcc-tools
else
 t_Log "Skip on less than EL8"
fi
