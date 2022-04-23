#!/bin/bash

# Script to create chia plot and verify size available on Mounted OS

firstFolder="$HOME/Documents/chia/"
finalFolder="/media/colin/hd/"
availableSize=$(df -h -BG --output=avail,target | grep \/$ | grep -Eo '[0-9]{1,4}')



if (($availableSize< 257)); then

    plotCount=$(find $firstFolder -type f -name "*.plot" | wc -l)
    sizeToDelete=$(du --block-size=1G $firstFolder | grep -Eo '[0-9]')

    echo "There is $availableSize G available on the disk. This is not enough space on the disk"
    echo "There are $plotCount plots in $firstFolder"
    read -p "Would you like to delete $sizeToDelete GB in $firstFolder files? (Y/n) " doDelete
    if [[ "$doDelete" =~ ^[Yy]$ ]]; then
        echo "Deleting files of"
        rm -rf /home/colin/Documents/chia/*
    elif [[ "$doDelete" == "" ]];then
        echo "Deleting files"
        rm -rf /home/colin/Documents/chia/*
    else
        echo "Not deleting files"
    fi


fi

cd /home/colin/Documents/chia-plotter/build
./chia_plot -n -1 -t $firstFolder -d $finalFolder -r 11 -f 80bfe421b6b14f70ff8e3b5d4f397c4bb7ea5d6891077f691183cbad0c72bc60c3e3cc3f9ca326a9dc69213febf27c67 -c xch1zz5are490fuzknqx884744q555c7wygsqaennn8t30cjhwgh2dasvtxm4d -u 256 -v 512
