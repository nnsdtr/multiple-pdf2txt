#!/bin/bash
###################################################################################################
# PROJECT           : Fungi Barcode Publications: text mining aproach
#
# PROGRAM NAME      : multiple_pdf2txt.sh
#
# DESCRIPTION       : This script will parse all *.*pdf files inside
#                     a specified folder and turn them into *.*txt
#                     files for further text mining aproach.
#
# PURPOSE           : Extract text from multiple PDF files.
#
# AUTHOR            : NUNES,DT.
#
# LABORATORY        : Laboratorio de Biologia Molecular e Computacional de Fungos (ICB - UFMG)
#
# DATE CREATED      : 20171020
#
# VERSION           : 1.5
#
# BASH VERSION      : GNU bash, version 4.3.48(1)-release (x86_64-pc-linux-gnu)
#                     Copyright (C) 2013 Free Software Foundation, Inc.
#                     License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
#
# REVISION HISTORY  :
# Date        Author      Ref    Revision (Date in YYYYMMDD format)
# 20170818    NUNES,DT.     1    Version 1.0 finished.
# 20171101    NUNES,DT.     2    Version 1.5 finished (added timeout 30s and few minor modifications)
#
# PARAMETER:
#    INDATA - Path to the multiple PDF's folder
#
# SCRIPT DEPENDENCY: (PDFminer package tool: "pdf2txt.py")
#
# EXAMPLE CALLS:
#    (1) multiple_pdf2txt.sh /home/user/multiplePDF_folder
#    (2) multiple_pdf2txt.sh
###################################################################################################

#filearray=(/home/danieltn/Desktop/BASH/pdfminer/pub-name2number/*.pdf)
function elapsed_time {
  timeEND=$(date +%s)
  runtime=$((timeEND-timestart))
  printf "   ITERATION TIME: $(($runtime / 60)) minutes and $(($runtime % 60)) seconds elapsed.\n"
  duration="$SECONDS"
  printf "   OVERALL TIME: $(($duration/60/60/24)) days, $(($duration/60/60%24)) hours, $(($duration/60%60)) minutes and $(($duration%60)) seconds.\n\n"
}


# Check if parameter were or not used. If not, ask user for path.
var=$1
if [ -z "${var}" ]
then
  printf "\nPlease, insert bellow the path to the multiple PDF's folder:\n"
  read var
  printf "\n---------------------------------------\n"
  printf "Remember that you can also use path as a\nparameter for the script. Example call:\n\nmultiple_pdf2txt.sh /home/user/multiplePDF_folder"
  printf "\n---------------------------------------\n"
else
  printf "\n"
fi

# Check if path is valid. If not, show ErrorMesage.
if [ -d "$var" ]
then
  # Check if path last character is equal to "/". If so, remove it.
  j=$((${#var}-1))
  last_charact="${var:$j:1}"
  if [ "$last_charact" = "/" ]; then var="${var:0:-1}"; fi

  # Define path for all PDFs inside the specified folder:
  filespath="$var/*.pdf"

  # PDF files array is defined bellow:
  filesarray=($filespath)

  # Calculate the number of PDF files into the folder for further usage:
  num_pub=${#filesarray[@]}

  # Create folder names for the output files:
  out_fldname="pdf2txt_output-1/"
  out_fldname_base="pdf2txt_output"

  # Check if synonymous folder exists. If not, create it. If so, create one with other name.
  if [ ! -d $out_fldname ]
  then
    mkdir "$out_fldname"
  else
    i=1
    while [[ -d "$out_fldname_base-$i" ]]
    do
      let i++
    done
    out_fldname="$out_fldname_base-$i"
    mkdir "$out_fldname"
  fi

  # Change directory to output folder and create a tabular list of results:
  cd "$out_fldname"
  touch list_name_cnvrt.tab
  touch NotParsed.tab

  # For each PDF, parse, save correspondent .txt and append result on the tabular list.
  for (( i=0; i<${#filesarray[@]}; i++ ))
  do
    number=$(printf "%0${#num_pub}d" $i)
    pdfpath=${filesarray[$i]}
    pdfname="$(basename $pdfpath)"
    echo "Publication no.: ${number}      $pdfname"
    cd ..
    cd $var
    pdfsize=$(stat --printf="%s" $pdfname)
    cd ..
    cd "$out_fldname"
    # Parse PDF file:
    echo "   Parsing..."
    echo "   Filesize: $((pdfsize/1000)) KB"
    timestart=$(date +%s)

    timeout 30s pdf2txt.py -A -o "$pdfname.txt" "$pdfpath"
    exit_status=$?
    # Append PDF name and correspondent .txt file number on the list:
    if [[ $exit_status -eq 124 ]]
    then
      echo "   *** File not parsed! Terminated ***"
      printf "$number\t$pdfname.txt\t$pdfsize\n" >> NotParsed.tab
      rm "$pdfname.txt"
      cd ..
      cd $var
      mv $pdfname "NonParsed_$pdfname"
      cd ..
      cd "$out_fldname"
    else
      echo "   Parsed!"
      printf "$number\t$pdfname.txt\n" >> list_name_cnvrt.tab
    fi
    elapsed_time
  done

  printf "\nJob has been completed!\n\nFiles have been saved in the folder /$out_fldname\n\n"

else
  printf "\nError. Invalid path parameter!\nPlease try again...\n\n"

fi
