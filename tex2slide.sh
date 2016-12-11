#!/bin/bash
#
# Copyright 2016 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


# tex2slide.sh
#
# A simple shell/Apple script to copy text from Keynote, compile it using 
# pdflatex, and paste it back into Keynote as a pdf snippet. As is, the 
# script works for Keynote, but it should work for Powerpoint and other
# applications by replacing Keynote below with another name.
#
# To create MacOS app, execute:
#  mkdir -p Tex2Slide.app/Contents/MacOS
#  cp tex2slide.sh Tex2Slide.app/Contents/MacOS/Tex2Slide
#  chmod +x Tex2Slide.app/Contents/MacOS/Tex2Slide

FONTSIZEPT=32
PDFLATEX=/Library/TeX/texbin/pdflatex
OSASCRIPT=/usr/bin/osascript
WORKDIR=/tmp
FNAME="tex2slide-tmp"
TEXFNAME=$WORKDIR'/'$FNAME'.tex'
PDFFNAME=$WORKDIR'/'$FNAME'.pdf'

# Activate Keynote and copy to clipboard
$OSASCRIPT -e 'tell application "Keynote" to activate' 
$OSASCRIPT -e 'tell application "System Events" to keystroke "c" using {command down}'

# Write latex file, modify to customize
cat > $TEXFNAME << EOF
\documentclass[preview]{standalone}
\usepackage[usenames]{color}
\usepackage{amssymb} 
\usepackage{amsmath}
\usepackage{arev}
\usepackage[T1]{fontenc}
\begin{document}
EOF
echo '\fontsize{'$FONTSIZEPT'}{40}' >> $TEXFNAME
# Alternative if pbpaste not available:
# $OSASCRIPT -e 'do shell script ("echo " & (the clipboard) & " >> $TEXFNAME")'
/usr/bin/pbpaste >> $TEXFNAME
echo '\end{document}' >> $TEXFNAME

# Compile latex file
cd $WORKDIR
$PDFLATEX $TEXFNAME

# Copy PDF from Preview to clipboard, paste into Keynote
echo "Opening preview"
/usr/bin/open -a Preview $PDFFNAME
$OSASCRIPT -e 'tell application "Preview" to activate'
$OSASCRIPT -e 'tell application "System Events" to keystroke "c" using {command down}'
$OSASCRIPT -e 'tell application "Keynote" to activate' 
$OSASCRIPT -e 'tell application "System Events" to keystroke "v" using {command down}'
