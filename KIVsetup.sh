#!/bin/sh
script_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
cd $script_dir

if [ ! -e ~/.vim/syntax ]; then
    mkdir ~/.vim/syntax
fi
if [ ! -e ~/.vim/plugin ]; then
    mkdir ~/.vim/plugin
fi
if [ ! -e ~/.vim/autoload ]; then
    mkdir ~/.vim/autoload
fi

cp syntax/tsf.vim ~/.vim/syntax/tsf.vim
cp plugin/KEV3.vim ~/.vim/plugin/KEV3.vim
cp autoload/KEV3.vim ~/.vim/autoload/KEV3.vim
cp autoload/KIVmap.tsf ~/.vim/autoload/KIVmap.tsf
cp autoload/KIVchar.tsf ~/.vim/autoload/KIVchar.tsf
cp README.md ~/.vim/autoload/KIVreadme.md
