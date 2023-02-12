#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "$BASH_SOURCE" )" ; pwd;)

source $SCRIPT_DIR/helpers.sh 

function dropTableFun
{
flag=0
read -p "Please Enter the Name of the Table " tbName

isValid $tbName
valid=$?
if [ $valid -eq 1 ]
 then 
    isExist $tbName $PWD
    exist=$?
#echo "exist $exist"
    if [ $exist -eq 2 ]   #msh by3mlha b 1 
     then
         metaTable=`echo $tbName"_meta"` 
         rm $tbName
         rm $metaTable
         echo "The $tbName Table has been Deleted Successfully "
         
         flag=1    



    else "This Table is Not Exist "
    fi
else echo "Please Enter A valid Table Name "
fi  

return $flag
}

