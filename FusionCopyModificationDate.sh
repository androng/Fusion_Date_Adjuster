#
# Modifies the modification date of the stitched GoPro video files to match the 
# time they were taken, not the time that they were stitched. This makes these videos
# group together on the same date with the GoPro photos in Google Photos. 
# (GoPro Fusion Studio saves "Date taken" for photos. Fusion Studio doesn't preserve 
# "Date taken" for videos.)  
# 
# Takes date from unstiched files with names like GPFR0089.MP4 and changes 
# the date on stitched files with names like  like VIDEO_0089.mp4
#
# Optionally renames stiched files with original date in the filename 
# 
# Usage: FusionCopyModificationDate.sh renderedFilesDir/ 100GFRNT/ 

 #!/bin/bash

if [ "$1" == "" ] || [ "$2" == "" ]; then
    echo $'Missing arguments.\nUsage: FusionCopyModificationDate.sh renderedFilesDir/ 100GFRNT/\n'
    exit 1
fi
if [ "$3" != "" ]; then
    echo $'Too many arguments.\nUsage: FusionCopyModificationDate.sh renderedFilesDir/ 100GFRNT/\n'
    exit 1
fi



for INPUT in $(ls $1VIDEO_*); do
	
	INPUT_BASE_NAME=$(basename $INPUT)
	VIDEO_NUMBER=$(echo $INPUT_BASE_NAME | cut -c 7-10)    
    UNSTITCHED_FILE_NAME=$2GPFR$VIDEO_NUMBER.MP4
    UNSTITCHED_FILE_NAME_LS=$(ls $UNSTITCHED_FILE_NAME)
    
    #if unstitched file not found, move on
    if [ "$?" != 0 ] ; then
    	continue
    fi 
    
    UNSTITCHED_FILE_MODIFICATION_DATE=$(date -r $UNSTITCHED_FILE_NAME "+%Y%m%d%H%M.%S")
    
    echo touch -t $UNSTITCHED_FILE_MODIFICATION_DATE $INPUT
    touch -t $UNSTITCHED_FILE_MODIFICATION_DATE $INPUT
	
	INPUT_FILE_EXTENSION="${INPUT_BASE_NAME##*.}"  # mp4
	INPUT_FILE_NAME_WITHOUT_EXT="${INPUT_BASE_NAME%.*}" # VIDEO_0089
		
	# Rename file with modification time 
# 	mv $INPUT $1$INPUT_FILE_NAME_WITHOUT_EXT\_$UNSTITCHED_FILE_MODIFICATION_DATE.$INPUT_FILE_EXTENSION
done

