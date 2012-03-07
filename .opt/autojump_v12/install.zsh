#! /bin/zsh
#Copyright Joel Schaerer 2008, 2009
#This file is part of autojump

#autojump is free software: you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation, either version 3 of the License, or
#(at your option) any later version.
#
#autojump is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License
#along with autojump.  If not, see <http://www.gnu.org/licenses/>.

function show_help {
        echo "./install.sh [--prefix /usr/local]"
}

prefix=/usr

#command line parsing
while true; do
    case "$1" in
      -h|--help|-\?) show_help; exit 0;;
      -p|--prefix) if [ $# -gt 1 ]; then
            prefix=$2; shift 2
          else
            echo "--prefix or -p require an argument" 1>&2
            exit 1
          fi ;;
      --) shift; break;;
      -*) echo "invalid option: $1" 1>&2; show_help; exit 1;;
      *)  break;;
    esac
done

echo "Installing main files to ${prefix} ..."

mkdir -p ${prefix}/share/autojump/
cp icon.png   ${prefix}/share/autojump/
cp autojump.1 ${prefix}/share/man/man1/

_pwd=`pwd`
ln -s "${_pwd}/jumpapplet" $HOME/bin/
ln -s "${_pwd}/autojump"   $HOME/bin/

# autocompletion file in the first directory of the FPATH variable
fail=true
for f in $fpath
do
    sudo cp _j $f && fail=false && break
done
if $fail
then
    echo "Couldn't find a place to put the autocompletion file :-("
    echo "Still trying to install the rest of autojump..."
else
    echo "Installed autocompletion file to $f"
fi
