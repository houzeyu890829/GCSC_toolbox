function error=KELMdnapl_setup_D(c)
%y标准化了精度高，用这个
% figure(1);
% plot(d,'o-');
% % grid on;
% b2 = M(31:60,18);
% b3 = M(1:30,18);
%%
load 'Syangben.txt'
M=Syangben;
b1 = M(201:220,14);

kernel_pars(1:3)=[c(1,2),c(1,3),c(1,4)];
%train
%[TrainingTime, TestingTime, TrainingAccuracy, TestingAccuracy] = elm('sinc_train', 'sinc_test', 0, 20, 'sig')
%[TrainingTime, TestingTime, TrainingAccuracy, TestingAccuracy] = elm_kernel('sinc_train1', 'sinc_test1', 0, 9000, 'RBF_kernel',2000)
%[TrainingTime, TestingTime, TrainingAccuracy, TestingAccuracy] = elm_kernel('mpg_train', 'mpg_test', 0, 990, 'RBF_kernel',2)
[TrainingTime1, TestingTime1, TrainingAccuracy1, TestingAccuracy1,TY1] = elm_kernel('sinc_train1', 'sinc_test1', 0, c(1,1), 'wav_kernel',kernel_pars);
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
TY1=TY1';

error=sum(abs(TY1-b1));


% [TrainingTime2, TestingTime2, TrainingAccuracy2, TestingAccuracy2,TY2] = elm_kernel('sinc_train2', 'sinc_test2', 0, c(1), 'RBF_kernel',c(2));
% TY2=TY2';
% error2=sum(abs(TY2-b2));
% 
% 
% 
% 
% [TrainingTime3, TestingTime3, TrainingAccuracy3, TestingAccuracy3,TY3] = elm_kernel('sinc_train3', 'sinc_test3', 0, c(1), 'RBF_kernel',c(2));
% TY3=TY3';
% error3=sum(abs(TY3-b3));
% 
% error=error1+error2+error3;
% error=TrainingAccuracy1+TrainingAccuracy2+TrainingAccuracy3;