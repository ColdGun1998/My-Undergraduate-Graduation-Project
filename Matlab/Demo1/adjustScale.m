function outputMatrix = adjustScale( inputMatrix, minVal, maxVal )
%��һ��ͼ����ֵ��Χ���쵽minVal~maxVal֮��
minmum=min(min(inputMatrix));
maxmum=max(max(inputMatrix));
outputMatrix=(inputMatrix-minmum)/(maxmum-minmum);
outputMatrix=minVal+outputMatrix*(maxVal-minVal);


