function p = F_hat(X,x)

X = X(:);

N = size(X);
n = N(1);

Indicator = X <= x;

p = sum(Indicator)/n;
end

