#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "$BASH_SOURCE" )" ; pwd;)
includeAllWorkspaceSymbols=true 

source $SCRIPT_DIR/helpers.sh
source $SCRIPT_DIR/connectMenuFunctions.sh

function connectMenu
{

 if [ $# -eq 1 ]
 then cd $1
 select option in "Create Table" "List Tables" "Drop Table" "Insert Into Table" "Select From Table" "Delete From Table" "Update Table" "Exit"
 do 
  case $option in 
   "Create Table") createTable  ;;
  
   "List Tables") listTable ;;
  
   "Drop Table") dropTable  ;;
  
   "Insert Into Table") insertIntoTable  ;;
 
   "Select From Table") selectFromTable  ;;
  
   "Delete From Table" ) deleteFromTable ;;
  
   "Update Table") updateTable ;;
  
   "Exit") echo Back to databases menu ; break ;;
  esac
done
fi 
}






