#!/bin/bash
#Source: https://golang.org/dl/

echo "Uninstalling Go..."


if [ ! `uname -a | grep Linux | wc -l` -ge 1 ]; then  
	echo "This script only works on Linux."
	exit
fi

FILE="go1.5.1.linux-386.tar.gz"
if [ `uname -m | grep 64 | wc -l` -ge 1 ]; then  
	FILE="go1.5.1.linux-amd64.tar.gz" #Get 64 bit version
fi

if [ -f $FILE ]; then
    rm $FILE
    echo "Removing downloaded file $FILE"
    exit
fi

if [ -d /usr/local/go ]; then
	read -p "Remove directory /usr/local/go ? " -r
	if [[ $REPLY =~ ^[Yy]$ ]]; then
	    echo "Removing directory /usr/local/go"
    	rm -rf /usr/local/go
	fi
fi

if [ -d ~/go ]; then
	read -p "Remove directory ~/go ? " -r
	if [[ $REPLY =~ ^[Yy]$ ]]; then
	    echo "Removing directory ~/go"
    	rm -rf ~/go
	fi
fi

echo "I'm not going to touch your home directory, but inside ~/.bashrc these lines:"
echo "export PATH=$PATH;/usr/local/go/bin"
echo "export GOPATH=~/go"

echo "Done."
