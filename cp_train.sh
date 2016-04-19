#!/bin/bash

# do everything locally and copy back when done
if [ ! -f /mnt/data/copied ]
then
    cp -r /abide_data/data /mnt/data
    cp -r /abide_data/mask /mnt/mask
    echo "copied" > /mnt/data/copied
else
    echo "already copied"
fi

