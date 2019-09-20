clear all
close all

Vida = load('vida.txt');

[filas columnas] = size(Vida);
F = zeros(filas,columnas);

for i = 1:columnas
    if i == 1
        C = Vida(:,i);
        [f,x] = ecdf(C);
        plot(x,f, 'o')
        hold on
    end
    if i == columnas
        C = Vida(:,i);
        [f,x] = ecdf(C);
        plot(x,f,'+')
        hold on
    end
    C = Vida(:,i);
    [f,x] = ecdf(C);
    plot(x,f)
    hold on
end

xlabel('Tiempo de vida')
ylabel('F Empirica')
hold off