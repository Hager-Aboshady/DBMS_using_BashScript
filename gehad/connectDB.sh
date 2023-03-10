#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "$BASH_SOURCE" )" ; pwd;)

source $SCRIPT_DIR/helpers.sh
source $SCRIPT_DIR/connectMenuFunctions.sh

function connectMenu
{
 if [ $# -eq 1 ]
 then cd $1
 select option in "Create Table" "List Tables" "Drop Table" "Insert Into Table" "Select From Table" "Delete From Table" "Update Table" "Exit"
 do 
  case $option in 
   "Create Table") createTable $1 ;;
  
   "List Tables") echo list ;;
  
   "Drop Table") echo drop  ;;
  
   "Insert Into Table") echo insert  ;;
 
   "Select From Table") echo "select" ;;
  
   "Delete From Table" ) echo delete  ;;
  
   "Update Table") echo update  ;;
  
   "Exit") break ;;
  esac
done
fi 
}






