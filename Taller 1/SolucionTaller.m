clear all
close all

load('temperaturas.mat')

%% Punto a
disp('Punto a')
y = 1:365;
y = y(:);
%Calcular la función empirica para cada año
F = zeros(365,35);

for i=1:35
   for j=1:365
       F(j,i) = F_hat(temperatura(:,i),temperatura(j,i)); 
   end
end

figure(1)
hold on
for i=1:35
    
    [x1 x2] = sort(temperatura(:,i));
    if i==1
        plot(temperatura(x2,i),F(x2,i),'+')
    else if i==35
            plot(temperatura(x2,i),F(x2,i),'o')
        else
            plot(temperatura(x2,i),F(x2,i))
        end
    end
    
end
xlabel('Temperatura')
ylabel('F')
hold off

%% Punto b
disp('Punto b')
n = 365;

%Función empirica del primer año
[x1 x2_35] = sort(temperatura(:,35));
F35 = F(:,35);

Se35 = sqrt(F35.*(1-F35)/n); %Error Estandar

%Calculo de las bandas semi-parametrico
Lx35 = F35-1.96.*Se35;
Ux35 = F35+1.96.*Se35;

%Calculo de las bandas No parametrico

alfa = 0.05;
eps = sqrt((1/(2*n))*log(2/alfa));
for i=1:n
 Lx35np(i) = max([F35(i)-eps,0]);    
 Ux35np(i) = min([F35(i)+eps,1]);
end

%Función empirica del ultimo año
[x1 x2_1] = sort(temperatura(:,1));
F1 = F(:,1);

Se1 = sqrt(F1.*(1-F1)/n); %Error Estandar

%Calculo de las bandas
Lx1 = F1-1.96.*Se1;
Ux1 = F1+1.96.*Se1;

%Calculo de las bandas No parametrico

for i=1:n
 Lx1np(i) = max([F1(i)-eps,0]);    
 Ux1np(i) = min([F1(i)+eps,1]);
end

figure(2)
hold on
plot(temperatura(x2_35,35),Lx35(x2_35),'--')
plot(temperatura(x2_35,35),F35(x2_35))
plot(temperatura(x2_35,35),Ux35(x2_35),'--')

plot(temperatura(x2_1,1),Lx1(x2_1),'--')
plot(temperatura(x2_1,1),F1(x2_1))
plot(temperatura(x2_1,1),Ux1(x2_1),'--')
legend('LB primer año','Primer año','UB Primer año','LB Ultimo año','Ultimo año año','UB Ultimo año')
ylabel('F Empirica')
xlabel('Temperatura')
title('Bandas semi-parametricas')
hold off

%Bandas no parametricas
figure(3)
hold on
plot(temperatura(x2_35,35),Lx35np(x2_35),'--')
plot(temperatura(x2_35,35),F35(x2_35))
plot(temperatura(x2_35,35),Ux35np(x2_35),'--')

plot(temperatura(x2_1,1),Lx1np(x2_1),'--')
plot(temperatura(x2_1,1),F1(x2_1))
plot(temperatura(x2_1,1),Ux1np(x2_1),'--')
legend('LB primer año','Primer año','UB Primer año','LB Ultimo año','Ultimo año año','UB Ultimo año')
ylabel('F Empirica')
xlabel('Temperatura')
title('Bandas no parametricas')
hold off

%% Punto c
disp('Punto c')
n = 1000;
lambda = 1;
X = -(1/lambda)*log(rand(n,1)/lambda);

F_teorica = (1-exp(-lambda*X));

F_empirica = zeros(n,1);
for i=1:n
    %F estimada
   F_empirica(i) = F_hat(X,X(i,1)); 
end

[x1 x2] = sort(X);

figure(4)
hold on
plot(X(x2,1),F_teorica(x2))
plot(X(x2,1),F_empirica(x2))
legend('Teorica','Empirica')
title(strcat('n=',num2str(n)))
hold off

GlivCant = max(abs(F_empirica-F_teorica));
disp(strcat('Glivenko-Cantelli: ',num2str(GlivCant)))

%% Punto i
disp('Punto i')
n = 365;
X = temperatura(:,35);
minimo = min(X);

%Sesgo
Bias =JnB_minimo(X);
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

%% Ejercicio J
disp('Punto j')
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
Bias = JnB_minimo(U);
Bias_teorico = 1-(n/(n+1));

disp(strcat('Varianza Bootstrap:',num2str(Vboots)))
disp(strcat('Sesgo Jackknife:',num2str(Bias)))
disp(strcat('Sesgo Teorico:',num2str(Bias_teorico)))


%% Componentes principales
disp('Punto k')
X = [temperatura(:,1) temperatura(:,35)];

v = cov(X);
[Coef,latent,explained] = pcacov(v);

z1 = Coef(:,1);
z2 = Coef(:,2);

%Version robusta de la matriz de covarianzas

covR = zeros(2,2);
for i=1:2
   for j=1:2
      covR(i,j) = Comedian(X(:,i),X(:,j)); 
   end
end

%PCA Robusto

[CoefR,latentR,explainedR] = pcacov(covR);

zr1 = CoefR(:,1);
zr2 = CoefR(:,2);

%% Contaminación de los datos
X = [X ; (X(28:35,:)+ 30) ];

v = cov(X);
[Coef,latent,explained] = pcacov(v);

z1 = Coef(:,1);
z2 = Coef(:,2);

%Version robusta de la matriz de covarianzas

covR = zeros(2,2);
for i=1:2
   for j=1:2
      covR(i,j) = Comedian(X(:,i),X(:,j)); 
   end
end

%PCA Robusto

[CoefR,latentR,explainedR] = pcacov(covR);
