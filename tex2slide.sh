#!/bin/bash
#
# tex2keynote.sh
#
# A simple shell/Apple script to copy text from Keynote, compile it using pdflatex,
# and paste it back into Keynote as a pdf snippet.
#
# To create MacOS app, execute:
#  mkdir -p Tex2Keynote.app/Contents/MacOS; cp tex2keynote.sh Tex2Keynote.app/Contents/MacOS/Tex2Keynote; chmod +x Tex2Keynote.app/Contents/MacOS/Tex2Keynote

FONTSIZEPT=32
PDFLATEX=/Library/TeX/texbin/pdflatex
OSASCRIPT=/usr/bin/osascript
WORKDIR=/tmp
FNAME="tex2keynote-tmp"
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
