clear all
close all

Vida = load('vida.txt');
[filas columnas] = size(Vida);
Fyear = Vida(:,1);
F1 = zeros(500,1);

for i=1:500
   F1(i,1) = F_hat(Fyear,Fyear(i,1));   
end

[x1 y1] = sort(Fyear);

alfa = 0.1;
eps = sqrt((1/(2*filas))*log(2/alfa));
for i=1:filas
 Lxnp(i) = max([F1(i)-eps,0]);    
 Uxnp(i) = min([F1(i)+eps,1]);
end

%Bandas no parametricas
figure
hold on
plot(Fyear(y1),Lxnp(y1),'--')
plot(Fyear(y1),F1(y1))
plot(Fyear(y1),Uxnp(y1),'--')

legend('LB primer año','Primer año','UB Primer año')
ylabel('F Empirica')
xlabel('Tiempo de vida')
title('Bandas no parametricas')
hold off

