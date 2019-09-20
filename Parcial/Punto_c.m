%% Punto c

n1 = filas;

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
legend('empírica','teórica')
ylabel('F')
xlabel('Tiempo de vida')
hold off