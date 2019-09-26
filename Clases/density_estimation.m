 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%simulando una variable numérica Normal y haciendo Tabla de Frecuencias
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mu=10
sigma=2;
data=mu+2*randn(1000,1)
    % simulando datos normales
lambda=5
%data=-(1/lambda)*log(1-rand(1000,1))%simulando datos exponenciales
%data=MPG
n=length(data);
%%%%%%%%%%%%%%%%%%%%%%%%%%%Tabla de frecuencias dado los %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%datos=data
Li=min(data); % mínimo de los datos
Ls=max(data);% máximo de los datos
NCE=10 %número de clases
[H,X]=hist(data, NCE); %X: centros de las clases, H: frecuencia absoluta de la clase
LC=(Ls-Li)/NCE %Longitud de la clase
extremos=Li+LC*[0:NCE-1] % extremos inferiores de cada clase
clases=[extremos' extremos'+LC] %clase definidas por intervalos
centros=X'; %centros de cada clase. Puntos medios. Clase modal
fa=H'; %frecuencias absolutas en cada clase
faAcum=cumsum(fa);%frecuencias absolutas acumuladas en cada clase
fr=H'/n;%frecuencias reltivas en cada clase
frAcum=cumsum(fr);%frecuencias reltivas acululadas en cada clase
Table=[clases centros fa faAcum fr frAcum]% Tabla final
bar(Table(:,3),Table(:,4),'hist')%histograma de los datos agrupdos
hold on
poligono=plot(Table(:,3),Table(:,4),'r')
figure
hist(data) %histogramma real datos no agrupados
xlabel('Clases')
ylabel('Frecuencia')
title('Histograma de Frecuencias')
%Naive density estimation
xe=Li:LC:Ls
xe2=Li:LC/10:Ls
tdf = normpdf(xe2,mu,sigma)% Normal teoretical density Function
%tdf = lambda*exp(-lambda*xe2) %exponential density function
hist(data)
hold on
plot(xe2,tdf*n*LC,'g')
P=fr/LC
hold on
plot(centros,P*n*LC, 'r')
yy = spline(centros,P,xe2)
hold on
plot(xe2,yy*n*LC,'k')
Q1 = trapz(xe2,yy)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[f,xi] = ksdensity(data);
hold on
plot(xi,f*n*LC,'LineWidth',2)
Q2 = trapz(xi,f)

