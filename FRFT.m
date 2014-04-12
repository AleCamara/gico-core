function out = FRFT(img, z, lambda, alpha, beta, dx, dy, varargin)
% [out] = FRFT(img, z, lambda, alpha, beta, dx, dy[, DBG])
%
%   This function is a wrapper that extends the FRFTcore() function range
%   from [pi/4, 3pi/4] to [0, 2pi].
%
%   As a convention, the first index is Y and the second X, that way, the
%   row axis is associated with Y, and the column with X.
%
%   Alpha & beta must be angles in radians.
%
% Copyright (c) 2014 GICO-UCM

    % Debug?
    if (nargin < 8)
        IS_DEBUG = 0;
    else
        IS_DEBUG = varargin{1};
    end
    
    if (nargin < 9)
        IS_EXTRA_DEBUG = 0;
    else
        IS_EXTRA_DEBUG = varargin{2};
    end

    % Just in case we are not unitary :-(
    %E = sum(sum(abs(img).^2));

    % Its useful to have the angles in a vector
    angle = [alpha, beta];

    % We only care for positive 2pi modular angles
    for iangle = 1:2
        % While the angle is negative, add 2pi
        while (angle(iangle) < 0)
            angle(iangle) = angle(iangle) + 2*pi;
        end;
        
        % Only the 2pi-modulus is important
        angle(iangle) = mod(angle(iangle), 2*pi);
    end;
    
    % Beyond this point, angle(i) is in the range [0, 2pi), for i=1,2
    
    % To limit the range to [0, pi) the only consequence is to flip the
    % signal
    
    % Check if we have to flip the X direction
    if (angle(1) >= pi)
        % We flip the signal left to right
        img = FRFTflip(img, 1);
        
        % Bring the angle to the [0, pi) range
        angle(1) = mod(angle(1), pi);
    end;
    
    % Check if we have to flip the Y direction
    if (angle(2) >= pi)
        % We flip the signal upside-down
        img = FRFTflip(img, 2);
        
        % Bring the angle to the [0, pi) range
        angle(2) = mod(angle(2), pi);
    end;
    
    % Beyond this point, angle(i) is in the range [0, pi), for i=1,2

    % Now the task is to move the angle to the range [pi/4, 3pi/4]. For the
    % realization we will use that:
    %
    %       FRFT(FRFT(a1,b1), a2,b2) = FRFT(a1+a2,b1+b2)
    
    % Is angle(1) in the right range?
    if (angle(1) > 3*pi/4)
        % We know that a1 = (a1-pi/2) + pi/2, where if a1 > 3pi/4, then
        % a1-pi/2 is in [pi/4, 3pi/4].
        angle(1) = angle(1)-pi/2;
        img = FRFT(img, z, lambda, pi/4, pi/2, dx, dy, IS_DEBUG);
        img = FRFT(img, z, lambda, pi/4, -pi/2, dx, dy, IS_DEBUG);
    elseif (angle(1) < pi/4)
        % We know that a1 = (a1+pi/2) - pi/2, where if a1 < pi/4, then
        % a1+pi/2 is in [pi/4, 3pi/4].
        angle(1) = angle(1)+pi/2;
        img = FRFT(img, z, lambda, 3*pi/4, pi/2, dx, dy, IS_DEBUG);
        img = FRFT(img, z, lambda, 3*pi/4, -pi/2, dx, dy, IS_DEBUG);
    end;
    
    % Is angle(2) in the right range?
    if (angle(2) > 3*pi/4)
        % We know that a1 = (a1-pi/2) + pi/2, where if a1 > 3pi/4, then
        % a1-pi/2 is in [pi/4, 3pi/4].
        angle(2) = angle(2)-pi/2;
        img = FRFT(img, z, lambda, pi/2, pi/4, dx, dy, IS_DEBUG);
        img = FRFT(img, z, lambda, -pi/2, pi/4, dx, dy, IS_DEBUG);
    elseif (angle(2) < pi/4)
        % We know that a1 = (a1+pi/2) - pi/2, where if a1 < pi/4, then
        % a1+pi/2 is in [pi/4, 3pi/4].
        angle(2) = angle(2)+pi/2;
        img = FRFT(img, z, lambda, pi/2, -pi/4, dx, dy, IS_DEBUG);
        img = FRFT(img, z, lambda, -pi/2, -pi/4, dx, dy, IS_DEBUG);
    end;
    
    % Finally, both angles are in the range [pi/4, 3pi/4]. Now is time to
    % perform the right FRFTcore.
    %out = FRFTcore(img, z, lambda, angle(1), angle(2), dx, dy, IS_DEBUG, IS_EXTRA_DEBUG);
    out = FRFTcore(img, z, lambda, angle(1), angle(2), dx, dy);
    
    % Just in case we are not unitary :-(
    %if( sum(sum(abs(out).^2)) ~= E )
    %    fprintf('Unitarity failure!!\n');
    %    out = out/sqrt(sum(sum(abs(out).^2)))*E;
    %end;