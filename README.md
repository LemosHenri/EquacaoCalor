# Equacao do Calor Unidimensional

A transferência de calor é o processo pelo qual a energia térmica flui entre sistemas que possuem diferentes níveis de temperatura. Esse fenômeno pode acontecer de maneira unidirecional, movendo-se do sistema de temperatura mais elevada em direção ao sistema de temperatura mais baixa, até que ambos alcancem um estado de equilíbrio térmico.
O caso da equação de calor unidimensional é dado pela seguinte relação:

$$
\begin{equation}
    \dfrac{\partial u}{\partial t} = \alpha \dfrac{\partial^2 u}{\partial x^2}
\end{equation}
$$

Os códigos implementados irão resolver a equação de calor no caso unidimensional para os seguintes problemas de valores iniciais e de contorno conforme a seguir utilizando o método das diferenças finitas:

$$
\begin{cases}
    \dfrac{\partial u}{\partial t} = \alpha \dfrac{\partial^2 u}{\partial x^2}\\
    u(x,0) = f(x), 0 < x < L\\
    u(0,t) = u(L,t) = 0, t>0
\end{cases}
\hspace{1cm}  
\begin{cases}
      \dfrac{\partial u}{\partial t} = \alpha \dfrac{\partial^2 u}{\partial x^2}\\
      u(x,0) = f(x), 0 < x < L\\
      u(0,t) = T_1, u(L,t) = T_2, t>0
\end{cases}
$$
