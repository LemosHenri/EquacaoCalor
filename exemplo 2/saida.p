set title 'Solução Aproximada'
set xlabel 'espaço'
set ylabel 'temperatura'
set yrange [0:60]
set xrange [0:40]

plot 'saida.dat' u 1:2 w l title "t=0", 'saida.dat' u 1:3 w l title 't=25', 'saida.dat' u 1:4 w l title 't=50', 'saida.dat' u 1:5 w l title 't=100', 'saida.dat' u 1:6 w l title 't=150'
