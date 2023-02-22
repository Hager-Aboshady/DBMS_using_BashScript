#!/bin/bash
export LC_COLLATE=C
shopt -s extglob


function isValid
{
res=0
if [ $# -eq 1 ]
then 
  word=${1%%*( )}
  rgx="^[A-Za-z_][A-Za-z0-9_]+$"
  if [[ $word =~ $rgx ]]
  then 
      res=1
  fi 
fi
return $res
}

function isExist
{  result=-1
   word=${1%%*( )}
  if [ $# -eq 2 ]
  then    
    name=$1
    path=$2    
    result=`ls $path | grep -w $name | awk 'END {print NR}' `
  fi
  
    return $result
}

function isNum
{
res=0
if [ $# -eq 1 ]
then 
  rgx="^[1-9][0-9]*$"
  if [[ $1 =~ $rgx ]]
    then 
      res=1
  fi 
fi
return $res
}

function checkType
{
if [ $2 = "string" ]
then 
     isValid $1
  else 
    isNum $1
fi
return $?
}
