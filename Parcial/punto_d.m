clear all
close all

Vida = load('vida.txt');

C = Vida(:,2);
[f,x] = ecdf(C);

Y = log(-log(1 - f));
Y = Y(2:end-1);
t = [ones(length(Y),1) log(x(2:end-1))];

beta= (t'*t)\(t'*Y);

k = beta(2)
lambda = exp(-beta(1)/k)

Fteorica = 1-exp(-((1/lambda).*x).^k);

figure
hold on
plot(x,f)
plot(x,Fteorica)

title(strcat('Usando la totalidad de los datos'))
legend('empírica','teórica')
ylabel('F')
xlabel('Tiempo de vida')
hold off

