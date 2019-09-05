rng(19)
n=100;
U = rand(n,1);

%Varianza Boostrap
B = 1000;
EB = bootstrp(B,@min,U);

Vboots = 0;
for b=1:B
    Vboots = Vboots + (EB(b,1)-mean(EB))^2;    
end

Vboots = Vboots/B;

%Sesgo
Bias = Bias_min(U);
Bias_teorico = 1-(n/(n+1));

disp(strcat('Varianza Bootstrap:',num2str(Vboots)))
disp(strcat('Sesgo Jackknife:',num2str(Bias)))
disp(strcat('Sesgo Teorico:',num2str(Bias_teorico)))