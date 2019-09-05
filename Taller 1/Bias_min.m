function bias = Bias_min(X)
Tn_barr = 0;
[n y] = size(X);
Tn = min(X);

for i=1:n
Xi = X;
Xi(i) = [];
Ssq = min(Xi);
Tn_barr = Tn_barr + Ssq;
end

Tn_barr = Tn_barr/n;
bias = (n-1)*(Tn_barr-Tn);
end
