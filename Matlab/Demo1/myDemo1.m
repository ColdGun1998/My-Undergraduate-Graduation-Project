clc;
close all;
clear all;

%% 画图
% 定位误差-不同采样点
% 平均定位误差-信标有效工作距离
% 平均有效基站数量-信标有效工作距离
% 平均定位误差-不同噪声误差

%% 读取配置文件conf.xml
xmlDoc = xmlread('conf.xml');
side = readConf(xmlDoc,'size');
interval = readConf(xmlDoc,'interval');
ER = 10000;
LR = 30;

%% 部署声信号信标节点
BS = [];
for x = 0:interval:side
    for y = 0:interval:side
        BS = [BS;x,y];
    end
end

%% 产生真实轨迹
tr = trueRoute(side);
plot(tr(:,1),tr(:,2),'r');hold on;

%% TDOA估计轨迹
[tdr,tdMSE] = tdoaRoute(BS,tr,ER);
plot(tdr(:,1),tdr(:,2),'g');


%% 单线激光估计轨迹
[ldr,ldMSE] = lidarRoute(tr,side,LR);
plot(ldr(:,1),ldr(:,2),'y-');

%% 画图
figure;
%%定位误差-步数
plot(tdMSE,'r');hold on;
plot(ldMSE,'g');

%%平均定位误差-信标工作距离


