clear
clc

load 'Syangben.txt'

M=Syangben;


X(1:90,1:8)= M(1:90,1:8);
% X(31:90,1:8)= M(61:120,1:8);
Y(1:90,1) = M(1:90,18);
% Y(31:90,1)= M(61:120,18);
a = M(121:140,1:8);
b = M(121:140,18);
e=[Y,X];
fid = fopen('sinc_train','w');
fprintf(fid,'%12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f\n',e');
e=e';
f =[b,a];
fid = fopen('sinc_test','w');
fprintf(fid,'%12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f\n',f');
f=f';
c=[500];

[TrainingTime, TestingTime, TrainingAccuracy, TestingAccuracy,TY] = elm_kernel('sinc_train', 'sinc_test', 0, 500, 'RBF_kernel',c)
