function out = SFT(img, s, dx, dy, varargin)
% [out] = SFT(img, s, dx, dy)
%
% Performs the scaled Fourier transform for scale 's' to the 
% 2D signal 'img' with spacing 'dx' and 'dy'.
%
% Copyright (c) 2014 GICO-UCM

    % Debug?
    if (nargin < 5)
        IS_DEBUG = 0;
    else
        IS_DEBUG = varargin{1};
    end
    
    if (nargin < 6)
        IS_EXTRA_DEBUG = 0;
    else
        IS_EXTRA_DEBUG = varargin{2};
    end
    
    %IS_DEBUG
    %IS_EXTRA_DEBUG
    
    % Get the size of the input signal
    [Ny, Nx] = size(img);

    % Get the x/y and px/py axis
    x = ((0:Nx-1)-Nx/2)*dx;
    y = ((0:Ny-1)-Ny/2)*dy;
    px = x / dx^2 / Nx;
    py = y / dy^2 / Ny;

    % Obtain the grids for the real and conjugate spaces
    [xx, yy] = meshgrid(x, y);
    [pxx, pyy] = meshgrid(px, py);
    
    % External phase
    ph1 = exp(-pi*1i*(xx.^2 + yy.^2)/s^2);

    % Convolution phase
    ph2 = exp(1i*pi/2).*exp(-pi*1i*s^2*(pxx.^2 + pyy.^2));

    % out = ph1 .* ifft2(fft2(img.*ph1) .* fftshift(ph2));
    % TO BE DELETED IN THE FINAL VERSION!
    if(IS_DEBUG && IS_EXTRA_DEBUG)
        imgph1 = img.*ph1;
        fftimgph1 = ifftshift(fft2(fftshift(imgph1)));
        ph2fftimgph1 = fftimgph1.*ph2;
        ifftph2fftimgph1 = fftshift(ifft2(ifftshift(ph2fftimgph1)));
        out = ph1.*ifftph2fftimgph1;
    else    
        temp = ifftshift(fft2(fftshift(img.*ph1))).*ph2;
        out = ph1.*ifftshift(ifft2(fftshift(temp)));
    end
    
    if (IS_DEBUG)
        if(IS_EXTRA_DEBUG)
            figure('color', 'white'),
            if(1)
                subplot(2, 4, 1), imagesc(abs(imgph1));
                subplot(2, 4, 2), imagesc(angle(imgph1));
                subplot(2, 4, 3), imagesc(abs(fftimgph1));
                subplot(2, 4, 4), imagesc(angle(fftimgph1));
                subplot(2, 4, 5), imagesc(abs(ph2fftimgph1));
                subplot(2, 4, 6), imagesc(angle(ph2fftimgph1));
                subplot(2, 4, 7), imagesc(abs(ifftph2fftimgph1));
                subplot(2, 4, 8), imagesc(angle(ifftph2fftimgph1));
            else
                subplot(2, 4, 1), imagesc(real(imgph1));
                subplot(2, 4, 2), imagesc(imag(imgph1));
                subplot(2, 4, 3), imagesc(real(fftimgph1));
                subplot(2, 4, 4), imagesc(imag(fftimgph1));
                subplot(2, 4, 5), imagesc(real(ph2fftimgph1));
                subplot(2, 4, 6), imagesc(imag(ph2fftimgph1));
                subplot(2, 4, 7), imagesc(real(ifftph2fftimgph1));
                subplot(2, 4, 8), imagesc(imag(ifftph2fftimgph1));
            end
        end
        figure('color', 'white'),
            subplot(1, 2, 1), imagesc(angle(ph1));
            subplot(1, 2, 2), imagesc(angle(ph2));
    end
end