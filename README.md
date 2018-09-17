
# GoPro Fusion Video File Date Adjuster
Modifies the modification date of the stitched GoPro video files to match the time they were taken, not the time that they were stitched. This makes these videos group together on the same date with the GoPro photos in Google Photos. (GoPro Fusion Studio saves "Date taken" for photos. Fusion Studio doesn't preserve "Date taken" for videos.)  
 
Takes date from unstitched files with names like GPFR0089.MP4 and changes the date on stitched files with names like VIDEO_0089.mp4

Optionally renames stiched files with original date in the filename. Just uncomment the line in the script. 

 
 ## Usage
 
     GoProCopyModificationDate.sh renderedFilesDir/ 100GFRNT/ 

## Sample output 

    $ ~/Pictures/Scripts/GoProFusionDateAdjuster/GoProCopyModificationDate.sh ./ /Volumes/Jerry/Unrendered/100GFRNT/
    touch -t 201808302210.00 ./VIDEO_0086.mp4
    touch -t 201808310053.28 ./VIDEO_0089.mp4
    touch -t 201808310348.53 ./VIDEO_0097.mp4
    touch -t 201808310426.08 ./VIDEO_0099.mp4
    touch -t 201808311105.54 ./VIDEO_0102.mp4
    touch -t 201808311228.54 ./VIDEO_0104.mp4
    touch -t 201808311234.14 ./VIDEO_0107.mp4
    touch -t 201808311235.42 ./VIDEO_0108.mp4
    touch -t 201808311241.23 ./VIDEO_0109.mp4
    touch -t 201808311307.13 ./VIDEO_0113.mp4
    touch -t 201808311434.17 ./VIDEO_0116.mp4
    touch -t 201808311513.13 ./VIDEO_0117.mp4
    touch -t 201808311600.51 ./VIDEO_0118.mp4

Tested on /bin/bash on macOS 10.13.6 
## Known issues

+ Doesn't work if your directory has spaces in it 
