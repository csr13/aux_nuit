#!/bin/bash

if [ -x ~/.ssh/config ]; then
    echo "{+} ssh config found";
    exit 0;
fi

cp "$(pwd)/ssh/config" ~/.ssh/config && chown 644 ~/.ssh/config
