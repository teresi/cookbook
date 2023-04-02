#!/usr/bin/env bash

# compress input pdf
# writes the compressed copy to target directory
# appends the current date to the basename of the file

compression_levels=(/default /printer /prepress /ebook /screen)
script_path="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

_input_pdf=$script_path/../cookbook.pdf
_output_dir=$(realpath $script_path/../archive)
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
i) _input_pdf=${OPTARG};;
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
filename_in=$(basename -- $_input_pdf)
extension="${filename_in##*.}"
filename="${filename_in%.*}"
_date=$(date '+%Y%m%d')
_output_pdf=${filename}_${_date}.${extension}
_output_path=${_output_dir}/${_output_pdf}

echo ""
echo "compression:    ${compression}"
echo "input pdf:      ${_input_pdf}"
echo "output pdf:     ${_output_pdf}"

du_in=$(du -hs $_input_pdf)
du_arr=(${du_in// / })
size_in=${du_arr[0]}
echo "input size:     $size_in"

if [ ! -f "$_input_pdf" ]; then
	echo -e "\e[91mERROR  input file DNE: $_input_pdf \e[39m"
	exit 1
fi

gs -sDEVICE=pdfwrite \
   -dCompatibilityLevel=1.4 \
   -dPDFSETTINGS=$compression \
   -dNOPAUSE -dQUIET -dBATCH \
   -sOutputFile=$_output_path \
   $_input_pdf

du_out=$(du -hs $_output_path)
du_arr=(${du_out// / })
size_out=${du_arr[0]}
echo "output size:    $size_out"

echo ""
