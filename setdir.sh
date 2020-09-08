#!/bin/bash
#sabryr 23-07-2020 
#To setup the directory for a custom build

ROOT=$(pwd)
parallel=8
install_root="$ROOT/easybuild"
installpath="$install_root/install"
installpath_modules="$install_root/modules" 
installpath_software="$install_root/easybuild"
buildpath="$install_root/build"
repositorypath="$install_root/repo" 
tmp_logdir="$install_root/tmp" 
tmpdir="$install_root/tmp"
include_easyblocks="$ROOT/nlplpython.py"
source_path="$install_root/src"

for loc in $install_root $installpath $installpath_modules $installpath_software $buildpath $repositorypath $tmpdir $tmp_logdir $source_path
do
  if [ -d "$loc" ];then
    echo "Found -- " $loc
  else
    echo "Not found -- " $loc " creating"
    mkdir $loc
  fi
done;

echo "    export MODULEPATH=${installpath_modules}/all:${MODULEPATH} " >  PATH.local

echo "--------------------------- "  > SETUP.local
echo "    Set the path as follows "  >> SETUP.local
echo "    export MODULEPATH=${installpath_modules}/all:${MODULEPATH} " >> SETUP.local
echo "    or  " >> SETUP.local
echo "    source PATH.local  " >> SETUP.local
echo "    ------------------------ "  >> SETUP.local
echo "    Easybuild command to use: "  >> SETUP.local
echo "eb --parallel=$parallel  \ "  >> SETUP.local
echo "   --installpath=$installpath  \ "  >> SETUP.local
echo "   --installpath-modules=$installpath_modules \ "  >> SETUP.local
echo "   --installpath-software=$installpath_software  \ "  >> SETUP.local
echo "   --buildpath=$buildpath \ "  >> SETUP.local
echo "   --repositorypath=$repositorypath  \ "  >> SETUP.local
echo "   --tmp-logdir=$tmp_logdir \ "  >> SETUP.local
echo "   --sourcepath=$source_path \ "  >> SETUP.local
echo "   --tmpdir=$tmpdir  \ "  >> SETUP.local
echo "   --robot $(pwd): <EASYBUILD-FILE> "  >> SETUP.local

echo "Local setup saved in SETUP.local"
cat SETUP.local
