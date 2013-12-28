File Edit Options Buffers Tools Octave Help
% V is a vector that has the form [x,a,y,b,z,c] where x,y,z is the center
% and a,b,c are the radii
% N is the number of points to produce
function [P] = ellipsoidPoints(v,N)

    actualN = 100000; % apparently there will be some points that wont be in the ellipsoid
    % so just make twice as many and hope (ya hope, is 4am!) that there are
    % enough

    if N > actualN
        actualN = N;
    end

    isIn = @(x,y,z,ell) (((x-ell(1)).^2)/(ell(2).^2)...
                      + ((y-ell(3)).^2)/(ell(4).^2)...
                      + ((z-ell(5)).^2)/(ell(6).^2)) <= 1;

    X = v(1) + 2*v(2)*(rand(actualN,1)-.5);
    Y = v(3) + 2*v(4)*(rand(actualN,1)-.5);
    Z = v(5) + 2*v(6)*(rand(actualN,1)-.5);
    isInV = find(isIn(X,Y,Z,v) == 1); % find the points actually in the ellipsoid
    P = [X,Y,Z];
    P = P(isInV,:); % get those points out
    P = P(1:N,:); % take the first N

end

