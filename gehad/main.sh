#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "$BASH_SOURCE" )" ; pwd;)
source $SCRIPT_DIR/helpers.sh

source $SCRIPT_DIR/menuFunctions.sh



isExist "Databases" $PWD

dbExist=$?

echo $dbExist

if [ $dbExist -eq 0 ] 
then mkdir  Databases
     
fi

cd Databases
select option in "Create Database" "List Database" "Drop Database" "Connect to Database" "exit"
do 
  case $option in 
 "Create Database") createDB ;;
  
 "List Database") listDB ;;
  
 "Drop Database") dropDB ;;
  
 "Connect to Database") connectToDB ;;
  
  "exit") break ;;
  esac
done
