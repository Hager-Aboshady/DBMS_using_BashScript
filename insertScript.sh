#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "$BASH_SOURCE" )" ; pwd;)

source $SCRIPT_DIR/helpers.sh                                  # as i need isValid isNum isExist functions 

function insertFun
{
flag=0   #Nothing inserted

read -p "Please Enter the Table Name to Insert into " tbName

isValid $tbName 
validResult=$?

if [ $validResult -eq 1 ]
  then
      isExist $tbName $PWD
      existResult=$?
     
      if [ $existResult -ne 0 ]
        then                              
           metaFile=`echo $tbName"_meta"`
           
           numOfCols=`cut -d ":"  -f 1 $metaFile`                    #1st field always contains the number of cols


           loopCols=$(($numOfCols+$numOfCols))                       #as we have cols for data and cols for meta data         
         
           id=""                                                      
           row=""
           res=1
           while [ $res -ne 0 ]
             do
                read -p "Please Enter a unique value in the ID column " id
                isNum $id
                idRes=$?
                if [ $idRes -eq 1 ]
                  then
                 
                     res=`cut -d ":" -f 1 $tbName | grep -w $id | awk 'END { print NR }' `

                 fi 
             
            done          
                                          #hna elmafrood htkon res=0 y3ni uni id  
            
            
           row=`echo $row$id:`                                                                   
           i=4                                         
           j=$((i+1)) 
                      
           while [ $i -le $loopCols ]
            do 
              colName=`cut -d ":" -f $i $metaFile`
              read -p "Please Enter the value in the $colName column " insertedValue                           
              colType=`cut -d ":" -f $j $metaFile` 
              if [[ $colType == "string" ]];
                 then       
                    isValid $insertedValue             #to check it is string 
                    validValue=$?
                      
                    if [ $validValue -eq 1 ]
                       then                                                         
                                  if [ $i -eq $loopCols ]
                                    then 
                                        row=`echo $row$insertedValue`
                                  else 
                                       row=`echo $row$insertedValue:`
                                  fi
                                         
                                   j=$((i+1))                                                                 
                                   i=$((i+2))
                                   j=$((i+1))
                                                        
                                  # row=`echo $row$insertedValue:`
  
                      
                    fi
              
                   
             elif [[ $colType == "number" ]];
                 then  
                       
                     isNum $insertedValue
                     numValue=$?
                       
                     if [ $numValue -eq 1 ]
                        then
                        
                                  if [ $i -eq $loopCols ]
                                   then 
                                       row=`echo $row$insertedValue`
                                  else 
                                       row=`echo $row$insertedValue:`
                                  fi
                                  j=$((i+1))
                                  i=$((i+2)) 
                                  j=$((i+1))  
                                  
                               
                                 #row=`echo $row$insertedValue:`
                        
                    fi
              
              
            else
                echo "Please Enter a Value with a Valid Type $colType " 
            fi
            
            done         
            echo $row>> $tbName
            echo "New Row has been added Successfully "
            flag=1          #new row is inserted

    else echo "This is Table is Not Exist "    
    fi 
else echo "Please Enter A valid Table Name "         
fi   


return $flag
}










