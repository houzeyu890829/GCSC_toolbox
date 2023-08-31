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
Y(1:200,1) = M(1:200,2);
% Y(31:90,1)= M(61:120,18);
a = M(201:220,13:20);
b = M(201:220,2);
e=[Y,X];
fid = fopen('sinc_train','w');
fprintf(fid,'%12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f\n',e');
e=e';
f =[b,a];
fid = fopen('sinc_test','w');
fprintf(fid,'%12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f\n',f');
f=f';
%%
kernel_pars1(1:2)=[4740.54693402490,2.46226794905269];
kernel_pars2(1:3)=[5.02392664623042];
kernel_pars3(1:3)=[5.02392664623042,4181.69317190925,1.54063110174629];
%train
[TrainingTime, TestingTime, TrainingAccuracy, TestingAccuracy,TY1] = elm_kernel('sinc_train', 'sinc_test', 0, 1962.78130897228, 'poly_kernel',kernel_pars1);
[TrainingTime, TestingTime, TrainingAccuracy, TestingAccuracy,TY2] = elm_kernel('sinc_train', 'sinc_test', 0, 5000, 'RBF_kernel',kernel_pars2);
[TrainingTime, TestingTime, TrainingAccuracy, TestingAccuracy,TY3] = elm_kernel('sinc_train', 'sinc_test', 0, 5000, 'wav_kernel',kernel_pars3);
TY=0.5314*TY1+0.3017*TY2+0.1669*TY3;
TY=TY';
% fid = fopen('TY1','w');
% fprintf(fid,'%2.8f\n',TY);
% TY2=load('TY1')
% [TrainingTime, TrainingAccuracy]=elm_train('sinc_train', 0, 20, 'sig')
% [TestingTime, TestingAccuracy] = elm_predict('sinc_test')
%TY=[-0.4744	-0.9236	0.5047	0.3408	-0.2459	0.8941	-0.2186	-0.4021	-0.5576	0.9114	-0.1027	-0.9459	-0.7833	-0.8742	0.4307	-0.0056	-0.3316	0.6325	-0.0568	0.5446]
% predict=mapminmax('reverse',TY2',DATA1ps)
% predict=predict';

% figure(1)
% hold on;
% plot(predict,'r*-');
% legend('original','predict');
% % title('矿山地质环境评价及预测的SVM网络模型预测结果输出曲线');
% xlabel('Sample points');
% ylabel('Comprehensive index');
% hold off