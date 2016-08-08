#!/usr/bin/env bash

#load check version
source config/check_version.sh

osname=`echo $os | awk '{print $1}'`

if [[ "$osname" == "Ubuntu" ]];then
    echo "Ubuntu"
elif [[ "$osname" == "CentOS" ]];then
    echo "CentOS"
else
    echo "Not Support!!!"
fi

exit 0
