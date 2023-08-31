clear
clc
%y标准化了精度高，用这个
% figure(1);
% plot(d,'o-');
% % grid on;
% whos d;
load 'Syangben.txt'

M=Syangben;


X(1:200,1:8)= M(1:200,13:20);
% X(31:90,1:8)= M(61:120,1:8);
Y(1:200,1) = M(1:200,11);
% Y(31:90,1)= M(61:120,18);
a = M(201:220,13:20);
b = M(201:220,11);
e=[Y,X];
fid = fopen('sinc_train','w');
fprintf(fid,'%12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f\n',e');
e=e';
f =[b,a];
fid = fopen('sinc_test','w');
fprintf(fid,'%12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f\n',f');
f=f';
%%
kernel_pars1(1:2)=[2.86606916386095,6.70584221797711];
kernel_pars2(1)=[10.1993981063187];
kernel_pars3(1:3)=[10.1993981063187,3921.03355887632,706.681928237734];
%train
[TrainingTime, TestingTime, TrainingAccuracy, TestingAccuracy,TY1] = elm_kernel('sinc_train', 'sinc_test', 0, 1.43914912459699, 'poly_kernel',kernel_pars1);
[TrainingTime, TestingTime, TrainingAccuracy, TestingAccuracy,TY2] = elm_kernel('sinc_train', 'sinc_test', 0, 4999.99955296515, 'RBF_kernel',kernel_pars2);
[TrainingTime, TestingTime, TrainingAccuracy, TestingAccuracy,TY3] = elm_kernel('sinc_train', 'sinc_test', 0, 4999.99955296515, 'wav_kernel',kernel_pars3);
TY=0.5314*TY1+0.3017*TY2+0.1669*TY3;
TY=TY';
