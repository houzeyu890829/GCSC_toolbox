clear
clc


%�����Ŵ��㷨����
NIND=80;               %������Ŀ(Number of individuals)
MAXGEN=400;             %����Ŵ�����(Maximum number of generations)
NVAR=3;                %������Ŀ
PRECI=25;              %�����Ķ�����λ��(Precision of variables)
GGAP=0.8;              %����(Generation gap)
%��������������(Build field descriptor)
FieldD=[rep([PRECI],[1,NVAR]);rep([0;10000],[1,NVAR]);rep([1;0;1;1],[1,NVAR])];
Chrom=crtbp(NIND, NVAR*PRECI);                         %������ʼ��Ⱥ
gen=0;                                                 
trace=zeros(MAXGEN,7);                                 %�Ŵ��㷨���ܸ��ٳ�ʼֵ
c=bs2rv(Chrom, FieldD);                                %��ʼ��Ⱥʮ����ת��
[ar1 ac1]=size(c);
for i=1:ar1
    ObjV(i,:)=ES_weight_setup(c(i,1:3));      %�����ʼ��Ⱥ��Ŀ�꺯��ֵ
end
while gen<MAXGEN
    FitnV=ranking(ObjV);                               %������Ӧ��ֵ(Assign fitness values)
    SelCh=select('sus',Chrom,FitnV,GGAP);              %ѡ��
    SelCh=recombin('xovsp',SelCh,0.7);                 %����
    SelCh=mut(SelCh);                                  %����
    c=bs2rv(SelCh,FieldD);                             %�Ӵ�ʮ����ת��
    [ar2 ac2]=size(c);
    for i=1:ar2
    ObjVSel(i,:)=ES_weight_setup(c(i,1:3)); 
    end
    [Chrom ObjV]=reins(Chrom,SelCh,1,1,ObjV,ObjVSel);  %�ز���
    gen=gen+1;
    [M, I]=min(ObjV);
    M,bs2rv(Chrom(I,:),FieldD)                         %���ÿһ�ε����Ž⼰���Ӧ���Ա���ֵ
    trace(gen,1)=min(ObjV);                            %�Ŵ��㷨���ܸ���
    trace(gen,2)=sum(ObjV)/length(ObjV);
    trace(gen,3:5)=bs2rv(Chrom(I,:),FieldD);
end
%% �������
figure;
hold on;%ʹ�����߻���һ��ͼ��
plot(trace(:,1),'r*-','LineWidth',1.5);
plot(trace(:,2),'o-','LineWidth',1.5);
legend('�����Ӧ��','ƽ����Ӧ��');
xlabel('��������','FontSize',12);
ylabel('��Ӧ��','FontSize',12);
grid on;%(�������)
 
line1 = '��Ӧ������MSE[SAPSOmethod]';
line2 = ['(��ֹ����=', ...
    num2str(MAXGEN),',��Ⱥ����pop=', ...
    num2str(NIND),')'];
line3 = ['ans=',num2str(ans),];
title({line1;line2;line3},'FontSize',12);



  
    



