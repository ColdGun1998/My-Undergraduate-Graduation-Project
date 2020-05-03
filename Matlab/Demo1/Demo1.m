% This program provides an example on how to call TDOALoc.m 
% and TDOALocCRLB.m. 
%
% This program will reproduce the new method result in Fig. 4 of Y. T. Chan 
% and K. C. Ho, "A Simple and Efficient Estimator for Hyperbolic Location,"
% IEEE Trans. Signal Processing, vol. 42, no. 8, pp. 1905-1915, Aug. 1994.
%
%
% Ming Sun, K. C. Ho     08-01-2009
%
%       Copyright (C) 2009
%       Computational Intelligence Signal Processing Laboratory
%       University of Missouri
%       Columbia, MO 65211, USA.
%       hod@missouri.edu
%

clc; close all; clear all;warning off;  % Program initialization.
L = 10e1;                               % Number of ensemble runs.            
randn('seed',0);                        % Initialize random number generator.

uo = [0.8 4.7]';                        % True source position.

% x=[0 -5 4 -2 7 -7 2 -4 3 1];            % True sensor position matrix.
% y=[0 8 6 4 3 5 5 2 3 8];
x = [0.0 0.0 5.01 10.49 10.49 3.46];
y = [5.53 0.65 0.0 0.35 5.41 6.19];
S=[x; y];

M = size(S,2);                          % Number of sensors.
N = size(S,1);                          % Dimension of localization.

ro = sqrt(sum((uo*ones(1,M)-S).^2))';   % True source-sensor ranges
rdo = ro(2:end)-ro(1);

R = (eye(M-1)+ones(M-1))/2;          % covariance structure of TDOA

NsePwrVecdB=-60:4:-24; 

fprintf('Simulation in progress');
uuu=[];
uu=[];
for nseIdx=length(NsePwrVecdB)       % vary measurement noise level
    fprintf('.');
    nsePwr = 10^(NsePwrVecdB(nseIdx)/10);
    Q = nsePwr * R;                     % Covariance matrix of TDOA (range difference) noise
    crlb(nseIdx)=trace(TDOALocCRLB(S,uo,Q));
    
    SimulationMSE = 0;
    for k = 1 : L                      % Monte Carlo Simulation.
        rdNse = sqrt(nsePwr/2) * randn(M,1);
        rd = rdo + rdNse(2:end)-rdNse(1);   % Noisy source TDOAs (range differences).
        u = TDOALoc(S,rd,Q);
        uu = [uu u];
        SimulationMSE = SimulationMSE + norm(u-uo,2)^2;
    end
    mse(nseIdx) = SimulationMSE/L;
    uuu=[uuu;uu];
    uu=[];
end
fprintf('\n');

% Plot the results.
scatter(uuu(1,:),uuu(2,:));
% figure(1); plot(NsePwrVecdB/2,10*log10(mse),'xk','MarkerSize',8); hold on;
% plot(NsePwrVecdB/2,10*log10(crlb),'k'); grid on; hold off;

% xlabel('10 log(c\sigma)'); 
% ylabel('10 log(MSE)');
% legend('New Method','CRLB');
% ylim([0 60]);

