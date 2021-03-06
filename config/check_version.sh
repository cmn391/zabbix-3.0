#!/bin/sh
#
# Author sangnv 
#

debug=false

from=''
if which uname >/dev/null 2>&1
	then
		os="`uname -sr`"
		$debug && from=' [uname -sr]'
	else
		os=unknown
	fi

if [ -f /etc/SuSE-release ]
then
    # SUSE Linux Enterprise Server 11 (ia64)
    os=`sed </etc/SuSE-release -n -e '1{
		s/ (.*//
		s/Linux Enterprise Server /SLES/
		p
		}'`
			os="$os`sed </etc/SuSE-release -n -e '/^PATCHLEVEL /{
		s/.*=[ 	]*/ SP/
		p
		}'`"
			os="$os`sed </etc/SuSE-release -n -e '/^CODENAME /{
		s/.*=[ 	]*/ (/
		s/$/)/
		p
		}'`"
    $debug && from=' [/etc/SuSE-release]'
elif [ -f /etc/centos-release ]
then
    # CentOS release 6.5 (Final)
    os=`sed </etc/centos-release -e 's/ release / /'`
    $debug && from=' [/etc/centos-release]'
elif [ -f /etc/lsb-release ]
then
    # Debian-based distros tend to use this way
    # DISTRIB_ID=LinuxMint
    # DISTRIB_RELEASE=12
    # DISTRIB_CODENAME=lisa
    #
    id=`sed </etc/lsb-release -n -e '/^DISTRIB_ID *= */s///p'`
    release=`sed </etc/lsb-release -n -e '/^DISTRIB_RELEASE *= */s///p'`
    codename=`sed </etc/lsb-release -n -e '/^DISTRIB_CODENAME *= */s///p'`
    os="$id $release ($codename)"
    $debug && from=' [/etc/lsb-release]'
elif [ -f /etc/debian_version ]
then
    # 6.0.1
    #
    os="Debian `cat /etc/debian_version`"
    $debug && from=' [/etc/debian_version]'
elif [ -f /etc/mandriva-release ]
then
    # Mandriva Linux release 2011.0 (Official) for x86_64
    #
    os=`sed </etc/mandriva-release -e 's/ release / /' -e 's/ (Official)/ /' -e 's/ for .*//'`
    $debug && from=' [/etc/mandriva-release]'
elif [ -f /etc/redhat-release ]
then
    # CentOS release 5.6 (Final)
    #
    os=`sed </etc/redhat-release -e 's/ release / /'`
    $debug && from=' [/etc/redhat-release]'
elif [ -f /etc/gentoo-release ]
then
    # Gentoo Base System release 2.0.3
    #
    os=`sed </etc/gentoo-release -e 's/ release / /' -e 's/ Base System / /'`
    $debug && from=' [/etc/gentoo-release]'
elif [ -f /etc/system-release ]
then
    # Fedora release 15 (Lovelock)
    #
    os=`sed </etc/system-release -e 's/ release / /'`
    $debug && from=' [/etc/system-release]'
elif [ -f /etc/os-release ]
then
    # NAME=openSUSE
    # VERSION = 12.1 (Asparagus)
    #
    name=`sed </etc/os-release -n -e '/^NAME *= */s///p'`
    ver=`sed </etc/os-release -n -e '/^VERSION *= */s///p'`
    os="$name $ver"
    $debug && from=' [/etc/os-release]'
elif [ -f /etc/release ]
then
    #    OpenSolaris 2010.05 snv_134b X86
    #    OpenIndiana Development oi_148 X86
    #
    try=`sed </etc/release -n -e '/Open[A-Z]/{
		s/.*Open/Open/
		s/ /~/
		s/ /~/
		s/ .*//
		s/~/ /g
		p
		}'`
    if [ -n "$try" ]
    then
	os="$try"
	$debug && from=' [/etc/release]'
    fi
elif [ -f /etc/slackware-version ]
then
    os=`cat /etc/slackware-version`
fi

#echo "$os"
$debug && echo "$from"