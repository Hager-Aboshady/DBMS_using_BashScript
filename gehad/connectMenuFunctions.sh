#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "$BASH_SOURCE" )" ; pwd;)

source $SCRIPT_DIR/helpers.sh                         #this file contains the functions of the 2nd menu only 
                                                       #the function body may contain a script or the code to execute directly

function createTable
{
source $SCRIPT_DIR/createTableScript.sh
createTable
}

function listTable
{

}

function dropTable
{

 
}


function insertIntoTable
{
source $SCRIPT_DIR/insertScript.sh
insertFun
flag=$? 
if [ $flag -eq 0 ]
then
  #back to menu  
fi 
}

function selectFromTable
{
 
}

function deleteFromTable
{

 
}

function updateTable
{

 
}


