#!/bin/bash
#Source: https://golang.org/dl/


echo "Installing Go..."
if [ -d /usr/local/go ]; then
    echo "Go appears to be installed in /usr/local/go already, aborting."
    exit
fi

if [ ! `uname -a | grep Linux | wc -l` -ge 1 ]; then  
	echo "This script only works on Linux."
	exit
fi

FILE="go1.5.1.linux-386.tar.gz"
if [ `uname -m | grep 64 | wc -l` -ge 1 ]; then  
	FILE="go1.5.1.linux-amd64.tar.gz" #Get 64 bit version
fi

if [ -f $FILE ]; then
    echo "File $FILE already exists, not a good sign, delete it before continuing"
    exit
fi

echo "Downloading $FILE"
curl --remote-name https://storage.googleapis.com/golang/$FILE
if [ ! -f $FILE ]; then
    echo "File failed to download"
    exit
fi

echo "Extracting $FILE to /usr/local/go..."
sudo tar -C /usr/local -xzf $FILE

echo "Removing $FILE"
rm $FILE

echo "Making a go path in home directory"
mkdir -p ~/go

echo "Running export commands..."
export PATH=$PATH:/usr/local/go/bin
export GOPATH=~/go

echo "Adding export options to ~/.bashrc..."
echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.bashrc
echo "export GOPATH=~/go" >> ~/.bashrc

echo "If any other users need go path, here is the information to add to /home/<user>/.bashrc:"
echo "export PATH=$PATH:/usr/local/go/bin"
echo "export GOPATH=~/go"

echo "Done."
