module mod_df

        implicit none

        contains

        subroutine imprimir(matriz, nl, nc)
        
                implicit none 

                integer, intent(in) :: nl, nc
                real, dimension(nl,nc), intent(in) :: matriz

                integer :: i
                
                print *, '-------Matriz--------'
                do i = 1, nl
                        print *, matriz(i,:)
                end do

        end subroutine

        subroutine discretiza_espaco(espaco, l, n, h)

                implicit none 
                integer, intent(in) :: n
                real, dimension(n), intent(inout) :: espaco
                real, intent(inout) :: h
                real, intent(in) :: l
                integer :: i

                h = l/(n+1)

                do i = 1, n
                        espaco(i) = i*h
                end do                

        end subroutine

        subroutine monta_matriz(matriz, nl, lambda)

                implicit none
        
                integer, intent(in) :: nl
                real, intent(in) :: lambda
                real, dimension(nl, nl), intent(inout) :: matriz
                integer :: i, j

                do i = 1, nl
                        matriz(i, i) = 1 + 2*lambda
                end do
                do i = 1, nl-1
                        matriz(i,i+1) = -lambda
                end do
                do i = 2, nl-1
                        matriz(i, i-1) = -lambda
                end do
                
        end subroutine

        subroutine x_inicial(x0, nl, passo)

                implicit none

                real, dimension(nl), intent(inout) :: x0
                integer, intent(in) :: nl
                real, intent(in) :: passo
                integer :: i

                do i = 1, nl
                        x0(i) = 20.0
                end do
                
        
        end subroutine

        function thomas(m, b, nl) result(x)

                implicit none
                        
                real, dimension(nl,nl), intent(inout) :: m
                real, dimension(nl), intent(inout) :: b
                integer, intent(in) :: nl
                real, dimension(:), allocatable :: x, c, d
                integer :: i

                allocate(x(nl), c(nl), d(nl))

                c(1) = m(1,2)/m(1,1)
                d(1) = b(1)/m(1,1)

                do i = 2, nl
                        c(i) = m(i,i+1)/(m(i,i)-m(i,i-1)*c(i-1))
                        d(i) = (b(i) - m(i,i-1)*d(i-1))/(m(i,i)-m(i,i-1)*c(i-1))
                end do

                x(nl) = d(nl)
                do i = nl-1, 1, -1
                        x(i) = d(i) - c(i)*x(i+1)
                end do
                
                deallocate(c,d)

        end function
        
        function gauss_seidel(matriz, b, nl, chute) result(erro)

                implicit none 

                integer, intent(in) :: nl
                real, dimension(nl, nl), intent(in) :: matriz
                real, dimension(nl), intent(inout) :: b, chute
                real :: erro
                
                real, dimension(nl) :: ini
                real :: solucao
                integer :: i, j
                
                ini = chute
                do i = 1, nl
                        solucao = b(i)
                        do j = 1, nl
                                if (i .ne. j) then
                                        solucao = solucao - chute(j) * matriz(i,j)
                                end if
                        end do
                        chute(i) = solucao/matriz(i,i)
                end do
                
                erro = norm_max(ini, chute, nl)
        end function

        real function norm_max(v1, v2, n)

                implicit none 
                
                integer, intent(in) :: n
                real, dimension(n), intent(in) :: v1, v2

                norm_max = (maxval(v2-v1)/maxval(v2))
                return
        end function

        function sol_exata(n, x, t, alpha) result(cont) 
                implicit none

                integer, intent(in) :: n
                real, intent(in) :: x, t, alpha
                real :: pi, cont
                integer :: i

                pi = 4*atan(1.0)
                cont = 0

                do i = 1, n, 2
                        cont = cont + (80.0/(i*pi))*exp(-((i**2)*(pi**2)*(alpha**2)*t)/2500.0)*sin((i*pi*x)/(50.0))
                end do
                

        end function
end module


