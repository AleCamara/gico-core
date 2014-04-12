function [pol] = L(l, p, x)
% [pol] = L(l, p, x)
%
% Gets the Laguerre polynomial of radial index p and azimuthal index l
% for the value x.
%
% Copyright (c) 2014 GICO-UCM

    l = abs(l);
    p = abs(p);
    
    pol = zeros(size(x, 1), size(x, 2));

    if (l == 0)
        pol = L0(p, x);
    else
        for i=0:p
            pol = pol + factorial(l+p-i-1)/factorial(p-i)/factorial(l-1)*L0(i, x);
        end
    end
    
end