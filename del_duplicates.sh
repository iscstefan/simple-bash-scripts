#!/bin/bash
if [ "$1" = "--help" ]
then
  echo "./del_duplicates.sh <file path> <extension>"
  exit 0
fi
if [ -z "$1" -o -z "$2" -o ! -z "$3" ]
then
  echo "missing arguments or too many arguments. Please use --help"
  exit 1
else
  if [ ! -d "$1" ]
  then
    echo "folder does not exist"
    exit 1
  fi
fi
cd "$1"
for i in *
do
  case "$i" in
    *."$2")
    if [[ "$i" = *\(* ]]
    then
      echo $( echo "$i" | cut -d "(" -f 1 )
      rm "$i"
    fi
    ;;
  esac
done
echo "succes"
