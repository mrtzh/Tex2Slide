# Tex2Keynote

An convenient minimalistic tool to get latex snippets into Keynote.

## Install

1. Create a MacOs app. From the command line, execute:

```
mkdir -p Tex2Keynote.app/Contents/MacOS 
cp tex2keynote.sh Tex2Keynote.app/Contents/MacOS/Tex2Keynote
chmod +x Tex2Keynote.app/Contents/MacOS/Tex2Keynote
```

2. Drag/drop Tex2Keynote app into Finder bar.


## Usage

1. Select any valid latex snippet from inside Keynote, e.g., from your Presenter
notes.

![Step 1](/assets/screen1tex2key.jpg?raw=true "Step 1")

2. Click Tex2Keynote. Done.

![Step 2](/assets/screen2tex2key.jpg?raw=true "Step 2")

## Requirements

1. pdflatex --- set correct path in `tex2keynote.sh`. Default: `/Library/TeX/texbin/pdflatex`.
