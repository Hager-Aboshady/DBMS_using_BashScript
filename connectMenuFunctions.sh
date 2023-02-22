#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "$BASH_SOURCE" )" ; pwd;)

source $SCRIPT_DIR/helpers.sh                       


function createTable
{
   source $SCRIPT_DIR/createTable.sh $1
   createTable 
    if [ $? -eq 0 ]
    then
     echo back to connect menu 
    fi 
}
                         
function listTable
{
  source $SCRIPT_DIR/listTablesScript.sh
  if [ $? -eq 0 ]
    then
     echo back to connect menu 
  fi 
}

function dropTable
{
 source $SCRIPT_DIR/dropTableScript.sh 
 dropTable
 flag=$? 
 if [ $flag -eq 0 ]
 then
    echo back to connect menu 
 fi 
 
}


function insertIntoTable
{
source $SCRIPT_DIR/insertScript.sh
insertFun
flag=$? 
if [ $flag -eq 0 ]
then
  echo back to connect menu 
fi 
}

function selectFromTable
{
  source $SCRIPT_DIR/selectFromTable.sh $1
  selectRow 
  if [ $? -eq 0 ]
  then
  echo back to connect menu 
  fi 
}

function deleteFromTable
{
  source $SCRIPT_DIR/deleteScript.sh
  deleteFun
if [ $? -eq 0 ]
 then
  echo back to connect menu 
 fi 
}

function updateTable
{
 source $SCRIPT_DIR/updateTable.sh
 updateTable 
 if [ $? -eq 0 ]
 then
  echo back to connect menu 
 fi 

}


