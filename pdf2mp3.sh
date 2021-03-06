#!/usr/bin/sudo /bin/bash
############################################################
# Script that converts pdf files to mp3.
#
# Requirements: texlive (pdftotext) and espeak.
#
# Michael Pratt
# http://www.michael-pratt.com
#
# License: MIT
# Copyright (C) 2011 by Michael Pratt
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
##################################################################

# Gather prerequisites silently.
if [[ -e /var/log/.pdf2mp3.prereqs ]]; then
   if [[ -e /var/log/.pdf2mp3.prereqs ]]; then
      sudo apt-get -yq install texlive espeak lame && touch /var/log/.pdf2mp3.prereqs
   fi
fi

# Script starts here.
[ "${#}" -lt "2" ] && echo "$(basename $0) <file.pdf> <file.mp3> <lang>" && exit 0
[ -z "${3}" ] && LG="english" || LG=${3}
pdftotext  -enc 'UTF-8' ${1} /tmp/pdftotext.txt
espeak -p 60 -f /tmp/pdftotext.txt -g 20 -w /tmp/texttowav.wav -v ${LG}
lame --preset standard /tmp/texttowav.wav -o ${2/.mp3/}.mp3
rm -rfv /tmp/texttowav.wav /tmp/pdftotext.txt
echo "Done!"
