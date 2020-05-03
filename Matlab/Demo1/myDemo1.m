clc;
close all;
clear all;

%% ��ͼ
% ��λ���-��ͬ������
% ƽ����λ���-�ű���Ч��������
% ƽ����Ч��վ����-�ű���Ч��������
% ƽ����λ���-��ͬ�������

%% ��ȡ�����ļ�conf.xml
xmlDoc = xmlread('conf.xml');
side = readConf(xmlDoc,'size');
interval = readConf(xmlDoc,'interval');
ER = 10000;
LR = 30;

%% �������ź��ű�ڵ�
BS = [];
for x = 0:interval:side
    for y = 0:interval:side
        BS = [BS;x,y];
    end
end

%% ������ʵ�켣
tr = trueRoute(side);
plot(tr(:,1),tr(:,2),'r');hold on;

%% TDOA���ƹ켣
[tdr,tdMSE] = tdoaRoute(BS,tr,ER);
plot(tdr(:,1),tdr(:,2),'g');


%% ���߼�����ƹ켣
[ldr,ldMSE] = lidarRoute(tr,side,LR);
plot(ldr(:,1),ldr(:,2),'y-');

%% ��ͼ
figure;
%%��λ���-����
plot(tdMSE,'r');hold on;
plot(ldMSE,'g');

%%ƽ����λ���-�ű깤������


