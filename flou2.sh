#!/bin/bash
function ProgressBar {
# Process data
	let _progress=(${1}*100/${2}*100)/100
	let _done=(${_progress}*4)/10
	let _left=40-$_done
# Build progressbar string lengths
	_done=$(printf "%${_done}s")
	_left=$(printf "%${_left}s")
# Color Constants
    GREEN=$(tput setaf 2)
    CYAN=$(tput setaf 6)
    DEFAULT=$(tput sgr0)
# Build progressbar
    printf "\rProgress : [$GREEN${_done// /█}$CYAN${_left// /▒}$DEFAULT] ${_progress}%%"
}

if [[ $# -ne 4 ]] ; then
    echo utilisation : est_ligne pos imageIn numberOfIteration
    exit 0
fi

clear
if [[ $(ls | wc -l) -ne 0 ]] ; then
    echo $(ls | wc -l)
    rm -r TP3/out/*
fi



plot="plot"
for i in $( seq 0 $4 )
do
    touch TP3/out/flou2_$i.dat
    plot="$plot \"TP3/out/flou2_$i.dat\" using 1:2 with line title \"flou2_$i\","
done

gcc TP3/filtre_flou2.cpp -o flouBin
gcc TP1/profil.cpp -o profilBin
./flouBin images/$3.pgm out.pgm 
i=0
for file in TP3/out/*
do
    ./profilBin out.pgm $1 $2 >& $file
    ProgressBar $i $4
    i=$((i+1))
    ./flouBin out.pgm out.pgm
done
echo -e '\n'
gnuplot -persist <<-EOFMarker
    $plot
EOFMarker
echo -e "Génération des profils pour le flou terminer !"

