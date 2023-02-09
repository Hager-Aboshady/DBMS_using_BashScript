#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "$BASH_SOURCE" )" ; pwd;)

source $SCRIPT_DIR/helpers.sh

function createTable
{
 read -p "Please Enter The name of the Table " tbName
 isValid $tbName
 valid=$?
 if [ $valid -eq 1 ] then
 
     isExist $tbName $PWD
     exist=$?
   
     if [ $exist -eq 0 ] then
     
   
      #NumCol:1stColName:1stColType:2ndColName:2ndColType
      typeset -i numCol
      read -p "Please Enter Number of Columns " numCol
      isNum $numCol
      
      if [ $? -eq 1 ] then 
      
         newTableRecord=${numCol}:
         i=1
         
         while [ $i -le $numCol ]
           do 
            checkcolName $numCol $newTableRecord
            if [ $? -eq 1 ]
            then 
             newTableRecord=${newTableRecord}${numCol}:
             i=$i+1
             else 
              echo "faild to create $tbName"
              return 0;
              fi 
             done 
         
          echo "$tbName Table has been created successfully"
          echo $newTableRecord
          return 1 ;
          
         else echo "$tbName You should enter number !"
          return 0 ;
     fi
          else echo "$tbName Table is already exist !"
          return 0 ;
     fi
     else echo "$tbName Table Name ivalid !"
         return 0 ;
       
 fi
 
}

function checkcolName
{
     read -p "Enter $1 Column Name " colName
        isValid $1
        valid=$?
        if [ $? -eq 1 ]
        then 
         if [ $2 == * ":$1:"* ]
          then
             echo "This column name already exists"
             select op in "Try again" "exist"
             do 
              case $op in 
              "Try Again" addcolumn ;;
              "Exit") return 0;;
               esac
               done
              else 
              return 1 ;
              fi 
              else 
               echo "This column name invalid "
               select op in "Try again" "exist"
                do 
                 case $op in 
              "Try Again" addcolumn ;;
              "Exit") return 0;;
               esac
               fi 
}



