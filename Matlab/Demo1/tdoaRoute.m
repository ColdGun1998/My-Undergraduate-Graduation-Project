function [tdr,tdMSE] = tdoaRoute(BS,tr,ER)
% BS�����ű����� 
% tr��ʵ�켣
% ER�ű���Ч����
% tdr tdoa���ƵĹ켣
tdr = [];%
tdMSE = []; %������
s = size(BS,1);%�������ܸ���
n = size(tr,1);%�˶�����
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
    M = size(effBS,2);                         % ��Ч���������ڵĴ�����
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

