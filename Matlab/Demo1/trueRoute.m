function tr = trueRoute(side)
n=1000;        %游走的步数
x=0;            %初始x坐标
y=0;            %初始y坐标
tr=zeros(n,2);
neighbour=[0 -1;-1,0;-1 -1;-1 1;1 -1;1 0;1 0;0 1;0 1;1 1];  %
for i=1:n
    r=floor(1+10*rand());    %选择游走方向
    y=y+neighbour(r,1);     %y方向游走
    x=x+neighbour(r,2);     %x方向游走
    tr(i,:)=[y x];         %保存坐标
end
tr=rescale(tr,0,side);   %像素坐标缩放至size*size范围内
end

