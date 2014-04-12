function PlaceTimeTitle()
% PlaceTimeTitle()
%
% Place current time in the title of the active figure.
%
% Copyright (c) 2014 GICO-UCM

    C = fix(clock);
    title(sprintf('Time: %02.0f:%02.0f:%02.0f', C(4), C(5), C(6)));
end