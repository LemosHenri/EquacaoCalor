program main
        use mod_df

        implicit none

        integer :: nl, nc, it
        real :: lambda, hx, ht, alpha, l, t_max
        real, dimension(:,:), allocatable :: matriz, x0, ext
        integer :: i, j
        
        nl = 1000
        nc = 301

        alpha = 1
        l = 50
        t_max = 300
        
        allocate(matriz(nl,nl), x0(nc, nl), ext(6,nl))
        
        hx = l/(nl-1)
        ht = t_max/(nc-1)

        
        lambda = (alpha * ht)/(hx**2)
        print *, hx, ht, alpha, lambda
        
        call monta_matriz(matriz, nl, lambda)
        call x_inicial(x0(1,:), nl, hx)


        do i = 2, nc
                !x0(i,2) = x0(i,2) + x0(i,1)*lambda
                !x0(i,nl-1) = x0(i,nl-1) + x0(i,nl)*lambda
                x0(i,:) = thomas(matriz, x0(i-1,:), nl)
        end do

        open(1, file='saida.dat', status='unknown', action='write')
        open(2, file='dados.dat', status='unknown', action='write')
        open(3, file='exata.dat', status='unknown', action='write')

        !--------------------------------------------------------------------

        do i = 1, nl
                write(1, *) (i-1)*hx, x0(1,i), x0(25,i), x0(50,i), x0(100,i), x0(150,i), x0(300,i)
        end do

        !--------------------------------------------------------------------
        
        do i = 1, nl
                ext(1,i) = sol_exata(1000, (i-1)*hx, 1.0, alpha)
        end do
        do i = 1, nl
                ext(2,i) = sol_exata(1000, (i-1)*hx, 25.0, alpha)
        end do
        do i = 1, nl
                ext(3,i) = sol_exata(1000, (i-1)*hx, 50.0, alpha)
        end do
        do i = 1, nl
                ext(4,i) = sol_exata(1000, (i-1)*hx, 100.0, alpha)
        end do
        do i = 1, nl
                ext(5,i) = sol_exata(1000, (i-1)*hx, 150.0, alpha)
        end do
        do i = 1, nl
                ext(6,i) = sol_exata(1000, (i-1)*hx, 300.0, alpha)
        end do
        
        !--------------------------------------------------------------------

        do i = 1, nc
                do j = 1, nl
                        write (2, *) (i-1)*ht, (j-1)*hx, x0(i, j)
                end do
        end do

        !--------------------------------------------------------------------

        !do i = 1, nl
        !        write(3, *) (i-1)*hx, x0(1,i), x0(2,i), x0(3,i), x0(4,i), x0(5,i), x0(6,i)
        !end do

        !--------------------------------------------------------------------
        do i = 1, nl
                write(3, *) (i-1)*hx, sol_exata(1000, (i-1)*hx, 0.0, alpha), ext(2,i), ext(3,i), ext(4,i), ext(5,i), ext(6,i)
        end do


        close(1)
        close(2)
        close(3)
end program
