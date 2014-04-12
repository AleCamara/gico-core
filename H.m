function [pol] = H(n,x)
% [pol] = H(n, x)
%
% Gets the Hermite polynomial of order n for the value x
%
% Copyright (c) 2014 GICO-UCM

    if (0 == n)
        pol = 1;
        
    elseif (1 == n)
        pol = 2*x;
        
    else
        pol = 2*x.*H(n-1,x) - 2*(n-1)*H(n-2,x);
    end
end

