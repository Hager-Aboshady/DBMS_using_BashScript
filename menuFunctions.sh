#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "$BASH_SOURCE" )" ; pwd;)

source $SCRIPT_DIR/helpers.sh
source $SCRIPT_DIR/connectDB.sh

function createDB
{
 read -p "Please Enter The name of the database " dbName
 
 isValid $dbName
 valid=$?
 if [ $valid -eq 1 ]
 then
     isExist $dbName $PWD
     exist=$?
     
     if [ $exist -eq 0 ]
     then mkdir $dbName
          echo "$dbName Database has been created successfully"
          
     else echo "$dbName Database is already exist !"
     fi
       
 fi
 
}

function listDB
{

ls -F | grep / | sed 's/.$//'
count=$(ls -F | grep / | sed 's/.$//'| wc -l)
if [ $count = "0" ]
then 
 echo Thee is no databases yet 
fi

}


function dropDB
{
 read -p "Please Enter The name of the database " dbName
 
 
 isValid $dbName
 valid=$?
 if [ $valid -eq 1 ]
 then
     isExist $dbName $PWD
     exist=$?
     
     if [ $exist -eq 1 ]
     then rm -r $dbName
     echo "$dbName Database has been removed successfully"
 
     else echo "$dbName  Database is not exist !"
     fi
       
 fi


}

function connectToDB
{
 read -p "Please Enter The name of the database " dbName
 
 
 isValid $dbName
 valid=$?
 if [ $valid -eq 1 ]
 then
     isExist $dbName $PWD
     exist=$?
     
     if [ $exist -eq 1 ]
     then 
     connectMenu $dbName
     cd ..
     else echo "$dbName Database is not exist !"
     fi
       
 fi


}






