function [ldr,ldMSE] = lidarRoute(tr,side,LR)
%tr ��ʵ�켣
%size ���ش�С
%LR ������Ч��������
ldr = [];
ldMSE = [];
n = size(tr,1); %�˶�����
v = 10^(-2); %��������
for i = 1:n
    pos = tr(i,:);
    ldpos = pos + sqrt(v)*randn(1,2);
    if pos(:,1)>LR && pos(:,1)<side-LR
        ldpos(:,1)=ldpos(:,1)+sqrt(v*min(pos(:,1),abs(pos(:,1)-side)))*randn();
    end
    if pos(:,2)>LR && pos(:,2)<side-LR
        ldpos(:,2)=ldpos(:,2)+sqrt(v*min(pos(:,2),abs(pos(:,2)-side)))*randn();
    end
    ldr = [ldr;ldpos];
    ldMSE = [ldMSE;norm(ldpos-pos,2)];
end

end

