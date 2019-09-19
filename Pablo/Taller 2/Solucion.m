%Solucion Taller

%Punto 1. Seleccionar una provincia y estimar su densidad

Datos = xlsread('base.xlsx');
provincia = Datos(:,12);
Datos(:,12) = [];
Datos(:,1:4) = [];
plot(provincia)

[n m] = size(Datos);

num_clases = ceil(1+3.33*log(n));
[Tf, poligono] = TablaFrecuencia(provincia, num_clases);
%matlab2tikz('Densidad.tex')

%xlswrite('Densidad.xlsx',Tf);


close all
n_datos = n;
Table = Tf
[x1 y1] = size(Table);
sim1 = [];
sim2 = [];

for i=1:x1
    %Kernel uniforme
    sim1 = [sim1 ; Table(i,1)+(Table(i,2)-Table(i,1))*rand(round(n_datos*Table(i,6)),1)];
    
    %Kernel Exponencial
    mu = (Table(i,1)+(Table(i,2)))/2;
    sigma = (Table(i,2)-(Table(i,1)))/8;
    
    sim2 = [sim2 ; sigma*randn(round(n_datos*Table(i,6)),1)+mu];
end

[Tf2, poligono2] = TablaFrecuencia(sim1, num_clases);
[Tf3, poligono3] = TablaFrecuencia(sim2, num_clases);

close all
hold on
hist(provincia,num_clases)
plot(poligono(:,1),poligono(:,2),'r','LineWidth',3)
plot(poligono2(:,1),poligono2(:,2), 'y','LineWidth',2)
plot(poligono3(:,1),poligono3(:,2),'g','LineWidth',2)
legend('Histograma','Datos Reales','Kernel Uniforme', 'Kernel Gaussiano')
xlabel('Temperaturas')
ylabel('Frecuencias')
title('Histograma')
hold off
matlab2tikz('Hist_tf.tex')


close all
hold on

hist(sim1,num_clases)
%matlab2tikz('Simulacion_Unif.tex')

hist(sim2,num_clases)
%matlab2tikz('Simulacion_Gaus.tex')

[f1,xi1, bw1] = ksdensity(provincia);
[f2,xi2, bw2] = ksdensity(provincia, 'kernel', 'box');
[f3,xi3, bw3] = ksdensity(provincia, 'kernel', 'triangle');
[f4,xi4, bw4] = ksdensity(provincia, 'kernel', 'epanechnikov');

P = histogram(provincia,'Normalization','pdf');
Data = P.Values;
Data2 = P.BinEdges;

close all
hold on
bar(Data2(1:35),Data)
plot(xi1, f1,'--','Color','r', 'LineWidth', 2)
plot(xi2, f2,'+','Color','g', 'LineWidth', 2)
plot(xi3, f3,'o','Color','y', 'LineWidth', 2)
plot(xi4, f4,'-r','Color','k', 'LineWidth', 1)
legend('Histograma','Gaussiano','Box','Triangle','Epanechnikov')
hold off
%matlab2tikz('Density2.tex')

%Punto 2.
%Test por el método de rangos para determinar si dos poblaciones provienen 
%de la misma distribucion

rangos = zeros(m,1);

for i=1:m
   p = signrank(provincia,Datos(:,i));
   rangos(i,1) = p;
end

xlswrite('MetodoDeRangos.xlsx',rangos);

%Punto 4. 
%Regresión No Paramétrica

%Coeficientes de la regresión:
Betas = zeros(m,1);
for i=1:m
    rho = corr(provincia,Datos(:,i),'type','Kendall');
    Betas(i,1) =  rho *(Mad(provincia)/Mad(Datos(:,i))); 
end

%Intervalo de confianza No Parametrico

B = 1000;
Betas_B = zeros(B,m);

for i=1:B
   Eliminar =  unidrnd(n);
   provincia2 = provincia;
   Datos2 = Datos;
   
   provincia2(Eliminar) = [];
   Datos2(Eliminar,:) = [];
   
   for j=1:m
      rho = corr(provincia2,Datos2(:,j),'type','Kendall');
      Betas_B(i,j) = rho *(Mad(provincia2)/Mad(Datos2(:,j)));  
   end
   disp(i)
end

%Intervalo de confianza para cada Beta

Lb = zeros(m,1);
Ub = zeros(m,1);

for i=1:m
  Lb(i,1) = prctile(Betas_B(:,i),2.5);
  Ub(i,1) = prctile(Betas_B(:,i),97.5);
end

Resultado_regresion = [Betas Lb Ub];
xlswrite('RegresionNoParametrica_PrimeraProvincia.xlsx',Resultado_regresion);