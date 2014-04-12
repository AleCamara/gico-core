function LGout = LGpl_local(p, l, xx, yy, w)
% [LGout] = LGpl_local(p, l, xx, yy, w)
%
% Calculates the LG mode of (p, l) indices (m, n) and waist w at the 
% grid points specified by xx and yy.
%
% Copyright (c) 2014 GICO-UCM

    rho2 = 2*pi/w^2*(xx.^2 + yy.^2);
    LGout = 1/w * sqrt( factorial( p ) / factorial( 2*abs(l)+p ) ) ...
            *( sqrt( 2*pi/w^2 )*( xx+sign(l)*yy*1i ) ).^abs(l) ...
            .* exp( -rho2/2 ) ...
            .* L(abs(l), p, rho2);
    LGout = LGout/sqrt(sum(abs(LGout(:)).^2));
    
end