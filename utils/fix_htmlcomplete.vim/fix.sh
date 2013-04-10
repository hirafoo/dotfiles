#!/bin/sh

sudo cp /usr/local/vim/share/vim/vim73/autoload/htmlcomplete.vim{,_org}
sudo patch -p0 < fix.patch
