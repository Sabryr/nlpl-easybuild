#!/bin/bash
#sabryr 09-04-2020 
#To setup the directory for a custom build

ROOT=$(pwd)
install_root="$ROOT/easybuild"
installpath="$install_root/install"
installpath_modules="$install_root/modules" 
installpath_software="$install_root/easybuild"
buildpath="$install_root/build"
repositorypath="$install_root/repo" 
tmp_logdir="$install_root/tmp" 
tmpdir="$install_root/tmp"
include_easyblocks="$ROOT/nlplpython.py"


for loc in $install_root $installpath $installpath_modules $installpath_software $buildpath $repositorypath $tmpdir $tmp_logdir 
do
  if [ -d "$loc" ];then
    echo "Found -- " $loc
  else
    echo "Not found -- " $loc " creating"
    mkdir $loc
  fi
done;

echo "------------------------"
echo "Set the path as follows"
echo "export MODULEPATH=$installpath_modules"/all:"$MODULEPATH"
echo "------------------------"
echo "Easybuild command to use "
echo "eb --installpath=$installpath --installpath-modules=$installpath_modules \
--installpath-software=$installpath_software --buildpath=$buildpath \
--repositorypath=$repositorypath --tmp-logdir=$tmp_logdir \
--tmpdir=$tmpdir --include-easyblocks=$include_easyblocks \
--robot <EeasyBuid file>" 

