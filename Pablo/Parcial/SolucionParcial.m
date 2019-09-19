clear all
close all

load('Vida.mat')

%% Punto a

%Calcular la función empirica para cada año
[m n] = size(Vida);
F = zeros(m,n);

for i=1:m
   for j=1:n
       F(i,j) = F_hat(Vida(:,j),Vida(i,j)); 
   end
end

figure(1)
hold on
[x1 x2] = sort(Vida(:,1));
plot(Vida(x2,1),F(x2,1),'--')

[x1 x2u] = sort(Vida(:,n));
plot(Vida(x2u,n),F(x2u,n),'--')
for i=2:n-1
    
    [x1 x2] = sort(Vida(:,i));
     plot(Vida(x2,i),F(x2,i))
   
end
xlabel('Tiempo de vida')
ylabel('F Empirica')
legend('Primer año','Ultimo año')
hold off


%% Punto b

Fyear = Vida(:,1);
F1 = zeros(500,1);

for i=1:500
   F1(i,1) = F_hat(Fyear,Fyear(i,1));   
end

[x1 y1] = sort(Fyear);

Se = sqrt(F1.*(1-F1)/m); %Error Estandar
%Calculo de las bandas semi-parametrico
Lx = F1-1.645.*Se;
Ux = F1+1.645.*Se;

%Calculo de las bandas No parametrico

alfa = 0.1;
eps = sqrt((1/(2*n))*log(2/alfa));
for i=1:m
 Lxnp(i) = max([F1(i)-eps,0]);    
 Uxnp(i) = min([F1(i)+eps,1]);
end


plot(Fyear(y1),F1(y1))

figure(2)
hold on
plot(Fyear(y1),Lx(y1),'--')
plot(Fyear(y1),F1(y1))
plot(Fyear(y1),Ux(y1),'--')

legend('LB primer año','Primer año','UB Primer año')
ylabel('F Empirica')
xlabel('Tiempo de vida')
title('Bandas semi-parametricas')
hold off

%Bandas no parametricas
figure(3)
hold on
plot(Fyear(y1),Lxnp(y1),'--')
plot(Fyear(y1),F1(y1))
plot(Fyear(y1),Uxnp(y1),'--')

legend('LB primer año','Primer año','UB Primer año')
ylabel('F Empirica')
xlabel('Tiempo de vida')
title('Bandas no parametricas')
hold off

%% Punto c

n1 = 500;

Lyear = Vida(1:n1,10);
[x1 y1] = sort(Lyear);
F10 = zeros(n1,1);
Fteorica = 1-exp(-10.*Lyear);

for i=1:n1
   F10(i,1) = F_hat(Lyear,Lyear(i,1));   
end

figure(4)
hold on
plot(Lyear(y1),F10(y1))
plot(Lyear(y1),Fteorica(y1))

title(strcat('n=',num2str(n1)))
legend('Empirica','Teorica')
ylabel('F')
xlabel('Tiempo de vida')
hold off

%% Punto h

X = Vida(:,10);
maximo = max(X);

%Sesgo
Bias =JnB_max(X);
disp(strcat('Sesgo:',num2str(Bias)))


%Varianza
Ssq_tilde = 0;
for i=1:m
    T_tilde_barr = 0;
    for j=1:m
        T_tilde_barr = T_tilde_barr + Ti_tilde(X,j);
    end
    T_tilde_barr = T_tilde_barr/m;    
    Ssq_tilde = Ssq_tilde + (Ti_tilde(X,i) - T_tilde_barr)^2;    
end
Ssq_tilde = Ssq_tilde/(m-1);

Varianza = Ssq_tilde/m;
SE = sqrt(Varianza);

%Intervalo de confianza
Lx = maximo-1.645.*SE;
Ux = maximo+1.645.*SE;

disp(strcat('Maximo Estimado: ',num2str(maximo)))
disp(strcat('Varianza Jackknife: ',num2str(Varianza)))
disp(strcat('Intervalo de confianza 90% (Usando varianza de Jackknife): ',num2str(Lx),', ',num2str(Ux)))

%% Punto i

n2 = 100;   
U = -log(rand(n2,1));

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
Bias_teorico = 1/n2;

disp(strcat('Varianza Bootstrap:',num2str(Vboots)))
disp(strcat('Sesgo Jackknife:',num2str(Bias)))
disp(strcat('Sesgo Teorico:',num2str(Bias_teorico)))

%% Punto j

n3=100;
Datos1 = randn(n3,2);
Datos2 = -log(rand(n3,2));
V = cov(Datos1,Datos2);

for i=1:n3
    for j=1:n3
   d(i,j) = (Datos1(i,:)-Datos2(j,:))*inv(V)*(Datos1(i,:)-Datos2(j,:))';   
    end
end


% Version Robusta
covR = zeros(2,2);

X = [Datos1(:) Datos2(:)];
for i=1:2
   for j=1:2
      covR(i,j) = Comedian(X(:,i),X(:,j)); 
   end
end

for i=1:n3
    for j=1:n3
   d2(i,j) = (Datos1(i,:)-Datos2(j,:))*inv(covR)*(Datos1(i,:)-Datos2(j,:))';  
    end
end

disp(d(1,1:8))
disp(d2(1,1:8))

%Contaminacion de datos.

Datos1 = [Datos1 ; randn(10,2)+50];
Datos2 = [Datos2 ; randn(10,2)+50];

% Calculo de distancias

V = cov(Datos1,Datos2);

for i=1:n3+10
    for j=1:n3+10
   d(i,j) = (Datos1(i,:)-Datos2(j,:))*inv(V)*(Datos1(i,:)-Datos2(j,:))';   
    end
end


% Version Robusta
covR = zeros(2,2);

X = [Datos1(:) Datos2(:)];
for i=1:2
   for j=1:2
      covR(i,j) = Comedian(X(:,i),X(:,j)); 
   end
end

for i=1:n3+10
    for j=1:n3+10
   d2(i,j) = (Datos1(i,:)-Datos2(j,:))*inv(covR)*(Datos1(i,:)-Datos2(j,:))';  
    end
end

disp(d(1,1:8))
disp(d2(1,1:8))