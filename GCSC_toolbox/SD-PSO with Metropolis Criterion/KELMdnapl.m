function F=KELMdnapl(Q)

load 'Syangben.txt'

M=Syangben;

X(1:200,1:12)= M(1:200,1:12);
Y1(1:200,1) = M(1:200,13);
Y2(1:200,1) = M(1:200,14);
Y3(1:200,1) = M(1:200,15);
Y4(1:200,1) = M(1:200,16);
Y5(1:200,1) = M(1:200,17);
Y6(1:200,1) = M(1:200,18);
Y7(1:200,1) = M(1:200,19);
Y8(1:200,1) = M(1:200,20);
a = Q;
b = 1;
e1=[Y1,X];
fid1 = fopen('sinc_train1','w');
fprintf(fid1,'%12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f\n',e1');
e1=e1';
e2=[Y2,X];
fid2 = fopen('sinc_train2','w');
fprintf(fid2,'%12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f\n',e2');
e2=e2';
e3=[Y3,X];
fid3 = fopen('sinc_train3','w');
fprintf(fid3,'%12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f\n',e3');
e3=e3';
e4=[Y4,X];
fid4 = fopen('sinc_train4','w');
fprintf(fid4,'%12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f\n',e4');
e4=e4';
e5=[Y5,X];
fid5 = fopen('sinc_train5','w');
fprintf(fid5,'%12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f\n',e5');
e5=e5';
e6=[Y6,X];
fid6 = fopen('sinc_train6','w');
fprintf(fid6,'%12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f\n',e6');
e6=e6';
e7=[Y7,X];
fid7 = fopen('sinc_train7','w');
fprintf(fid7,'%12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f\n',e7');
e7=e7';
e8=[Y8,X];
fid8 = fopen('sinc_train8','w');
fprintf(fid8,'%12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f\n',e8');
e8=e8';
f =[b,a];
fid9 = fopen('sinc_test','w');
fprintf(fid9,'%12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f\n',f');
f=f';
%%
%train
TY1 = elm_kernel('sinc_train1', 'sinc_test', 0, 3549.93884837445, 'wav_kernel',[63.3476973279624,3164.28348163615,535.533340469996]);
TY2 = elm_kernel('sinc_train2', 'sinc_test', 0, 4106.60418223155, 'wav_kernel',[31.1104164752488,4051.07955402373,2442.14985719770]);
TY3 = elm_kernel('sinc_train3', 'sinc_test', 0, 99.3966778933012, 'wav_kernel',[6.53214170134490,2492.32231373555,557.062851401056]);
TY4 = elm_kernel('sinc_train4', 'sinc_test', 0, 3252.68094711545, 'wav_kernel',[57.0253560848640,4356.28950858979,970.924498049155]);
TY5 = elm_kernel('sinc_train5', 'sinc_test', 0, 1600.89082118543, 'wav_kernel',[20.8691086134049,3910.54858438815,1870.12464729323]);
TY6 = elm_kernel('sinc_train6', 'sinc_test', 0, 1802.85771944695, 'wav_kernel',[21.8315311322073,2604.39433030469,1258.29239056386]);
TY7 = elm_kernel('sinc_train7', 'sinc_test', 0, 4312.42151547735, 'wav_kernel',[26.4992803483987,3717.03878778335,2354.94067066731]);
TY8 = elm_kernel('sinc_train8', 'sinc_test', 0, 3945.97735366158, 'wav_kernel',[44.4131516341314,2098.56561391251,1181.20845506216]);
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
fclose(fid1);
fclose(fid2);
fclose(fid3);
fclose(fid4);
fclose(fid5);
fclose(fid6);
fclose(fid7);
fclose(fid8);
fclose(fid9);
F=[TY1,TY2,TY3,TY4,TY5,TY6,TY7,TY8];
