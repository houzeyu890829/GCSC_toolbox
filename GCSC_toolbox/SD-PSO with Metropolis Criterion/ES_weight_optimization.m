clear
clc


%定义遗传算法参数
NIND=80;               %个体数目(Number of individuals)
MAXGEN=400;             %最大遗传代数(Maximum number of generations)
NVAR=3;                %变量数目
PRECI=25;              %变量的二进制位数(Precision of variables)
GGAP=0.8;              %代沟(Generation gap)
%建立区域描述器(Build field descriptor)
FieldD=[rep([PRECI],[1,NVAR]);rep([0;10000],[1,NVAR]);rep([1;0;1;1],[1,NVAR])];
Chrom=crtbp(NIND, NVAR*PRECI);                         %创建初始种群
gen=0;                                                 
trace=zeros(MAXGEN,7);                                 %遗传算法性能跟踪初始值
c=bs2rv(Chrom, FieldD);                                %初始种群十进制转换
[ar1 ac1]=size(c);
for i=1:ar1
    ObjV(i,:)=ES_weight_setup(c(i,1:3));      %计算初始种群的目标函数值
end
while gen<MAXGEN
    FitnV=ranking(ObjV);                               %分配适应度值(Assign fitness values)
    SelCh=select('sus',Chrom,FitnV,GGAP);              %选择
    SelCh=recombin('xovsp',SelCh,0.7);                 %重组
    SelCh=mut(SelCh);                                  %变异
    c=bs2rv(SelCh,FieldD);                             %子代十进制转换
    [ar2 ac2]=size(c);
    for i=1:ar2
    ObjVSel(i,:)=ES_weight_setup(c(i,1:3)); 
    end
    [Chrom ObjV]=reins(Chrom,SelCh,1,1,ObjV,ObjVSel);  %重插入
    gen=gen+1;
    [M, I]=min(ObjV);
    M,bs2rv(Chrom(I,:),FieldD)                         %输出每一次的最优解及其对应的自变量值
    trace(gen,1)=min(ObjV);                            %遗传算法性能跟踪
    trace(gen,2)=sum(ObjV)/length(ObjV);
    trace(gen,3:5)=bs2rv(Chrom(I,:),FieldD);
end
%% 结果分析
figure;
hold on;%使所有线画在一张图上
plot(trace(:,1),'r*-','LineWidth',1.5);
plot(trace(:,2),'o-','LineWidth',1.5);
legend('最佳适应度','平均适应度');
xlabel('进化代数','FontSize',12);
ylabel('适应度','FontSize',12);
grid on;%(添加网格)
 
line1 = '适应度曲线MSE[SAPSOmethod]';
line2 = ['(终止代数=', ...
    num2str(MAXGEN),',种群数量pop=', ...
    num2str(NIND),')'];
line3 = ['ans=',num2str(ans),];
title({line1;line2;line3},'FontSize',12);



  
    



