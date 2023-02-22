#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "$BASH_SOURCE" )" ; pwd;)
source $SCRIPT_DIR/helpers.sh


function createTable
{

 typeset -i res=0 valid=0 exist=0 isNum=0 numCol

   read -p "Please Enter The name of the Table " tbName
   isValid $tbName

 if [ $? -eq 1 ] 
 then
    valid=1
 else 
    echo "$tbName Table Name ivalid !"
   echo "back to connect menu :) "
    valid=0
    return 0 
 fi 
 
isExist $tbName $PWD

 if [ $? -ne 0 ]
  then
     echo $tbName "Table is already exist !"
     exist=1
     return 0 
  fi 
   
   #NumCol:1stColName:1stColType:2ndColName:2ndColType
   read -p "Please Enter Number of Columns " numCol
   isNum $numCol

  if [ $? -eq 1 ] 
  then   
   isNum=1
  else 
   echo $tbName" You should enter number !"
  fi



if [[ $valid -eq 1  &&  $exist -eq 0  &&  $isNum -eq 1 ]] 
      then 
         i=2
         newTableRecord=${numCol}":ID:number"
         echo first column is \"ID\" and primary key by default 
         while [ $i -le $numCol ]
           do 
            typeset -i valid2=0 exist2=1 
            read -p "Enter $i Column Name " colName
            isValid $colName

            if [ $? -eq 1 ]
            then 
            valid2=1
            else 
               echo "This column name invalid "
            fi 
         
            if [[ $newTableRecord == *$colName* && $valid2 -eq 1 ]];
            then
            echo "This column name already exists"
            else 
            exist2=0
            fi

            if [[ $valid2 -eq 0 ||  $exist2 -eq 1 ]]
            then 
                  select op in "Try Again" "Exit"
                  do 
                     case $op in 
                     "Try Again") echo ok ; break ;;
                     "Exit") echo "faild to create $tbName"; return 0  ;;
                     esac
                  done
            else 
            newTableRecord=${newTableRecord}:${colName}
            echo Enter Data Type 
            select option in "string" "number" "Exit"
            do 
               if [[ $option = "Exit" || -z "$option" ]]
                  then 
                  echo "faild to create $tbName"
                  return 0;
               else 
                  newTableRecord=${newTableRecord}:${option};
                  break;
               fi 
            done 
            i=`expr $i + 1`
            fi 
            done 

            echo "$tbName Table has been created successfully"
            touch $tbName 2> /dev/null
            touch $tbName_meta 2> /dev/null
            echo $newTableRecord > ${tbName}_meta
 fi 
return 1 
}



