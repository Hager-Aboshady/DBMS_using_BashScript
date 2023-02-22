#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "$BASH_SOURCE" )" ; pwd;)

source $SCRIPT_DIR/helpers.sh    

function deleteFun
{

 

flag=0   #Nothing deleted yet

read -p "Please Enter the Table Name to Delete From  " tbName

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
              loopCols=$(($numOfCols+$numOfCols))
                i=2                       #1st col is the # of cols                                         
                j=$((i+1)) 
                 
                read -p "Please Enter the Column Name " colNameIn
                
                isValid $colNameIn 
                valid=$?
                
                if [ $valid -eq 1 ]
                  then
                  
                       while [ $i -le $loopCols ]
                        do
                                                
                           colName=`cut -d ":" -f $i $metaFile`
                           colType=`cut -d ":" -f $j $metaFile` 
                           
                            if [[ $colName == $colNameIn ]]
                              then 
                           
                                                    
                                 read -p "Please Enter the value for the $colNameIn  " value
                                 
                                 
                     
                                 if [[ $colType == "string" ]];
                                   then      
                                      isValid $value             #to check it is string 
                                      stringValue=$?
                      
                                     if [ $stringValue -eq 1 ]
                                       then                                                         
                                   
                                           k=$((i/2))    #col Name in table
                     
                                           awk -F : -v val="$value" -v k="$k" '!($k == val) {print}' $tbName > temp && mv temp $tbName
                                           
                                           echo "Deleteing has been done Successfully "
                                                        
                                       
                                     fi
              
                   
                                 elif [[ $colType == "number" ]];
                                    then  

                                        isNum $value
                                        numValue=$?
                       
                                       if [ $numValue -eq 1 ]
                                         then

                                             k=$((i/2))
                                             
                                          
                                             awk -F : -v val="$value" -v k="$k" '!($k == val) {print}' $tbName > temp && mv temp $tbName
                                             
                                             echo "Deleteing has been done Successfully "

          

                                    fi

                      
                             else 
                                  echo "Please Enter a Value with a Valid Type $colType " 
                          
                            fi
                    
                     fi 
            
                                           j=$((i+1))                                                                 
                                           i=$((i+2))
                                           j=$((i+1))        
                        done
                       
                  else echo "Please Enter a Valid Column Name ! "       
                fi
                
               

                 
          else echo "This Table is Not Exist "
       fi
     else echo "Please Enter a Valid Table Name ! "  
      
fi

return $flag
}



