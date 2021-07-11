#!/bin/bash

for et in $(ls . | sort); do
    if [ $et == "git" ]; then
        continue
    fi
    exe="$et/start.sh"
    if [ -f $exe ]; then
        if [[ ! "dot" =~ $et ]]; then
            chmod +x $exe;
            /bin/bash "$(pwd)/$exe"
        fi
        if [[ "vim" =~ $et ]]; then
            vimrc="$(pwd)/$et/.vimrc"
            if [ -f $vimrc ]; then
                cp -v ~/.vimrc $vimrc
            fi
        fi
    elif [ $et == "dot" ]; then 
        escape=$(ls -A "$(pwd)/$et"| egrep '^\.');
        for toi in $escape; do
            moi="$et/$toi";
            loin="$(pwd)/$moi";
            if [ -f $loin ]; then
                cp -v ~/ $loin;
            fi
        done
    fi 
done

    
