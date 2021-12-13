#
# Modifies the modification date of the encoded GoPro Max video files to match the 
# time they were taken, not the time that they were reencoded. This makes these videos
# group together on the same date with the GoPro photos in Google Photos or Apple Photos. 
# (GoPro Player saves "Date taken" for photos. GoPro Player doesn't preserve 
# "Date taken" for videos.)  
# 
# Takes date from .360 files with names like GS010010.mp4 and changes 
# the date on reencoded files.
#
# Also renames encoded files with original date in the filename for redundancy. 
# i.e. the date is stored in both the filename AND the "modification date".  
# 
# Usage: MaxCopyModifyDate.sh encodedFilesDir folderWith360Files 
#
# Files Before: 
#     folderWith360Files/GS010010.360 
#     Date Taken: 2021-12-03 19:23:40
#
#     encodedFilesDir/GS010010.mp4 
#     Date created:  2021-12-11 21:23:29
#     Date modified: 2021-12-11 21:23:29
#
# File after: 
#     folderWith360Files/GS010010.360  <-- Not changed
#     Date Taken: 2021-12-03 19:23:40  <-- Not changed
#
#     encodedFilesDir/MAX_2021-12-08_18-37-42.mp4 <-- changed 
#     Date created:  2021-12-03 19:23:40   <-- not changed on Windows, changed on macOS
#     Date modified: 2021-12-03 19:23:40   <-- changed
#


 #!/bin/bash

if [ "$1" == "" ] || [ "$2" == "" ]; then
    echo $'Missing arguments.\nUsage: MaxCopyModifyDate.sh encodedFilesDir/ folderWith360Files/\n'
    exit 1
fi
if [ "$3" != "" ]; then
    echo $'Too many arguments.\nUsage: MaxCopyModifyDate.sh encodedFilesDir/ folderWith360Files/\n'
    exit 1
fi

ENCODED_FILE_DIR=$1
RAW_FILE_DIR=$2

### Add trailing slash if needed
length=${#ENCODED_FILE_DIR}
last_char=${ENCODED_FILE_DIR:length-1:1}

[[ $last_char != "/" ]] && ENCODED_FILE_DIR="$ENCODED_FILE_DIR/"; :

### Add trailing slash if needed
length=${#RAW_FILE_DIR}
last_char=${RAW_FILE_DIR:length-1:1}

[[ $last_char != "/" ]] && RAW_FILE_DIR="$RAW_FILE_DIR/"; :


for INPUT in $(ls "$ENCODED_FILE_DIR" ); do
	echo Input: $INPUT
	INPUT_BASE_NAME=$(basename $INPUT)
	INPUT_FILE_EXTENSION="${INPUT_BASE_NAME##*.}"  # mp4
	INPUT_FILE_NAME_WITHOUT_EXT="${INPUT_BASE_NAME%.*}" # GS010010
    UNSTITCHED_FILE_NAME=$RAW_FILE_DIR$INPUT_FILE_NAME_WITHOUT_EXT.360

    #if unstitched file not found, move on
    if [ "$?" != 0 ] ; then
    	continue
    fi 
    
    # generate date in the format that "touch" requires
    UNSTITCHED_FILE_MODIFICATION_DATE=$(date -r $UNSTITCHED_FILE_NAME "+%Y%m%d%H%M.%S")

    if [ "$?" != 0 ] ; then
    	continue
    fi 

    # generate date with seperators so that it is more readable in a filename 
    UNSTITCHED_FILE_MODIFICATION_DATE_FOR_FILE_NAME=$(date -r $UNSTITCHED_FILE_NAME "+%Y-%m-%d_%H-%M-%S")


    echo touch -t $UNSTITCHED_FILE_MODIFICATION_DATE $ENCODED_FILE_DIR$INPUT
    touch -t $UNSTITCHED_FILE_MODIFICATION_DATE $ENCODED_FILE_DIR$INPUT
			
	# Rename file with modification time 
 	mv $ENCODED_FILE_DIR$INPUT $ENCODED_FILE_DIR'MAX'\_$UNSTITCHED_FILE_MODIFICATION_DATE_FOR_FILE_NAME.$INPUT_FILE_EXTENSION
    
done

