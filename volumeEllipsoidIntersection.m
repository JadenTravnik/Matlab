%% Approximates the intersection volume between 2 3d ellipsoids
% e1 and e2 are vectors of the form e = [mu_1,sig_1,mu_2,sig_2,mu_3,sig_3]
% where mu_i and sig_i are the mean and variance along some axis
% voxAcc is the volxel (3dPixel) accuracy (default: 1000000)
% essentially we make a bunch of random points that fit inside one
% ellipsoid and then find what percentage land in the other ellipsoid.
% Multiplying the percentage with the volume of the first gives a
% somewhat reasonable approximation of the volume of the intersection.
%
% Author: Jaden Travnik
%
% Feel free to distribute or whatever

function [vol] = volumeEllipsoidIntersection(e1,e2, voxAcc)
    if nargin < 3
        voxAcc = 10000;
    end

    % calculates the volume of an ellipsoid
    calcVol = @(v) (4/3)*pi*v(2)*v(4)*v(6);

    % find if the points are in an ellipsoid
    isIn = @(x,y,z,ell) (((x-ell(1)).^2)/(ell(2).^2)...
                      + ((y-ell(3)).^2)/(ell(4).^2)...
                      + ((z-ell(5)).^2)/(ell(6).^2)) <= 1;


    % calc the volume of the first ellipsoid
    volE1 = calcVol(e1);

    % create ellipsoid points
    T = ellipsoidPoints(e1,voxAcc);

    % find which are in the other ellipsoid
    isInOther = isIn(T(:,1),T(:,2),T(:,3),e2);

% You can use these commands to see what is going on
%     outside = find(isInOther == 0);
%     outside = T(outside,:);
%     inside = find(isInOther == 1);
%     inside = T(inside,:);
%     hold on;
%     scatter3(outside(:,1),outside(:,2),outside(:,3),'r.');
%     scatter3(inside(:,1),inside(:,2),inside(:,3),'g.');
%     [x,y,z] = ellipsoid(e2(1),e2(3),e2(5),e2(2),e2(4),e2(6));
%     M = mesh(x,y,z);
%     set(M,'facecolor','none')
%     set(M,'edgecolor',[.2 .4 .9])
%     hold off;


    % "calc" the volume of the intersection
    vol = (sum(isInOther)/voxAcc)*volE1;
end
