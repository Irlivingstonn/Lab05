#!/bin/bash

function main(){
   # Checks if the input is less than 0 or greater than 5
   if [ "$#" -eq 0 ] || [ "$#" -gt 5 ]
   then
      printHelp
   else 
      identifying_flags "$@"
   
   fi

}


function identifying_flags(){

#printf "\n\ngetopts is done. \nValue of OPTARG is $OPTARG \nValue of OPTIND is $OPTIND\n\n"
f_operated_first=false
old_value=""

   local OPTIND opt i
   while getopts ":hf:r:" opt; do
      case "$opt" in
        h) printHelp;exit 1 ;;
        f) 
            f_operated_first=true
            old_value=$(search);;
        r) (replace f_operated_first old_value "$@");;
        \?) printHelp;exit 1 ;;
      esac
   done
   shift $(( OPTIND - 1 ))

}

function printHelp(){

   echo "Usage: namechange -f find -r replace \"string to modify\""
   echo " -f The text to find in the filename"
   echo " -r The replacement text for the new filename"

}


# Looks for specific thing in the title of the file
function search(){
input="$OPTARG"
last_letter_of_input="${input: -1}"

#input = "$OPTARG"
#end_input = "+"
#last_letter_of_input = ${$file : -1}


   if [ "$5" == "" ] || [ ! -f "$5" ]; then

      echo "AHHHH"
      echo "User must provide valid filename"
      printHelp

   fi



   # Checks if the user entered where to find the specific thing in the file
   if [[ "$OPTARG" = "" ]];
   then
      echo "in here"
      echo "User must provide search"
      printHelp
   fi


   if [[ "$OPTARG" = "\s" ]];
   then
      echo "$input"

   elif [[ "$last_letter_of_input" == "+" ]];
   then
      echo "$input"

   else
      echo "somehow in here"
      echo "User must provide valid input"
      printHelp; exit 1
   fi

}


# Replaces the certain thing in the file
function replace(){


   if [ "$7" == "" ] || [ ! -f "$7" ]; then

      echo "User must provide valid filename"
      printHelp

   fi


   if "$f_operated_first" ; then
      if [ "$4" = "\s"]; then

      mv "$7" "`echo $7 | sed -e "s/ /"$6"/"`"
#      echo "Renamed \"$7\" to " "`echo $7 | sed -e "s/ /"$6"/"`"
      else
         mv "$7" "`echo $7 | sed -e "s/"$4"/"$6"/"`"
      #echo "Renamed \"$7\" to " "`echo $7 | sed -e "s/"$4"/"$6"/"`"
fi


   else
      echo "Enter -f first then -r"
      printHelp

   fi
}



main "$@"
