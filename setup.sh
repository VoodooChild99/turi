#!/bin/bash

SCRIPT_DIR=$(dirname $0)
cd $SCRIPT_DIR

DEP_DIR="dependencies"

function usage
{
	  echo "This script clones all the turi repository and sets up a turi"
	  echo "development environment."
    
	  exit 1
}

function install_angr
{
    mkdir -p $DEP_DIR
    cd $DEP_DIR

    # angr
    git clone https://github.com/VoodooChild99/angr-dev.git
    cd angr-dev/
    git checkout diane-docker
    ./setup.sh -i -b py2k
    #./git_all.sh checkout feat/mixed_java
    cd ../
    cd ../

}

function install_pysoot
{
    mkdir -p $DEP_DIR
    cd $DEP_DIR

    git clone https://github.com/conand/pysoot
    pip install -e ./pysoot
    pip install pysmt
    cd ..
}

while getopts "h" opt
do
	  case $opt in
		  \?)
			    usage
			    ;;
		  h)
			    usage
			;;
	esac
done

ANGR_INSTALLED=$(pip list 2> /dev/null | grep angr)
# install angr first
if [ -z "$ANGR_INSTALLED" ]
then
    install_angr
fi

# install pysoot
PYSOOT_INSTALLED=$(pip list 2> /dev/null | grep pysoot)
if [ -z "$PYSOOT_INSTALLED" ]
then
    install_pysoot
fi

