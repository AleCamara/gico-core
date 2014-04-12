function [out] = ConvertPolarCartesian(in, neg_rad, method, extrapol_val, varargin)
% [img_out x y] = ConvertPolarCartesian(img_in, neg_rad = 0, method = 'spline', extrapol_val = NaN)
%
% Converts the image in polar coodinates given by img_in into the image in
% Cartesian coordinates img_out.
%
% neg_rad is the negative radius flag. If true (1) the radial variable
% spans negative values and the azimuthal (angle) variable spans only in a
% pi-range.
%
% method is a string with the interpolation method. Only valid values are
% 'nearest', 'linear', 'spline', and 'cubic'.
%
% extrapol_val is a the value to use when there is extrapolation instead of
% interpolation. By default it is NaN.
%
% Copyright (c) 2014 GICO-UCM

    if(nargin < 1)
        error('(EE) ConvertPolarCartesian: Insufficient input arguments.');
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
            fprintf('(WW) ConvertPolarCartesian: unknown method, using "%s" instead.\n', method);
        end
    end
    if(nargin < 4)
        extrapol_val = NaN;
    end
    
    [NR, Na] = size(in);
    if(neg_rad)
        dR = 2/NR;
        da = pi/Na;
        R = ((0:NR-1)-NR/2)*dR;
        a = (0:Na-1)*da;
    else
        dR = 1/NR;
        da = 2*pi/(Na-1);
        R = (0:NR-1)*dR;
        a = ((0:Na-1))*da;
    end
    [a2, R2] = meshgrid(a, R);
    
    x = ((0:NR-1)-floor(NR/2))*2/NR;
    y = ((0:NR-1)-floor(NR/2))*2/NR;
    [xx, yy] = meshgrid(x, y);
    
    [aa, RR] = cart2pol(xx, yy);
    if(neg_rad)
        val = aa < 0;
        RR(val) = -RR(val);
        aa(val) = aa(val)+pi;
    else
        aa = mod(aa, 2*pi);
    end
    
    out = interp2(a2, R2, in, aa, RR, method, extrapol_val);
    %out(xx.^2 + yy.^2 >= 1) = 0;
end