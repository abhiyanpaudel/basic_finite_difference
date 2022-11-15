
clc
clear all
close all

lx = 1;
ly = 2;
dx = 0.05;
dy = 0.05;
m = lx/dx;
n = ly/dy;
psi1 = 100;
beta = dx/dy;


for j = 1:n+1
    for i = 1:m+1
        x(i,j) = (i-1)*dx;
        y(i,j) = (j-1)*dy;
    end
end



errormax = 0.01;
fid = fopen('P5.1_PSOR_relaxation_table.txt','wt');
fprintf(fid,' Relaxation parameter    Number of iterations\n\n')

for omega = 0.8:0.01:1.98
    omega
iteration = 0;
count = (m-1)*(n-1);
psi = zeros(m+1,n+1);

for j = 1:n+1
    for i = 1:m+1
        if x(i,j)<=1 && y(i,j)==0
            psi(i,j) = 0.0;
        elseif x(i,j)>=1.2 && y(i,j)==0
            psi(i,j) = 100.0;
        elseif x(i,j)==0 && y(i,j)<=ly
            psi(i,j) = 0.0;
        elseif x(i,j)==lx && y(i,j)<=3
            psi(i,j) = 100.0;
        elseif x(i,j)==lx && y(i,j)>=3.2
            psi(i,j) = 0.0;
        elseif x(i,j)>=0 && y(i,j)==ly
            psi(i,j) = 0.0;
        else
            psi(i,j) = 0.0;
        end
    end
end
while count>0
    count = 0;
    prev = psi;
  
    % Discritised equation (5.18)
    for i = 2:m
        for j = 2:n
            psi(i,j) = (1-omega)*psi(i,j)+omega/(2*(1+beta*beta))*(psi(i+1,j)+psi(i-1,j)+beta*beta*(psi(i,j+1)+psi(i,j-1)));
        end
    end 
   
   error = 0;
   
   % Convergence criterion 
    for i = 2:m
        for j = 2:n
            error = error+abs(psi(i,j)-prev(i,j));
        end
    end
    count = count+1;
    iteration = iteration+1;  error;
    if (error<errormax)
        break;
    end
end
iteration
if omega>=1.00
fprintf(fid,'%10.2f\t\t\t\t\t%10.2f\n',omega,iteration);
end
plot(iteration,omega,'*')
hold on

end

 xlabel('Number of iteration')
 ylabel('\omega')








