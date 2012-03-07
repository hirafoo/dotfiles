cd .opt/autojump_v12/
_fpath=`echo $fpath | cut -d " " -f 1`
sudo cp _j $_fpath
mkdir -p ~/.autojump/share/man/man1
$SHELL ./install.zsh --prefix ~/.autojump
