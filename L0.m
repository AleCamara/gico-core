function [pol] = L0(p, x)
% [pol] = L0(p, x)
%
% Gets the Laguerre polynomial of radial index p and null azimuthal index 
% for the value x.
%
% Copyright (c) 2014 GICO-UCM

    if (p == 0)
        pol = ones(size(x, 1), size(x, 2));
    elseif (p == 1)
        pol = -x+1;
    else
        pol = 1/p*((2*p-1-x).*L0(p-1,x)-(p-1).*L0(p-2,x));
    end;