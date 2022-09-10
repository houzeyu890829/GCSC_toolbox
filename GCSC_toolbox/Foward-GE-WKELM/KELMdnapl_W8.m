clear
clc

load 'Syangben.txt'

M=Syangben;


X(1:200,1:12)= M(1:200,1:12);

Y(1:200,1) = M(1:200,20);

a = M(201:220,1:12);
b = M(201:220,20);
e=[Y,X];
fid = fopen('sinc_train','w');
fprintf(fid,'%12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f\n',e');
e=e';
f =[b,a];
fid = fopen('sinc_test','w');
fprintf(fid,'%12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f\n',f');
f=f';

kernel_pars(1:3)=[44.4131516341314,2098.56561391251,1181.20845506216];

[TrainingTime, TestingTime, TrainingAccuracy, TestingAccuracy,TY] = elm_kernel('sinc_train', 'sinc_test', 0, 3945.97735366158, 'wav_kernel',kernel_pars)
