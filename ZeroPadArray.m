function IO = ZeroPadArray(I, S)
% IO = ZeroPadArray(I, S)
%
% Zero pads the input image 'I' to fit the dimensions specified by the
% two-dimensional array 'S'. If the image has equal or larger dimensions
% than the zero-padded ones, no zeros are added.
%
% I:           Input image. Must be a 2D array.
% S = [NY NX]: Final size after zero-padding. If a single number is passed
%              then NY = NX is assumed.
% IO:          Zero-padded image.
%
% This function provides an inverse for [ZeroUnpadArray].
%
% Copyright (c) 2014 GICO-UCM

    if(nargin < 2)
        error('Insufficient input arguments');
    end
    
    % check I
    if(ndims(I) ~= 2)
        error('I must be a 2D array');
    end
    
    % check S
    if(~isvector(S) || numel(S) > 2 || numel(S) < 1)
        error('S must be a 2-element or 1-element vector.');
    end
    if(numel(S) ==1)
        S = [S(1) S(1)];
    end
    
    % number of zeros to add
    [NY NX] = size(I);
    INC = S - [NY NX];
    INC(INC < 0) = 0;     % we do not decrease the size
    
    % when INC is odd we add more zeros on the left (top) than in the right
    % (bottom)
    PREINC = ceil(INC/2);
    POSTINC = floor(INC/2);
    
    IO = padarray(I, PREINC, 'pre');
    IO = padarray(IO, POSTINC, 'post');
end