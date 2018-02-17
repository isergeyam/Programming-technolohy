HELP=$'Usage:\n-d(--directory) - set name of the directory\n-a(--archive) - set name of archive (default - name of directory)\n-e(--extension) - set extension\n-h(--help) - show this massage'
while [[ $# -gt 0 ]]
do
key="$1"
case $key in
    -e|--extension)
    EXTENSION="$EXTENSION$2\\|"
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
	-h|--help)
		echo "$HELP"
		exit 0 
		;;
	*)
		echo "Invalid arguments. $HELP"
		exit 1
esac
done
if [ -z ${DIRECTORY+x} ] || [ -z ${EXTENSION+x} ]
then
		echo "Invalid arguments. $HELP"
		exit 1
	fi
if [ -z ${ARCHIVE+x} ]
then
	ARCHIVE=$(basename $DIRECTORY)
fi
EXTENSION=".*\.\($EXTENSION\\)"
mkdir -p $DIRECTORY
find $HOME -path $(realpath $DIRECTORY) -prune -o -type f -regextype sed -regex "$EXTENSION" -exec sh -c 'dir1=$(dirname "$0" );dir=$(realpath --relative-to=$HOME $dir1); mkdir -p "$1/$dir";cp "$0" "$1/$dir"' {} $DIRECTORY \;
tar -cf $ARCHIVE.tar $DIRECTORY
echo done
