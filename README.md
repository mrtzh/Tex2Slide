# Tex2Slide

A convenient minimalistic tool to get latex snippets into your presenter tool.

## Install

1. Create a MacOs app. From the command line, execute:

```
mkdir -p Tex2Slide.app/Contents/MacOS 
cp tex2slide.sh Tex2Slide.app/Contents/MacOS/Tex2Slide
chmod +x Tex2Slide.app/Contents/MacOS/Tex2Slide
```

2. Drag/drop Tex2Slide app into Finder bar.


## Usage

1. Select any valid latex snippet from inside Keynote, e.g., from your Presenter
notes.

![Step 1](/assets/step1.jpg?raw=true "Step 1")

2. Click Tex2Slide icon. Done.

![Step 2](/assets/step2.jpg?raw=true "Step 2")

## Requirements

1. pdflatex --- set correct path in `tex2slide.sh`. Default: `/Library/TeX/texbin/pdflatex`.
