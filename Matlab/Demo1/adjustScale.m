function outputMatrix = adjustScale( inputMatrix, minVal, maxVal )
%把一幅图的数值范围拉伸到minVal~maxVal之间
minmum=min(min(inputMatrix));
maxmum=max(max(inputMatrix));
outputMatrix=(inputMatrix-minmum)/(maxmum-minmum);
outputMatrix=minVal+outputMatrix*(maxVal-minVal);


