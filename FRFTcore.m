function out = FRFTcore(img, z, lambda, alpha, beta, dx, dy)
% [out] = FRFTcore(img, z, lambda, alpha, beta, dx, dy)
%
%   Alpha & beta must be angles in radians, both of them in the range
%   (pi/4, 3pi/4).
%
% Copyright (c) 2014 GICO-UCM

    % Get the size of the input signal
    [Ny, Nx] = size(img);

    % Get the x/y and px/py axis
    x = ((-Nx/2+1):1:(Nx/2))*dx;
    y = ((-Ny/2+1):1:(Ny/2))*dy;
    px = x / dx^2 / Nx;
    py = y / dy^2 / Ny;

    % Obtain the grids for the real and conjugate spaces
    [xx, yy] = meshgrid(x, y);
    [pxx, pyy] = meshgrid(px, py);
    %clear escx escy escfx escfy;

    % Parameter of the optical FRFT
    s = 2*lambda*z;
    
    % External phase
    ph1 = exp(-pi*1i*( (xx.^2).*tan(alpha/2) + (yy.^2).*tan(beta/2) ) /s);

    % Convolution phase
    ph2 = (1/(s*abs(sin(beta)*sin(alpha))))* ... Constante
        ... 
        exp(-pi*1i*s*( (pxx.^2)*sin(alpha) + (pyy.^2)*sin(beta) )) .* ...
        ...
        exp(1i*2*pi*s*((pxx*sin(alpha)/(dx*Nx)+pyy*sin(beta)/(dy*Ny))));
    
% ph2=(1/(s*abs(sin(beta)*sin(alpha))))* ... Constante
%         ... 
%         exp(-pi*1i*s*( (fx.^2)*sin(alpha) + (fy.^2)*sin(beta) )) .* ...
%         ...
%         exp( 1i*(pi*s)*(1*((fx*sin(alpha) /tax) + (fy*sin(beta) / tay))) ); 
%         ...                     ^ - antes era un '2'.
    
    
    % Convolution
    temp = fft2(img.*ph1).*fftshift(ph2);
    out = ph1.*(ifft2(temp));
    
    %out = out.*exp(1i/2*(alpha+beta-pi));
     
%     % Si alguno de los ángulos es cercano a 180º hay que hacer un truco
%     if (abs(pi-alpha) < pi/4) || (abs(pi-beta) < pi/4)
%         
%         if (alpha/2 < pi/2)
%             alpha = alpha + 2*pi;
%         elseif (alpha/2 > 3*pi/2)
%             alpha = alpha - 2*pi;
%         end
%         
%         if (beta/2 < pi/2)
%             beta = beta + 2*pi;
%         elseif (beta/2 > 3*pi/2)
%             beta = beta - 2*pi;
%         end
%             
%         tmp = FRFT(img, z, lambda, alpha/2, beta/2, dx, dy);
%         out = FRFT(tmp, z, lambda, alpha/2, beta/2, dx, dy);
%         
%     else
% 
%     end