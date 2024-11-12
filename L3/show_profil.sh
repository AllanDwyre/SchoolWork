#!/bin/bash

if [[ $# -ne 1 ]] ; then
    echo utilisation : dat_filepath
    exit 0
fi

clear

plot="plot \"$1\" with line"

gnuplot -persist <<-EOFMarker
    $plot
EOFMarker

echo -e "Affichage Profile terminer !"
