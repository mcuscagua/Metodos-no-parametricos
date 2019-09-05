n = 100000;
lambda = 1;
X = sort(-(1/lambda)*log(rand(n,1)/lambda));

F = (1-exp(-lambda*X));
[F_est, x_est] = ecdf(X);
F_est = F_est(1:end-1);
x_est = x_est(1:end-1);

figure
hold on
plot(X,F)
plot(x_est,F_est)
legend('Teorica','Empirica')
title(strcat('n=',num2str(n)))
hold off

GlivCant = max(abs(F_est-F));
disp(strcat('Glivenko-Cantelli: ',num2str(GlivCant)))