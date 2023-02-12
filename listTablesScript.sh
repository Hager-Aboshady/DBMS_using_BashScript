#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "$BASH_SOURCE" )" ; pwd;)

source $SCRIPT_DIR/helpers.sh 
 
 
ls  $PWD |grep -v '^([A-Za-z_])+([A-Za-z0-9_])\_meta$'                          #list all except any file ends with   _meta
 
#function listTablesFun
#{




#}
