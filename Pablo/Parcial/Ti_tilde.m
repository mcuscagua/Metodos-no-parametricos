function Ti = Ti_tilde(X,i)
%Hay que cambiar la funcion del estimador

[n m] = size(X);

Tn = max(X);
Xi = X;
Xi(i) = [];
T_i = max(Xi);

Ti = n*Tn-(n-1)*T_i;
end

