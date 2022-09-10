function error=KELMdnapl_setup_D(c)

load 'Syangben.txt'
M=Syangben;
b1 = M(201:220,14);

kernel_pars(1:3)=[c(1,2),c(1,3),c(1,4)];

[TrainingTime1, TestingTime1, TrainingAccuracy1, TestingAccuracy1,TY1] = elm_kernel('sinc_train1', 'sinc_test1', 0, c(1,1), 'wav_kernel',kernel_pars);

TY1=TY1';

error=sum(abs(TY1-b1));


