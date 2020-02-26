#!/bin/bash
echo "folder=<file path> prefix=<prefix>"
for i in "$@"
do
  case "$i" in
    folder=*)
    folder=$( echo "$i" | cut -d = -f 2 )
    ;;
    prefix=*)
    prefix=$( echo "$i" | cut -d = -f 2 )
    ;;
  esac
done
if [ -z "$folder" -o -z "$prefix" ]
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
for i in *
do
  if test -f "$i" -o -d "$i"
  then
    echo "$i"
    mv "$i" "$prefix - $i"
  fi
done
