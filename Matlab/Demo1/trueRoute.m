function tr = trueRoute(side)
n=1000;        %���ߵĲ���
x=0;            %��ʼx����
y=0;            %��ʼy����
tr=zeros(n,2);
neighbour=[0 -1;-1,0;-1 -1;-1 1;1 -1;1 0;1 0;0 1;0 1;1 1];  %
for i=1:n
    r=floor(1+10*rand());    %ѡ�����߷���
    y=y+neighbour(r,1);     %y��������
    x=x+neighbour(r,2);     %x��������
    tr(i,:)=[y x];         %��������
end
tr=rescale(tr,0,side);   %��������������size*size��Χ��
end

