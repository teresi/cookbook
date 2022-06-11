#!/usr/bin/env bash

# compress input pdf
# writes the compressed copy to target directory
# appends the current date to the basename of the file

compression_levels=(/default /printer /prepress /ebook /screen)
script_path="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

input_pdf=$script_path/../cookbook.pdf
output_dir=$script_path/../archive
level=4

# FUTURE probably should just take output filename to be more generic
usage(){
	echo "Usage: compress.bash [OPTION]..."
	echo "Compress input pdf and output with date appended to the name"
	echo "    e.g. myfile.ext --> myfile_YYYYMMDD.ext"
	echo ""
	echo "-i         input pdf file (../cookbook.pdf)"
	echo "-o         output directory (../archive/)"
	echo "-l         compression level, ascending [0...4] (4)"
}

while getopts i:o:l:h option
do
case "${option}"
in
i) input_pdf=${OPTARG};;
o) output_dir=${OPTARG};;
l) level=${OPTARG};;
h)
	if [ -z ${OPTARG} ]
	then
		usage
		exit 0
	fi
esac
done

compression=${compression_levels[$level]}
filename_in=$(basename -- $input_pdf)
extension="${filename_in##*.}"
filename="${filename_in%.*}"
date=$(date '+%Y%m%d')
output_pdf=$output_dir/${filename}_${date}.${extension}

echo ""
echo "compression:    ${compression}"
echo "input pdf:      ${input_pdf}"
echo "output pdf:     ${output_pdf}"

du_in=$(du -hs $input_pdf)
du_arr=(${du_in// / })
size_in=${du_arr[0]}
echo "input size:     $size_in"

# INFO dPrinted=false was supposed to keep links after compression
# but it does not appear to achieve that

gs -sDEVICE=pdfwrite \
   -dCompatibilityLevel=1.4 \
   -dPDFSETTINGS=$compression \
   -dNOPAUSE -dQUIET -dBATCH \
   -sOutputFile=$output_pdf \
   $input_pdf

du_out=$(du -hs $output_pdf)
du_arr=(${du_out// / })
size_out=${du_arr[0]}
echo "output size:    $size_out"

echo ""
