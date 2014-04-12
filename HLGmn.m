function [HLGout] = HLGmn(m, n, Nx, Ny, dx, dy, wx, wy, beta)
% [HLGout] = HLGmn(m, n, Nx, Ny, wx, wy, beta)
%
% Returns the complex amplitude of a HLGmn(wx, wy, beta) mode. It is
% calculated as a decomposition of HG modes.
%
% 'beta' must be in radians.
%
% Copyright (c) 2014 GICO-UCM

    % initial value
    HLGout = zeros(Ny, Nx);

    % iteration
    for k=0:m
        for l=0:n
            K = sqrt(factorial(k+n-l)*factorial(l+m-k)/(factorial(m)*factorial(n)));
            K = K*factorial(m)/(factorial(k)*factorial(m-k))*factorial(n)/(factorial(l)*factorial(n-l));
            K = K*(cos(beta))^(k+l)*(-1i*sin(beta))^(m+n-k-l);
            HLGout = HLGout + K*HGmn(k+n-l, l+m-k, Nx, Ny, dx, dy, wx, wy);
        end
    end

end

