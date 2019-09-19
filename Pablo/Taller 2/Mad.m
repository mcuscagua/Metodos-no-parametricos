function Mad = Mad(X)

    medX = median(X);
    Mad = median(abs((X-medX)));
    
end

