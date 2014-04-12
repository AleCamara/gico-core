function A = ZeroUnpadArray(A0, S)
% IO = ZeroPadArray(I, S)
%
% Zero unpads the input image 'I' to fit the dimensions specified by the
% two-dimensional array 'S'. If the image has equal or smaller dimensions
% than the zero-unpadded ones, no crop is done.
%
% I:           Input image. Must be a 2D array.
% S = [NY NX]: Final size after cropping. If a single number is passed
%              then NY = NX is assumed.
% IO:          Zero-unpadded image.
%
% This function provides an inverse for [ZeroPadArray].
%
% Copyright (c) 2014 GICO-UCM
    if(nargin < 2)
        A = A0;
        return;
    end
    
    if(length(S) == 1)
        S = [S(1) S(1)];
    end
    
    % get the zeros to remove
    [NY, NX] = size(A0);
    S(1) = NY - S(1);
    S(2) = NX - S(2);
    
    % do not increase zeros
    S(S < 0) = 0;
    
    PREX = floor(S(2)/2);
    POSTX = ceil(S(2)/2);
    PREY = floor(S(1)/2);
    POSTY = ceil(S(1)/2);
    
    A = A0((PREY+1):(end-POSTY), (PREX+1):(end-POSTX));
end