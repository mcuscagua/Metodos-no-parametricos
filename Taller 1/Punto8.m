load('temperaturas.mat')

n = 365;
X = temperatura(:,1);
minimo = min(X);

%Sesgo
Bias =Bias_min(X);
disp(strcat('Sesgo:',num2str(Bias)))

%Varianza
Ssq_tilde = 0;
for i=1:n
    T_tilde_barr = 0;
    for j=1:n
        T_tilde_barr = T_tilde_barr + Ti_tilde(X,j);
    end
    T_tilde_barr = T_tilde_barr/n;    
    Ssq_tilde = Ssq_tilde + (Ti_tilde(X,i) - T_tilde_barr)^2;    
end
Ssq_tilde = Ssq_tilde/(n-1);

Varianza = Ssq_tilde/n;
SE = sqrt(Varianza);

%Intervalo de Confianza:

Lx = minimo-1.96.*SE;
Ux = minimo+1.96.*SE;

disp(strcat('Minimo Estimado: ',num2str(minimo)))
disp(strcat('Intervalo de confianza (Usando varianza de Jackknife): ',num2str(Lx),', ',num2str(Ux)))