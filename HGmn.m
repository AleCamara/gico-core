function [ HGout x y ] = HGmn(m,n, Nx, Ny, dx, dy, Bx, By )
% [HGout x y] = HGmn(m, n, Nx, Ny, dx, dy, wx, wy);
%
% This function creates a 2D HG22 mode with scale 'Bx' in the X direction
% and 'By' in the Y direction.
%
% 'm' and 'n' are the index of the mode, 'Nx' and 'Ny' are the parameters 
% of number of pixels of the output matrix. 'dx' and 'dy' are the size of 
% a pixel in meters for the X and Y directions, respectively.
%
% Copyright (c) 2014 GICO-UCM

    % Allocate memory for the signal
    HGout = zeros( Ny, Nx );
    
    % Create the axes
    x = [-(Nx-1)/2:1:(Nx-1)/2]*dx/Bx;
    y = [-(Ny-1)/2:1:(Ny-1)/2]*dy/By;
    
    
    % Constant factor
    A = sqrt(2)/sqrt(2^(m+n-1)*factorial( m )*factorial( n )*Bx*By );
    
    % Row of the X direction (m=2)
    HGx = H(m,sqrt(2*pi)*x).*exp( -(sqrt(pi)*x).^2 );
    
    % Row of the Y direction (n=2)
    HGy = H(n,sqrt(2*pi)*y).*exp( -(sqrt(pi)*y).^2 );
    
    % Gather all together
    HGout = HGy.' * HGx * A;
    
end