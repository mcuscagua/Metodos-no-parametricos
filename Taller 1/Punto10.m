%% Comedian y Datos
comedian = @(X,Y) median((X-median(X)).*(Y-median(Y)));
load('temperaturas.mat')
%% Componentes principales
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
X1 = X;
X1(20:35,:) = X1(20:35,:) + 50;

v = cov(X1);
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