#!/usr/bin/env bash 
#first we do the links 
for f in $(find . -iname \*.md -print0 | xargs -0); do sed -i 's/\[[^]]*\](\([^)]*\).md)/\[\[\1\]\]/g' $f; done 
#then we do the pandoc converstion to dokuwiki syntax 
for f in $(find . -iname \*.md -print0 | xargs -0); do pandoc --wrap=preserve -f markdown -t dokuwiki "$f" -o "${f%.md}.txt"; done 
#finally we add the backslashes to perserve the linebreaks 
for f in $(find . -iname \*.txt -print0  | xargs -0); do sed -i -e 's/\([^=^ ^>]\)$/\1\\\\/g' -e 's/%%//g' -e 's/^$/\\\\/g' $f; done 
for f in $(find . -iname \*.md -print0 | xargs -0); do rm -rf $f; done 
