load('temperaturas.mat')

[f1,x1] = ecdf(temperatura(:,1));
[f35,x35] = ecdf(temperatura(:,end));

alfa = 0.05;

%% first year

error1 = sqrt(f1.*(1-f1)/length(f1)); %Error Estandar

%Calculo de las bandas semi-parametrico
L1 = f1-1.96.*error1;
U1 = f1+1.96.*error1;

%Calculo de las bandas No parametrico

eps = sqrt((1/(2*length(f1)))*log(2/alfa));
for i=1:length(f1)
 L1np(i) = max([f1(i)-eps,0]);    
 U1np(i) = min([f1(i)+eps,1]);
end

%% last year

error35 = sqrt(f35.*(1-f35)/length(f35)); %Error Estandar

%Calculo de las bandas semi-parametrico
L35 = f35-1.96.*error35;
U35 = f35+1.96.*error35;

%Calculo de las bandas No parametrico
eps = sqrt((1/(2*length(f35)))*log(2/alfa));
for i=1:length(f35)
 L35np(i) = max([f35(i)-eps,0]);    
 U35np(i) = min([f35(i)+eps,1]);
end

%% Plots

%Bandas Semiparametricas
figure
hold on
plot(x1,L1,'--')
plot(x1,f1)
plot(x1,U1,'--')

plot(x35,L35,'--')
plot(x35,f35)
plot(x35,U35,'--')
legend('LB primer año','Primer año','UB Primer año','LB Ultimo año','Ultimo año año','UB Ultimo año')
ylabel('F Empirica')
xlabel('Temperatura')
ylim([0 1])
title('Bandas semi-parametricas')
hold off

%Bandas no parametricas
figure
hold on
plot(x1,L1,'--')
plot(x1,f1)
plot(x1,U1,'--')

plot(x35,L35,'--')
plot(x35,f35)
plot(x35,U35,'--')
legend('LB primer año','Primer año','UB Primer año','LB Ultimo año','Ultimo año año','UB Ultimo año')
ylabel('F Empirica')
xlabel('Temperatura')
ylim([0 1])
title('Bandas no parametricas')
hold off