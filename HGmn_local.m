function HGout = HGmn_local(m, n, xx, yy, w)
% [HGout] = HGmn_local(m, n, xx, yy, w)
%
% Calculates the HG mode of indices (m, n) and waist w at the 
% grid points specified by xx and yy.
%
% Copyright (c) 2014 GICO-UCM

    x = sqrt(pi)*xx/w;
    y = sqrt(pi)*yy/w;
    
    A = sqrt(2)/sqrt(2^(m+n-1)*factorial( m )*factorial( n )*w^2 );
    HGx = H(m, sqrt(2)*x).*exp( -(x).^2 );
    HGy = H(n, sqrt(2)*y).*exp( -(y).^2 );
    HGout = HGx.*HGy.*A;
    
    HGout = HGout/sqrt(sum(abs(HGout(:)).^2));
end