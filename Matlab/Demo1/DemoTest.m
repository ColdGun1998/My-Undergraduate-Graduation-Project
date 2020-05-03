uo = [0.8 4.7]';                        % True source position.

% x=[0 -5 4 -2 7 -7 2 -4 3 1];            % True sensor position matrix.
% y=[0 8 6 4 3 5 5 2 3 8];
x = [0.0 0.0 5.01 10.49 10.49 3.46];
y = [5.53 0.65 0.0 0.35 5.41 6.19];
S=[x; y];

M = size(S,2);                          % Number of sensors.
N = size(S,1);                          % Dimension of localization.

ro = sqrt(sum((uo*ones(1,M)-S).^2))'
size(ro)