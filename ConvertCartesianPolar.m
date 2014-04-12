function [out] = ConvertCartesianPolar(in, neg_rad, method, extrapol_val, varargin)
% [img_out R a] = ConvertPolarCartesian(img_in, neg_rad = 0, method = 'spline', extrapol_val = NaN)
%
% Converts the image in Cartesian coodinates given by img_in into the image
% in polar coordinates img_out.
%
% neg_rad is the negative radius flag. If true (1) the radial variable
% spans negative values and the azimuthal (angle) variable spans only in 
% the positive pi-range.
%
% method is a string with the interpolation method. Only valid values are
% 'nearest', 'linear', 'spline', and 'cubic'.
%
% extrapol_val is a the value to use when there is extrapolation instead of
% interpolation. By default it is NaN.
%
% NOTICE: img_in must be a squared matrix.
%
% Copyright (c) 2014 GICO-UCM

    if(nargin < 1)
        error('(EE) ConvertCartesianPolar: Insufficient input arguments.');
    end
    if(nargin < 2)
        neg_rad = 0;
    end
    if(nargin < 3)
        method = 'spline';
    else
        method = lower(method);
        
        if(~strcmp(method, 'nearest') && ...
           ~strcmp(method, 'linear') && ...
           ~strcmp(method, 'spline') && ...
           ~strcmp(method, 'cubic'))
            method = 'spline';
            fprintf('(WW) ConvertCartesianPolar: unknown method, using "%s" instead.\n', method);
        end
    end
    if(nargin < 4)
        extrapol_val = NaN;
    end
    
    [Ny, Nx] = size(in);
    if(Ny ~= Nx)
        error('img_in must be a squared matrix.');
    end
    N = Nx;
    clear Nx Ny;
    
    x = ((0:N-1)-N/2)*2/N;
    y = ((0:N-1)-N/2)*2/N;
    [xx, yy] = meshgrid(x, y);
    
    if(neg_rad)
        R = ((0:N-1)-N/2)*2/N;
        a = (0:N-1)*pi/N;
    else
        R = (0:N-1)/N;
        a = ((0:N-1))*2*pi/(N-1);
    end
    [RR, aa] = meshgrid(R, a);

    [xi, yi] = pol2cart(aa, RR);
    
    out = interp2(xx, yy, in, xi, yi, method, extrapol_val).';
end