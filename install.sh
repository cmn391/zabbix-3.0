#!/usr/bin/env bash

#load check version
source check_version.sh

osname=`echo $os | awk '{print $1}'`

if [[ "$osname" == "Ubuntu" ]];then
    echo "Ubuntu"
elif [[ "$osname" == "Centos" ]];then
    echo "Centos"
else
    echo "Not Support!!!"
fi

exit 0