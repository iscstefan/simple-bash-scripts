#!/bin/sh
echo "folder=<file path> extension=<extension> name=<name> start=<start> digits=<digits>"
for i in "$@"
do
  case "$i" in
    folder=*)
    folder=$( echo "$i" | cut -d = -f 2 )
    ;;
    extension=*)
    extension=$( echo "$i" | cut -d = -f 2 )
    ;;
    name=*)
    name=$( echo "$i" | cut -d = -f 2 )
    ;;
    start=*)
    start=$( echo "$i" | cut -d = -f 2 )
    ;;
    digits=*)
    digits=$( echo "$i" | cut -d = -f 2 )
    ;;
  esac
done
if [ -z "$folder" -o -z "$extension" -o -z "$name" -o -z "$start" -o -z "$digits" ]
then
  echo "missing arguments"
  exit 1
fi
if [ ! -d "$folder" ]
then
  echo "folder $folder not found"
  exit 1
fi
cd "$folder"
for i in $( ls -A )
do
  if [ -f "$i" ]
  then
    case "$i" in
      *.$extension)
      index="$start"
      while test "${#index}" -lt "$digits"
      do
        index="0$index"
      done
      mv "$i" "$name$index.$extension"
      start=$(expr "$start" + 1)
      ;;
    esac
  fi
done
