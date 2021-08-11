#!/bin/bash

for et in $(ls . | sort); do
    if [ $et == "git" ]; then
        continue
    fi
    # être certain
    exe="$et/start.sh"
    if [ -f $exe ]; then
        if [[ ! "dot" =~ $et ]]; then
            # rendre exécutable
            chmod +x $exe;
            # exécuter l'exécutable
            /bin/bash "$(pwd)/$exe"
        fi
        if [[ "vim" =~ $et ]]; then
            # existe-t-il ??
            vimrc="$(pwd)/$et/.vimrc"
            if [ -f $vimrc ]; then
                # ça existe
                # copier le fichier de configuration
                cp -v $vimrc ~/
            fi
        fi
    # choses cachées ..
    elif [ $et == "dot" ]; then 
        # explicite
        escape=$(ls -A "$(pwd)/$et"| egrep '^\.');
        for toi in $escape; do
            moi="$et/$toi";
            loin="$(pwd)/$moi";
            if [ -f $loin ]; then
                cp -v $loin ~/;
            fi # je ne sais pa
        done
    fi # je ne sais plus 
done 
# je suis perdu
    
