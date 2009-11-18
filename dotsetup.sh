#!/bin/sh

files=`ls -ad .[a-z]*`

for file in $files
do
    rm -rfv ~/$file
done

for file in $files
do
    ln -sv $PWD/$file ~/$file
done
