function [ LGout ] = LGpl( p, l, Nx, Ny, dx, dy, wx, wy, sign, varargin )
% [ LGout ] = LGpl(p, l, Nx, Ny, dx, dy, wx, wy, sign)
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
    
    % Create the axes
    x = ((0:Nx-1) - floor(Nx/2))*dx/wx;
    y = ((0:Ny-1) - floor(Ny/2))*dy/wy;
    
    % Create the meshgrid
    [x y] = meshgrid( x, y );
    
    % Indices of the HG original mode
    %m = 5;
    %n = 2;
    
    % Laguerre indices
    %p = min( m, n );
    %l = abs( m - n );
        
    % Constant
    A = 1/sqrt(wx*wy) * sqrt( factorial( p ) / factorial( l+p ) );
    LGout = A * ( sqrt( 2*pi )*( x+sign*y*1i ) ).^l .* exp( -pi*( x.^2 + y.^2 ) );
    LGout = LGout .* L(l, p, 2*pi*(x.^2 + y.^2));%( 10 - 5*( 2*pi*( x.^2 + y.^2 ) ) + 1/2*( 2*pi*( x.^2 + y.^2 ) ).^2 ); 

end    