function [tdr,tdMSE] = tdoaRoute(BS,tr,ER)
% BS所有信标坐标 
% tr真实轨迹
% ER信标有效距离
% tdr tdoa估计的轨迹
tdr = [];%
tdMSE = []; %均方差
s = size(BS,1);%传感器总个数
n = size(tr,1);%运动步数
for i = 1:n
    pos = tr(i,:);
    effBS = [];
    for j = 1:s
        if sqrt(sum((pos-BS(j,:)).^2)) < ER
            effBS = [effBS;BS(j,:)];
        end
    end
    pos = pos';
    effBS = effBS';
    M = size(effBS,2);                         % 有效工作距离内的传感器
    ro = sqrt(sum((pos*ones(1,M)-effBS).^2))' ;     %True source-sensor ranges
    rdo = ro(2:end)-ro(1);
    R = (eye(M-1)+ones(M-1))/2;            % covariance structure of TDOA
    
    nsePwr = 10^(-6);
    Q = nsePwr * R  ;  
    rdNse = sqrt(nsePwr/2) * randn(M,1);
    rd = rdo + rdNse(2:end)-rdNse(1);  % Noisy source TDOAs (range differences).
    tdpos = TDOALoc(effBS,rd,Q)';
    tdr = [tdr;tdpos];
    tdMSE = [tdMSE;norm(tdpos'-pos,2)];
end
end

