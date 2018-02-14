#!/bin/bash
#Usage: -d(--directory) - set name of the directory
#				-a(--archive) - set name of archive(default - directory)
#				-e(--extension) - set extension
while [[ $# -gt 0 ]]
do
key="$1"
case $key in
    -e|--extension)
    EXTENSION="$2"
    shift 
    shift 
    ;;
	-a|--archive)
		ARCHIVE="$2"
    shift 
    shift 
    ;;
	-d|--directory)
		DIRECTORY="$2"
    shift 
    shift 
    ;;
	*)
		echo "Invalid arguments. Usage:
-d(--directory) - set name of the directory
-a(--archive) - set name of archive(default - directory)
-e(--extension) - set extension
"
		exit 1
esac
done
mkdir $DIRECTORY
find ~/ -path $(pwd $DIRECTORY) -prune -o -type f -name "*.$EXTENSION" -exec cp {} $DIRECTORY \;
tar -cf $ARCHIVE.tar $DIRECTORY
echo done
