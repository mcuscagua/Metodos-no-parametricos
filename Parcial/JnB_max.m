function Bias = JnB_max(X)

Tn_barr = 0;
[n y] = size(X);
Tn = max(X);

for i=1:n
Xi = X;
Xi(i) = [];
Ssq = max(Xi);
Tn_barr = Tn_barr + Ssq;
end

Tn_barr = Tn_barr/n;
Bias = (n-1)*(Tn_barr-Tn);



end
