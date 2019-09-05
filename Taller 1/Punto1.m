load('temperaturas.mat')
A= temperatura;
[rows,cols] = size(A);
for i = 1:cols
    if i <= 5
        C = A(:,i);
        [f,x] = ecdf(C);
        plot(x,f, 'o')
        hold on
    end
    if i >= (cols-5)
        C = A(:,i);
        [f,x] = ecdf(C);
        plot(x,f,'+')
        hold on
    end
    C = A(:,i);
    [f,x] = ecdf(C);
    plot(x,f)
    hold on
end

figure
for i = 1:cols
    plot(A(:,i))
    hold on
end
xlim([0 365])