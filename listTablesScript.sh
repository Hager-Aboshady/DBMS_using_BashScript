#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "$BASH_SOURCE" )" ; pwd;)

source $SCRIPT_DIR/helpers.sh 

ls | grep -v '\_meta$'       #list all except any file ends with   _meta
count=$(ls | grep -v '\_meta$' | wc -l)
if [ $count = "0" ]
then 
 echo Database does not have tables yet 
fi