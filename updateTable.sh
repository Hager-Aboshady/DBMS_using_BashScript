#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "$BASH_SOURCE" )" ; pwd;)
source $SCRIPT_DIR/helpers.sh


function updateTable
{
  db_path=$PWD/

  typeset -i res=0 valid=0 exist=1 isNum=0 numOfCol

   read -p "Please Enter The name of the Table " tbName
   isValid $tbName

 if [ $? -eq 1 ] 
 then
    valid=1
 else 
    echo "$tbName Table Name ivalid !"
    valid=0
    return 0 
 fi 

 isExist $tbName $db_path

 if [ $? -eq 0 ]
  then
     echo $tbName "Table is not exist !"
     return 0 
  fi 

  tb_path=${db_path}${tbName}
  meta_loc=${tb_path}_meta 
  numOfCol=$(awk 'BEGIN { FS = ":" } ; {print $1}' $meta_loc)
  colNames=$(awk 'BEGIN { FS = ":" } ; { for ( i=2 ; i<NF; i+=2) print $i }' $meta_loc)
  echo "Enter Column Name To Filter by" 
  select selctedColf in $colNames
  do
   if [ -z "$selctedColf" ]
   then 
     echo "you selected wrong number try again "
   else 
    read -p  "Enter value for $selctedColf " valuef 
    curColTypef=$(awk -v x="$selctedColf" 'BEGIN { FS = ":" } ; { for ( i=2 ; i<NF; i+=2) if($i == x) print $(i+1)}' $meta_loc)
    checkType $valuef $curColTypef
    if [ $? -eq 1 ]
      then 
        break 
    else 
        echo "Type You Enterd Does Not Match The Column Type Try Again "
    fi 
   fi 
  done 
  echo "Enter Column Name and Value To Set " 
  select selctedCol in $colNames
  do
  
    if [ -z "$selctedCol" ]
    then 
     echo "you selected wrong number try again "
    else 
     read -p  "Enter value for $selctedCol " value 
     curColType=$(awk -v x="$selctedCol" 'BEGIN { FS = ":" } ; { for ( i=2 ; i<NF; i+=2) if($i == x ) print $(i+1)}' $meta_loc)
     checkType $value $curColType
     if [ $? -eq 1 ]
     then 
      if [ $selctedCol = "ID" ]
      then 
       rep=$(cut -d : -f 1 $tb_path  | grep -w $value | wc -l)
       if [ $rep = "0" ] 
       then
       break 
       else 
       echo This ID value is already exist 
       echo "Enter Column Name and Value To Set " 
       fi
       else 
       break 
      fi 
    else 
      echo "Type You Enterd Does Not Match The Column Type Try Again "
    fi 
   fi 
  done 

  slectedColNumf=$(awk -v selctedColf="$selctedColf" 'BEGIN { FS = ":" } ; { for ( i=2 ; i<NF; i+=2) if($i == selctedColf) print i}' $meta_loc)
  slectedColNum=$(awk -v selctedCol="$selctedCol" 'BEGIN { FS = ":" } ; { for ( i=2 ; i<NF; i+=2) if($i == selctedCol) print i}' $meta_loc)
  slectedColNum=$(($slectedColNum / 2))
  slectedColNumf=$(($slectedColNumf / 2))
  awk -F : -v slectedColNumf="$slectedColNumf" -v slectedColNum="$slectedColNum" -v valuef="$valuef" -v value="$value" '$slectedColNumf==valuef {$slectedColNum = value}1' $tb_path > ${db_path}temp && mv ${db_path}temp $tb_path 
  sed -i 's/ /\:/g' $tb_path
  echo "Columns has been updated Successfully :)"
  #cat $tb_path
 
}