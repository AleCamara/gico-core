function out = FRFTflip(img, dim)
%  out = FRFTflip(img, dim):
%
%      Flips the matrix img upside-down (dim == 2) or left to right (dim ==
%      1). Takes into account that for even dimension the position of the
%      center has to be kept.
%
% Copyright (c) 2014 GICO-UCM

    % Get the size of the matrix
    [Ny, Nx] = size(img);
    
    switch dim
        
        % This is about the X direction
        case 1;
            % Flips left to right
            out = fliplr(img);
            
            % This only applies if Nx is even
            if (mod(Nx, 2) == 0)
                tmp = out;
                tmp(:, 1:Nx-1) = out(:, 2:Nx);
                tmp(:, Nx) = out(:, 1);
                out = tmp;
                clear tmp;
            end;
        
        % This is about the Y direction    
        case 2;
            % Flips upside-down
            out = flipud(img);
            
            % This only applies if Ny is even
            if (mod(Ny, 2) == 0)
                tmp = out;
                tmp(1:Ny-1, :) = out(2:Ny, :);
                tmp(Ny, :) = out(1, :);
                out = tmp;
                clear tmp;
            end;
            
    end;