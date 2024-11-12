set terminal pngcairo enhanced size 800,600 font "Arial,12"
set output 'phase_transition.png'
set title 'Phénomène de transition de phase' font "Arial,14"
set xlabel 'Dureté'
set ylabel 'Pourcentage solvable'
set y2label 'Temps moyen (ms)'
set y2tics
set grid
set key outside right top

# Style settings
set style data linespoints
set datafile separator ","

# Plot percentage on primary y-axis and time on secondary y-axis
plot 'results.csv' using 1:3 title 'solvables' axes x1y1 with linespoints pt 7 ps 1 lt rgb "red" lw 2, \
     'results.csv' using 1:2 title 'temps moyen' axes x1y2 with linespoints pt 9 ps 1 lt rgb "purple" lw 2
