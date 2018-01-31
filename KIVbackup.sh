#!/bin/sh
script_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
cd $script_dir

if [ ! -e syntax ]; then
    mkdir syntax
fi
if [ ! -e plugin ]; then
    mkdir plugin
fi
if [ ! -e autoload ]; then
    mkdir autoload
fi

cp ~/.vim/syntax/tsf.vim syntax/tsf.vim
cp ~/.vim/plugin/KIV.vim plugin/KIV.vim
cp ~/.vim/autoload/KIV/KIV.vim autoload/KIV.vim
cp ~/.vim/autoload/KIV/KIVmap.tsf autoload/KIVmap.tsf
cp ~/.vim/autoload/KIV/KIVchar.tsf autoload/KIVchar.tsf
cp ~/.vim/autoload/KIV/KIVreadme.md README.md
