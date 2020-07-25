#!/usr/bin/env bash

# compress input pdf

COMPRESSION_LEVELS=(/default /printer /prepress /ebook /screen)
SCRIPT_PATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

INPUT_PDF=$SCRIPT_PATH/../cookbook.pdf
OUTPUT_DIR=$SCRIPT_PATH/../archive
LEVEL=4

# TODO probably should just take output filename to be more generic
usage(){
	echo "Usage: compress.bash [OPTION]..."
	echo "Compress input pdf and output with data appended to name"
	echo ""
	echo "-i         input pdf file (../cookbook.pdf)"
	echo "-o         output directory (../archive/)"
	echo "-l         compression level, ascending [0...4] (4)"
}

while getopts i:o:l:h option
do
case "${option}"
in
i) INPUT_PDF=${OPTARG};;
o) OUTPUT_DIR=${OPTARG};;
l) LEVEL=${OPTARG};;
h)
	if [ -z ${OPTARG} ]
	then
		usage
		exit 0
	fi
esac
done

compression=${COMPRESSION_LEVELS[$LEVEL]}
filename_in=$(basename -- $INPUT_PDF)
extension="${filename_in##*.}"
filename="${filename_in%.*}"
date=$(date '+%Y%m%d')
output_pdf=$OUTPUT_DIR/${filename}_${date}.${extension}

echo "input pdf:      ${INPUT_PDF}"
echo "compression:    ${compression}"
echo "output pdf:     ${output_pdf}"

gs -sDEVICE=pdfwrite \
   -dCompatibilityLevel=1.4 \
   -dPDFSETTINGS=$compression \
   -dNOPAUSE -dQUIET -dBATCH \
   -sOutputFile=$output_pdf \
   $INPUT_PDF

du_out=$(du -hs $output_pdf)
du_arr=(${du_out// / })
size=${du_arr[0]}
echo "output size:    $size"
echo ""
