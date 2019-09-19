function [Table] = TablaFrecuencia( X,n_clases )

data = X(:);
n=length(data);
Li=min(data); % mínimo de los datos
Ls=max(data);% máximo de los datos
NCE=n_clases %número de clases
[H,X]=hist(data, NCE); %X: centros de las clases, H: frecuencia absoluta de la clase
LC=(Ls-Li)/NCE %Longitud de la clase
extremos=Li+LC*[0:NCE-1] % extremos inferiores de cada clase
clases=[extremos' extremos'+LC] %clase definidas por intervalos
centros=X'; %centros de cada clase. Puntos medios. Clase modal
fa=H'; %frecuencias absolutas en cada clase
faAcum=cumsum(fa);%frecuencias absolutas acumuladas en cada clase
fr=H'/n;%frecuencias reltivas en cada clase
frAcum=cumsum(fr);%frecuencias reltivas acululadas en cada clase
Table=[clases centros fa faAcum fr frAcum];% Tabla final
bar(Table(:,3),Table(:,4),'hist')%histograma de los datos agrupdos
hold on
poligono=plot(Table(:,3),Table(:,4),'r')
%figure
%hist(data) %histogramma real datos no agrupados
xlabel('Clases')
ylabel('Frecuencia')
title('Histograma de Frecuencias')

end

