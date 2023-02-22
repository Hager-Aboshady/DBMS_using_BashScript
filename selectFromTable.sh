#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "$BASH_SOURCE" )" ; pwd;)
source $SCRIPT_DIR/helpers.sh


function selectRow
{
  #db_path=$PWD/Databases/$1/
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

  echo "Enter Row Condition Name To Filter by" 
  choices=$colNames" All"
  select selctedColf in $choices
  do
   if [ -z "$selctedColf" ]
   then 
     echo "you selected wrong number try again "
   elif [ $selctedColf = "All" ]
   then 
    break 
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

  echo "Enter Column Name and Value To Display " 
  choices=$colNames" All"
  select selctedCol in $choices
  do
    if [ -z "$selctedCol" ]
    then 
     echo "you selected wrong number try again " 
    else 
    break 
    fi 
  done 

  if [[ $selctedCol = "All" && $selctedColf = "All" ]]
  then 
    echo " "
    echo  $colNames
    echo "-------------------------------------"
    cat $tb_path | tr '\:' '\|' 
  elif [ $selctedColf = "All" ]
   then
    echo " "
    echo $selctedCol
    echo "-------------------------------------"
    slectedColNum=$(awk -v selctedCol="$selctedCol" 'BEGIN { FS = ":" } ; { for ( i=2 ; i<NF; i+=2) if($i == selctedCol) print i}' $meta_loc)
    slectedColNum=$(($slectedColNum / 2))
    awk -F : -v slectedColNum="$slectedColNum" -v valuef="$valuef" 'BEGIN{ FS = ":"} {print $slectedColNum ; printf "\n" }' $tb_path
  elif [ $selctedCol = "All" ]
   then 
    echo " "
    echo $colNames
     echo "-------------------------------------"
    slectedColNumf=$(awk -v selctedColf="$selctedColf" 'BEGIN { FS = ":" } ; { for ( i=2 ; i<NF; i+=2) if($i == selctedColf) print i}' $meta_loc)
    slectedColNumf=$(($slectedColNumf / 2))
    awk -F : -v slectedColNumf="$slectedColNumf" -v valuef="$valuef"  '$slectedColNumf==valuef {print}' $tb_path | sed  's/\:/\|/g' 
  else 
    echo " "
    echo $selctedCol
    echo "-------------------------------------"
    slectedColNumf=$(awk -v selctedColf="$selctedColf" 'BEGIN { FS = ":" } ; { for ( i=2 ; i<NF; i+=2) if($i == selctedColf) print i}' $meta_loc)
    slectedColNum=$(awk -v selctedCol="$selctedCol" 'BEGIN { FS = ":" } ; { for ( i=2 ; i<NF; i+=2) if($i == selctedCol) print i}' $meta_loc)
    slectedColNum=$(($slectedColNum / 2))
    slectedColNumf=$(($slectedColNumf / 2))
    awk -F : -v slectedColNumf="$slectedColNumf" -v slectedColNum="$slectedColNum" -v valuef="$valuef" 'BEGIN{ FS = ":" ; OFS = "|"} {if ($slectedColNumf==valuef) print $slectedColNum ;}' $tb_path
  fi 
     echo " "
}
