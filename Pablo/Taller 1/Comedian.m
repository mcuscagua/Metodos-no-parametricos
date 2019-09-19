function Comedian = Comedian(X,Y)

    medX = median(X);
    medY = median(Y);
    Comedian = median((X-medX).*(Y-medY));

end

