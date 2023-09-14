set title 'Solução Exata'
set xlabel 'espaço'
set ylabel 'temperatura'

plot 'exata.dat' u 1:2 w l title 't=0', 'exata.dat' u 1:3 w l title 't=25', 'exata.dat' u 1:4 w l title 't=50', 'exata.dat' u 1:5 w l title 't=100', 'exata.dat' u 1:6 w l title 't=150', 'exata.dat' u 1:7 w l title 't=300'
