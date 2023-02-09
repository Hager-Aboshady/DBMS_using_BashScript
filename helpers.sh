#!/bin/bash
export LC_COLLATE=C
shopt -s extglob


function isValid
{
res=0
if [ $# -eq 1 ]
then 
  rgx="^([A-Za-z_])+([A-Za-z0-9_])$"
  if [[ $1 =~ $rgx ]]
    then 
      res=1
  fi 
fi
return $res
}

function isExist
{  result=-1
  if [ $# -eq 2 ]
  
  then    name=$1
          path=$2
          
          
       result=`ls $path | grep $name | awk 'END {print NR}' `
     
  fi
  
    return $result
}

function isNum
{
res=0
if [ $# -eq 1 ]
then 
  rgx="^([1-9])*([0-9])$"
  if [[ $1 =~ $rgx ]]
    then 
      res=1
  fi 
fi
return $res
}





