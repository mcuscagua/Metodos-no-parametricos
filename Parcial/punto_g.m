X = Vida(:,10);
maximo = max(X);

%Sesgo
Bias =JnB_max(X);
disp(strcat('Sesgo:',num2str(Bias)))


%Varianza
Ssq_tilde = 0;
for i=1:filas
    T_tilde_barr = 0;
    for j=1:filas
        T_tilde_barr = T_tilde_barr + Ti_tilde(X,j);
    end
    T_tilde_barr = T_tilde_barr/filas;    
    Ssq_tilde = Ssq_tilde + (Ti_tilde(X,i) - T_tilde_barr)^2;    
end
Ssq_tilde = Ssq_tilde/(filas-1);

Varianza = Ssq_tilde/filas;
SE = sqrt(Varianza);

%Intervalo de confianza
Lx = maximo-1.645.*SE;
Ux = maximo+1.645.*SE;

disp(strcat('Maximo Estimado: ',num2str(maximo)))
disp(strcat('Varianza Jackknife: ',num2str(Varianza)))
disp(strcat('Intervalo de confianza 90% (Usando varianza de Jackknife): ',num2str(Lx),', ',num2str(Ux)))
