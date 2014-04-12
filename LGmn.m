function [ LGout ] = LGmn( m, n, Nx, Ny, dx, dy, wx, wy, sign, varargin )
% [ LGout ] = LGmn( m, n, Nx, Ny, dx, dy, wx, wy, sign)
%
% This function creates a 2D LG(p,l) mode with width 'w' and sign for the 
% 2nd index given by 'sign' ('sign' > 0 is positive, 'sign' < 0 is 
% negative, and 'sign' == 0 is error).
%
% 'Nx' and 'Ny' are the parameters of number of pixels of the output
% matrix. 'dx' and 'dy' are the width of each pixel in the same units than
% 'w'.
%
% Copyright (c) 2014 GICO-UCM

    % Number of arguments
    if( nargin == 8 )
        sign = 1;
    elseif( nargin ~= 9 )
        error( 'LGpl:CreationStage', 'BAD NUMBER OF ARGUMENTS.' );
    end

    % Check 'sign'
    if( sign ~= 0 )
        sign = sign/abs(sign);
    else
        error( 'LGpl:CreationStage', 'SIGN CANT BE NULL.' );
    end
    
    l = abs(m-n);
    p = min(m, n);
    
    LGout = LGpl(p, l, Nx, Ny, dx, dy, wx, wy, sign);
    
end