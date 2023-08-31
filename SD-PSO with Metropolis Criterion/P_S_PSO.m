clear
clc
% 自适应权重粒子群寻优
%    参数赋初值
c1=0.5;    %学习因子
c2=0.5;
%异步变学习因子----------
%c1max=2.5; %自我学习能力
%c2max=2.5; %社会学习能力
%c1min=0.5;
%c2min=0.5;
maxgen=60; %迭代次数
popsize=50; %种群规模
wmax=0.8; %惯性权值w最大值
wmin=0.4;  %惯性权值w最小值
% v=5; %交叉检验折数
k=0.5; %速率和x的关系(V = kX)
a1max=0.940872017; %c的范围
a1min=0.136793475;
a2max=0.742412614; %c的范围
a2min=0;
a3max=0.905722671; %c的范围
a3min=0.101227215;
a4max=0.99061394; %c的范围
a4min=0.186184006;
a5max=0.957145822; %c的范围
a5min=0.157145822;
a6max=0.890213798; %c的范围
a6min=0.098888553;
a7max=0.882589144; %c的范围
a7min=0;
a8max=0.947349467; %c的范围
a8min=0.104974296;
a9max=0.953959103; %c的范围
a9min=0.125393555;
a10max=0.889195918; %c的范围
a10min=0.008199765;
a11max=0.995149586; %c的范围
a11min=0.174819838;
a12max=1; %c的范围
a12min=0.244493555;

% 各变量最大速度、最小速度
Va1max = k*a1max;
Va1min = -Va1max ;
Va2max = k*a2max;
Va2min = -Va2max ;
Va3max = k*a3max;
Va3min = -Va3max ;
Va4max = k*a4max;
Va4min = -Va4max ;
Va5max = k*a5max;
Va5min = -Va5max ;
Va6max = k*a6max;
Va6min = -Va6max ;
Va7max = k*a7max;
Va7min = -Va7max ;
Va8max = k*a8max;
Va8min = -Va8max ;
Va9max = k*a9max;
Va9min = -Va9max ;
Va10max = k*a10max;
Va10min = -Va10max ;
Va11max = k*a11max;
Va11min = -Va11max ;
Va12max = k*a12max;
Va12min = -Va12max ;
Sensitivity(1,1:12)=[0.125533365,0.366320526,1.28052E-05,0.0080996,0.074729741,0.325624781,0.005873072,0.148542295,0.316315671,0.159326967,0.624439851,0.631889916];
S_mean=mean(Sensitivity);
% 产生初始粒子的位置和速度
for q=1:popsize
    
% 随机产生种群的位置和速度（位置实际上就是所求各变量的值）
pop(q,1) = (2*rand-1)*0.5+0.538832746;  
pop(q,2) = (2*rand-1)*0.5+0.339586444;
pop(q,3) = (2*rand-1)*0.5+0.453474943;
pop(q,4) = (2*rand-1)*0.5+0.588398973;
pop(q,5) = (2*rand-1)*0.5+0.757145822;
pop(q,6) = (2*rand-1)*0.5+0.494551176;
pop(q,7) = (2*rand-1)*0.5+0.453239404;
pop(q,8) = (2*rand-1)*0.5+0.566161881;
pop(q,9) = (2*rand-1)*0.5+0.439676329;
pop(q,10) = (2*rand-1)*0.5+0.648697841;
pop(q,11) = (2*rand-1)*0.5+0.654984712;
pop(q,12) = (2*rand-1)*0.5+0.634940954;
V(q,1)=Va1max*rands(1,1);  
V(q,2)=Va2max*rands(1,1);
V(q,3)=Va3max*rands(1,1);
V(q,4)=Va4max*rands(1,1);
V(q,5)=Va5max*rands(1,1);
V(q,6)=Va6max*rands(1,1);
V(q,7)=Va7max*rands(1,1);
V(q,8)=Va8max*rands(1,1);
V(q,9)=Va9max*rands(1,1);
V(q,10)=Va10max*rands(1,1);
V(q,11)=Va11max*rands(1,1);
V(q,12)=Va12max*rands(1,1);
    fitness(q) = State_eva_fun(pop(q,1:12));
end

% 找极值和极值点
[global_fitness,bestindex]=max(fitness); % 全局极值(global_fitness告诉你最大的fitness是多少，
                                         ...bestindex告诉你最大的fitness在第几行)
local_fitness=fitness;   % 个体极值初始化

global_x=pop(bestindex,:);   % 全局极值点
local_x=pop;    % 个体极值点初始化

T=0.000005; 

%迭代计算
for t=1:maxgen
%计算每次迭代适应度的平均值和最小值
    for j=1:popsize
       fv(j) = fitness(j);
    end
    favg=sum(fv)/popsize;
    fmax=max(fv);
%     groupFit=fmax;   
%       for i=1:popsize        %当前温度下各个pi的适应值
%          Tfit(i)=exp(-(groupFit-fv(i))/T);
%      end
%      SumTfit=sum(Tfit);
%      Tfit=Tfit/SumTfit;
%      pBet=rand();
%      for i=1:popsize        %用轮盘赌策略确定全局最优的某个替代值
%          ComFit(i)=sum(Tfit(1:i));
%          if pBet<=ComFit(i)
%              pg_plus=pop(i,:);
%              break;
%          end
%      end   
%     对各粒子迭代
    for m=1:popsize
        %        自适应调整w
%         if fv(m)>= favg
%             w=wmin+(fmax-fv(m))*(wmax-wmin)/(fmax-favg);
%         else
%             w=wmax;
%         end   
           w=1/(1+exp((log(1.5)+log(19))*t/maxgen-log(19)));

%         速度更新
        V(m,:)=w*V(m,:)+c1*rand*(local_x(m,:) - pop(m,:))+c2*rand*(global_x - pop(m,:));
        if V(m,1) > Va1max
            V(m,1) = Va1max;
        end
        if V(m,1) < Va1min
            V(m,1) = Va1min;
        end
        
        if V(m,2) > Va2max
            V(m,2) = Va2max;
        end
        if V(m,2) < Va2min
            V(m,2) = Va2min;
        end
        
        if V(m,3) > Va3max
            V(m,3) = Va3max;
        end
        if V(m,3) < Va3min
            V(m,3) = Va3min;
        end
        
        if V(m,4) > Va4max
            V(m,4) = Va4max;
        end
        if V(m,4) < Va4min
            V(m,4) = Va4min;
        end
        
        if V(m,5) > Va5max
            V(m,5) = Va5max;
        end
        if V(m,5) < Va5min
            V(m,5) = Va5min;
        end
        
        if V(m,6) > Va6max
            V(m,6) = Va6max;
        end
        if V(m,6) < Va6min
            V(m,6) = Va6min;
        end
        
        if V(m,7) > Va7max
            V(m,7) = Va7max;
        end
        if V(m,7) < Va7min
            V(m,7) = Va7min;
        end
        
        if V(m,8) > Va8max
            V(m,8) = Va8max;
        end
        if V(m,8) < Va8min
            V(m,8) = Va8min;
        end
        
        if V(m,9) > Va9max
            V(m,9) = Va9max;
        end
        if V(m,9) < Va9min
            V(m,9) = Va9min;
        end
        
        if V(m,10) > Va10max
            V(m,10) = Va10max;
        end
        if V(m,10) < Va10min
            V(m,10) = Va10min;
        end
        
        if V(m,11) > Va11max
            V(m,11) = Va11max;
        end
        if V(m,11) < Va11min
            V(m,11) = Va11min;
        end
        
        if V(m,12) > Va12max
            V(m,12) = Va12max;
        end
        if V(m,12) < Va12min
            V(m,12) = Va12min;
        end

%         位置更新
      
     C=1-t/maxgen;
      for i=1:12
        if Sensitivity(1,i)<= S_mean
          P(i)=1;
        else
          P(i)=0;
        end
      end 

     if 0.5*rand<= C
      for i=1:12
        pop(m,i)=pop(m,i) + (0.631889916-Sensitivity(1,i)*t/maxgen)*V(m,i)/0.631889916;
      end 
         if pop(m,1) > a1max
            pop(m,1) = (a1max-a1min)*rand+a1min;
        end
        if pop(m,1) < a1min
            pop(m,1) = (a1max-a1min)*rand+a1min;
        end
        
        if pop(m,2) > a2max
            pop(m,2) = (a2max-a2min)*rand+a2min;
        end
        if pop(m,2) < a2min
            pop(m,2) = (a2max-a2min)*rand+a2min;
        end
        
        if pop(m,3) > a3max
            pop(m,3) = (a3max-a3min)*rand+a3min;
        end
        if pop(m,3) < a3min
            pop(m,3) = (a3max-a3min)*rand+a3min;
        end
        
         if pop(m,4) > a4max
            pop(m,4) = (a4max-a4min)*rand+a4min;
        end
        if pop(m,4) < a4min
            pop(m,4) = (a4max-a4min)*rand+a4min;
        end
        
         if pop(m,5) > a5max
            pop(m,5) = (a5max-a5min)*rand+a5min;
        end
        if pop(m,5) < a5min
            pop(m,5) = (a5max-a5min)*rand+a5min;
        end
        
        if pop(m,6) > a6max
            pop(m,6) = (a6max-a6min)*rand+a6min;
        end
        if pop(m,6) < a6min
            pop(m,6) = (a6max-a6min)*rand+a6min;
        end
        
         if pop(m,7) > a7max
            pop(m,7) = (a7max-a7min)*rand+a7min;
        end
        if pop(m,7) < a7min
            pop(m,7) = (a7max-a7min)*rand+a7min;
        end
        
         if pop(m,8) > a8max
            pop(m,8) = (a8max-a8min)*rand+a8min;
        end
        if pop(m,8) < a8min
            pop(m,8) = (a8max-a8min)*rand+a8min;
        end
        
        if pop(m,9) > a9max
            pop(m,9) = (a9max-a9min)*rand+a9min;
        end
        if pop(m,9) < a9min
            pop(m,9) = (a9max-a9min)*rand+a9min;
        end
        
         if pop(m,10) > a10max
            pop(m,10) = (a10max-a10min)*rand+a10min;
        end
        if pop(m,10) < a10min
            pop(m,10) = (a10max-a10min)*rand+a10min;
        end
        
        if pop(m,11) > a11max
            pop(m,11) = (a11max-a11min)*rand+a11min;
        end
        if pop(m,11) < a11min
            pop(m,11) = (a11max-a11min)*rand+a11min;
        end
        
         if pop(m,12) > a12max
            pop(m,12) = (a12max-a12min)*rand+a12min;
        end
        if pop(m,12) < a12min
            pop(m,12) = (a12max-a12min)*rand+a12min;
        end
     else
      for i=1:12
        pop(m,i)=pop(m,i) + P(i)*(0.631889916-Sensitivity(1,i)*t/maxgen)*V(m,i)/0.631889916;
      end 
        if pop(m,1) > a1max
            pop(m,1) = (a1max-a1min)*rand+a1min;
        end
        if pop(m,1) < a1min
            pop(m,1) = (a1max-a1min)*rand+a1min;
        end
        
        if pop(m,2) > a2max
            pop(m,2) = (a2max-a2min)*rand+a2min;
        end
        if pop(m,2) < a2min
            pop(m,2) = (a2max-a2min)*rand+a2min;
        end
        
        if pop(m,3) > a3max
            pop(m,3) = (a3max-a3min)*rand+a3min;
        end
        if pop(m,3) < a3min
            pop(m,3) = (a3max-a3min)*rand+a3min;
        end
        
         if pop(m,4) > a4max
            pop(m,4) = (a4max-a4min)*rand+a4min;
        end
        if pop(m,4) < a4min
            pop(m,4) = (a4max-a4min)*rand+a4min;
        end
        
         if pop(m,5) > a5max
            pop(m,5) = (a5max-a5min)*rand+a5min;
        end
        if pop(m,5) < a5min
            pop(m,5) = (a5max-a5min)*rand+a5min;
        end
        
        if pop(m,6) > a6max
            pop(m,6) = (a6max-a6min)*rand+a6min;
        end
        if pop(m,6) < a6min
            pop(m,6) = (a6max-a6min)*rand+a6min;
        end
        
         if pop(m,7) > a7max
            pop(m,7) = (a7max-a7min)*rand+a7min;
        end
        if pop(m,7) < a7min
            pop(m,7) = (a7max-a7min)*rand+a7min;
        end
        
         if pop(m,8) > a8max
            pop(m,8) = (a8max-a8min)*rand+a8min;
        end
        if pop(m,8) < a8min
            pop(m,8) = (a8max-a8min)*rand+a8min;
        end
        
        if pop(m,9) > a9max
            pop(m,9) = (a9max-a9min)*rand+a9min;
        end
        if pop(m,9) < a9min
            pop(m,9) = (a9max-a9min)*rand+a9min;
        end
        
         if pop(m,10) > a10max
            pop(m,10) = (a10max-a10min)*rand+a10min;
        end
        if pop(m,10) < a10min
            pop(m,10) = (a10max-a10min)*rand+a10min;
        end
        
        if pop(m,11) > a11max
            pop(m,11) = (a11max-a11min)*rand+a11min;
        end
        if pop(m,11) < a11min
            pop(m,11) = (a11max-a11min)*rand+a11min;
        end
        
         if pop(m,12) > a12max
            pop(m,12) = (a12max-a12min)*rand+a12min;
        end
        if pop(m,12) < a12min
            pop(m,12) = (a12max-a12min)*rand+a12min;
        end
     
     end  


%  对更新后的粒子进行适应度计算
         fitness(m) = State_eva_fun(pop(m,1:12));
         
%  个体极值更新
        r=rand;
        MC(m,t)=exp((fitness(m)-local_fitness(m))/T);
        if fitness(m) > local_fitness(m)
            local_x(m,:) = pop(m,:);
            local_fitness(m) = fitness(m);
        else if exp((fitness(m)-local_fitness(m))/T) > r 
            local_x(m,:) = pop(m,:);
            local_fitness(m) = fitness(m);   
             end
        end
%         全局极值更新
        if fitness(m) > global_fitness
            global_x = pop(m,:);
            global_fitness = fitness(m);
        end

    end
%     最后迭代结果
    fit_gen(t)=global_fitness;
    avgfitness_gen(t) = sum(fitness)/popsize;
    trace_optimum(t,:)=global_x;  %遗传算法性能跟踪
    trace_local1(t,:)=local_x(1,:);
    trace_local2(t,:)=local_x(2,:);
    trace_local3(t,:)=local_x(3,:);
    trace_local4(t,:)=local_x(4,:);
    trace_local5(t,:)=local_x(5,:);
    trace_local6(t,:)=local_x(6,:);
    trace_local7(t,:)=local_x(7,:);
    trace_local8(t,:)=local_x(8,:);
    trace_local9(t,:)=local_x(9,:);
    trace_local10(t,:)=local_x(10,:);
    trace_local11(t,:)=local_x(11,:);
    trace_local12(t,:)=local_x(12,:);
    trace_local13(t,:)=local_x(13,:);
    trace_local14(t,:)=local_x(14,:);
    trace_local15(t,:)=local_x(15,:);
    trace_local16(t,:)=local_x(16,:);
    trace_local17(t,:)=local_x(17,:);
    trace_local18(t,:)=local_x(18,:);
    trace_local19(t,:)=local_x(19,:);
    trace_local20(t,:)=local_x(20,:);
    trace_local21(t,:)=local_x(21,:);
    trace_local22(t,:)=local_x(22,:);
    trace_local23(t,:)=local_x(23,:);
    trace_local24(t,:)=local_x(24,:);
    trace_local25(t,:)=local_x(25,:);
    trace_local26(t,:)=local_x(26,:);
    trace_local27(t,:)=local_x(27,:);
    trace_local28(t,:)=local_x(28,:);
    trace_local29(t,:)=local_x(29,:);
    trace_local30(t,:)=local_x(30,:);
    trace_local31(t,:)=local_x(31,:);
    trace_local32(t,:)=local_x(32,:);
    trace_local33(t,:)=local_x(33,:);
    trace_local34(t,:)=local_x(34,:);
    trace_local35(t,:)=local_x(35,:);
    trace_local36(t,:)=local_x(36,:);
    trace_local37(t,:)=local_x(37,:);
    trace_local38(t,:)=local_x(38,:);
    trace_local39(t,:)=local_x(39,:);
    trace_local40(t,:)=local_x(40,:);
    trace_local41(t,:)=local_x(41,:);
    trace_local42(t,:)=local_x(42,:);
    trace_local43(t,:)=local_x(43,:);
    trace_local44(t,:)=local_x(44,:);
    trace_local45(t,:)=local_x(45,:);
    trace_local46(t,:)=local_x(46,:);
    trace_local47(t,:)=local_x(47,:);
    trace_local48(t,:)=local_x(48,:);
    trace_local49(t,:)=local_x(49,:);
    trace_local50(t,:)=local_x(50,:);
%     trace_local51(t,:)=local_x(51,:);
%     trace_local52(t,:)=local_x(52,:);
%     trace_local53(t,:)=local_x(53,:);
%     trace_local54(t,:)=local_x(54,:);
%     trace_local55(t,:)=local_x(55,:);
%     trace_local56(t,:)=local_x(56,:);
%     trace_local57(t,:)=local_x(57,:);
%     trace_local58(t,:)=local_x(58,:);
%     trace_local59(t,:)=local_x(59,:);
%     trace_local60(t,:)=local_x(60,:);
    for i=1:12 
    trace_local(t,1,i)=trace_local1(t,i);
    trace_local(t,2,i)=trace_local2(t,i);
    trace_local(t,3,i)=trace_local3(t,i);
    trace_local(t,4,i)=trace_local4(t,i);
    trace_local(t,5,i)=trace_local5(t,i);
    trace_local(t,6,i)=trace_local6(t,i);
    trace_local(t,7,i)=trace_local7(t,i);
    trace_local(t,8,i)=trace_local8(t,i);
    trace_local(t,9,i)=trace_local9(t,i);
    trace_local(t,10,i)=trace_local10(t,i);
    trace_local(t,11,i)=trace_local11(t,i);
    trace_local(t,12,i)=trace_local12(t,i);
    trace_local(t,13,i)=trace_local13(t,i);
    trace_local(t,14,i)=trace_local14(t,i);
    trace_local(t,15,i)=trace_local15(t,i);
    trace_local(t,16,i)=trace_local16(t,i);
    trace_local(t,17,i)=trace_local17(t,i);
    trace_local(t,18,i)=trace_local18(t,i);
    trace_local(t,19,i)=trace_local19(t,i);
    trace_local(t,20,i)=trace_local20(t,i);
    trace_local(t,21,i)=trace_local21(t,i);
    trace_local(t,22,i)=trace_local22(t,i);
    trace_local(t,23,i)=trace_local23(t,i);
    trace_local(t,24,i)=trace_local24(t,i);
    trace_local(t,25,i)=trace_local25(t,i);
    trace_local(t,26,i)=trace_local26(t,i);
    trace_local(t,27,i)=trace_local27(t,i);
    trace_local(t,28,i)=trace_local28(t,i);
    trace_local(t,29,i)=trace_local29(t,i);
    trace_local(t,30,i)=trace_local30(t,i);
    trace_local(t,31,i)=trace_local31(t,i);
    trace_local(t,32,i)=trace_local32(t,i);
    trace_local(t,33,i)=trace_local33(t,i);
    trace_local(t,34,i)=trace_local34(t,i);
    trace_local(t,35,i)=trace_local35(t,i);
    trace_local(t,36,i)=trace_local36(t,i);
    trace_local(t,37,i)=trace_local37(t,i);
    trace_local(t,38,i)=trace_local38(t,i);
    trace_local(t,39,i)=trace_local39(t,i);
    trace_local(t,40,i)=trace_local40(t,i);
    trace_local(t,41,i)=trace_local41(t,i);
    trace_local(t,42,i)=trace_local42(t,i);
    trace_local(t,43,i)=trace_local43(t,i);
    trace_local(t,44,i)=trace_local44(t,i);
    trace_local(t,45,i)=trace_local45(t,i);
    trace_local(t,46,i)=trace_local46(t,i);
    trace_local(t,47,i)=trace_local47(t,i);
    trace_local(t,48,i)=trace_local48(t,i);
    trace_local(t,49,i)=trace_local49(t,i);
    trace_local(t,50,i)=trace_local50(t,i);
%     trace_local(t,51,i)=trace_local51(t,i);
%     trace_local(t,52,i)=trace_local52(t,i);
%     trace_local(t,53,i)=trace_local53(t,i);
%     trace_local(t,54,i)=trace_local54(t,i);
%     trace_local(t,55,i)=trace_local55(t,i);
%     trace_local(t,56,i)=trace_local56(t,i);
%     trace_local(t,57,i)=trace_local57(t,i);
%     trace_local(t,58,i)=trace_local58(t,i);
%     trace_local(t,59,i)=trace_local59(t,i);
%     trace_local(t,60,i)=trace_local60(t,i);
    end
   for i=1:12 
    mean_local(1,i)=mean(trace_local1(:,i),1);
    mean_local(2,i)=mean(trace_local2(:,i),1);
    mean_local(3,i)=mean(trace_local3(:,i),1);
    mean_local(4,i)=mean(trace_local4(:,i),1);
    mean_local(5,i)=mean(trace_local5(:,i),1);
    mean_local(6,i)=mean(trace_local6(:,i),1);
    mean_local(7,i)=mean(trace_local7(:,i),1);
    mean_local(8,i)=mean(trace_local8(:,i),1);
    mean_local(9,i)=mean(trace_local9(:,i),1);
    mean_local(10,i)=mean(trace_local10(:,i),1);
    mean_local(11,i)=mean(trace_local11(:,i),1);
    mean_local(12,i)=mean(trace_local12(:,i),1);
    mean_local(13,i)=mean(trace_local13(:,i),1);
    mean_local(14,i)=mean(trace_local14(:,i),1);
    mean_local(15,i)=mean(trace_local15(:,i),1);
    mean_local(16,i)=mean(trace_local16(:,i),1);
    mean_local(17,i)=mean(trace_local17(:,i),1);
    mean_local(18,i)=mean(trace_local18(:,i),1);
    mean_local(19,i)=mean(trace_local19(:,i),1);
    mean_local(20,i)=mean(trace_local20(:,i),1);
    mean_local(21,i)=mean(trace_local21(:,i),1);
    mean_local(22,i)=mean(trace_local22(:,i),1);
    mean_local(23,i)=mean(trace_local23(:,i),1);
    mean_local(24,i)=mean(trace_local24(:,i),1);
    mean_local(25,i)=mean(trace_local25(:,i),1);
    mean_local(26,i)=mean(trace_local26(:,i),1);
    mean_local(27,i)=mean(trace_local27(:,i),1);
    mean_local(28,i)=mean(trace_local28(:,i),1);
    mean_local(29,i)=mean(trace_local29(:,i),1);
    mean_local(30,i)=mean(trace_local30(:,i),1);
    mean_local(31,i)=mean(trace_local31(:,i),1);
    mean_local(32,i)=mean(trace_local32(:,i),1);
    mean_local(33,i)=mean(trace_local33(:,i),1);
    mean_local(34,i)=mean(trace_local34(:,i),1);
    mean_local(35,i)=mean(trace_local35(:,i),1);
    mean_local(36,i)=mean(trace_local36(:,i),1);
    mean_local(37,i)=mean(trace_local37(:,i),1);
    mean_local(38,i)=mean(trace_local38(:,i),1);
    mean_local(39,i)=mean(trace_local39(:,i),1);
    mean_local(40,i)=mean(trace_local40(:,i),1);
    mean_local(41,i)=mean(trace_local41(:,i),1);
    mean_local(42,i)=mean(trace_local42(:,i),1);
    mean_local(43,i)=mean(trace_local43(:,i),1);
    mean_local(44,i)=mean(trace_local44(:,i),1);
    mean_local(45,i)=mean(trace_local45(:,i),1);
    mean_local(46,i)=mean(trace_local46(:,i),1);
    mean_local(47,i)=mean(trace_local47(:,i),1);
    mean_local(48,i)=mean(trace_local48(:,i),1);
    mean_local(49,i)=mean(trace_local49(:,i),1);
    mean_local(50,i)=mean(trace_local50(:,i),1);
%     mean_local(51,i)=mean(trace_local51(:,i),1);
%     mean_local(52,i)=mean(trace_local52(:,i),1);
%     mean_local(53,i)=mean(trace_local53(:,i),1);
%     mean_local(54,i)=mean(trace_local54(:,i),1);
%     mean_local(55,i)=mean(trace_local55(:,i),1);
%     mean_local(56,i)=mean(trace_local56(:,i),1);
%     mean_local(57,i)=mean(trace_local57(:,i),1);
%     mean_local(58,i)=mean(trace_local58(:,i),1);
%     mean_local(59,i)=mean(trace_local59(:,i),1);
%     mean_local(60,i)=mean(trace_local60(:,i),1);
   end 
    
    for i=1:12 
    variance_local(1,i)=var(trace_local1(:,i),1);
    variance_local(2,i)=var(trace_local2(:,i),1);
    variance_local(3,i)=var(trace_local3(:,i),1);
    variance_local(4,i)=var(trace_local4(:,i),1);
    variance_local(5,i)=var(trace_local5(:,i),1);
    variance_local(6,i)=var(trace_local6(:,i),1);
    variance_local(7,i)=var(trace_local7(:,i),1);
    variance_local(8,i)=var(trace_local8(:,i),1);
    variance_local(9,i)=var(trace_local9(:,i),1);
    variance_local(10,i)=var(trace_local10(:,i),1);
    variance_local(11,i)=var(trace_local11(:,i),1);
    variance_local(12,i)=var(trace_local12(:,i),1);
    variance_local(13,i)=var(trace_local13(:,i),1);
    variance_local(14,i)=var(trace_local14(:,i),1);
    variance_local(15,i)=var(trace_local15(:,i),1);
    variance_local(16,i)=var(trace_local16(:,i),1);
    variance_local(17,i)=var(trace_local17(:,i),1);
    variance_local(18,i)=var(trace_local18(:,i),1);
    variance_local(19,i)=var(trace_local19(:,i),1);
    variance_local(20,i)=var(trace_local20(:,i),1);
    variance_local(21,i)=var(trace_local21(:,i),1);
    variance_local(22,i)=var(trace_local22(:,i),1);
    variance_local(23,i)=var(trace_local23(:,i),1);
    variance_local(24,i)=var(trace_local24(:,i),1);
    variance_local(25,i)=var(trace_local25(:,i),1);
    variance_local(26,i)=var(trace_local26(:,i),1);
    variance_local(27,i)=var(trace_local27(:,i),1);
    variance_local(28,i)=var(trace_local28(:,i),1);
    variance_local(29,i)=var(trace_local29(:,i),1);
    variance_local(30,i)=var(trace_local30(:,i),1);
    variance_local(31,i)=var(trace_local31(:,i),1);
    variance_local(32,i)=var(trace_local32(:,i),1);
    variance_local(33,i)=var(trace_local33(:,i),1);
    variance_local(34,i)=var(trace_local34(:,i),1);
    variance_local(35,i)=var(trace_local35(:,i),1);
    variance_local(36,i)=var(trace_local36(:,i),1);
    variance_local(37,i)=var(trace_local37(:,i),1);
    variance_local(38,i)=var(trace_local38(:,i),1);
    variance_local(39,i)=var(trace_local39(:,i),1);
    variance_local(40,i)=var(trace_local40(:,i),1);
    variance_local(41,i)=var(trace_local41(:,i),1);
    variance_local(42,i)=var(trace_local42(:,i),1);
    variance_local(43,i)=var(trace_local43(:,i),1);
    variance_local(44,i)=var(trace_local44(:,i),1);
    variance_local(45,i)=var(trace_local45(:,i),1);
    variance_local(46,i)=var(trace_local46(:,i),1);
    variance_local(47,i)=var(trace_local47(:,i),1);
    variance_local(48,i)=var(trace_local48(:,i),1);
    variance_local(49,i)=var(trace_local49(:,i),1);
    variance_local(50,i)=var(trace_local50(:,i),1);
%     variance_local(51,i)=var(trace_local51(:,i),1);
%     variance_local(52,i)=var(trace_local52(:,i),1);
%     variance_local(53,i)=var(trace_local53(:,i),1);
%     variance_local(54,i)=var(trace_local54(:,i),1);
%     variance_local(55,i)=var(trace_local55(:,i),1);
%     variance_local(56,i)=var(trace_local56(:,i),1);
%     variance_local(57,i)=var(trace_local57(:,i),1);
%     variance_local(58,i)=var(trace_local58(:,i),1);
%     variance_local(59,i)=var(trace_local59(:,i),1);
%     variance_local(60,i)=var(trace_local60(:,i),1);
   end 
   
    variance_mean_local(t,:)=mean(variance_local(:,:),1);
    for i=1:12 
    mean_variance_local(t,i)=var(mean_local(:,i),1);
    end
    for i=1:12 
    SR(t,i)=(((t-1)/t)+51/50*mean_variance_local(t,i)/variance_mean_local(t,i)).^0.5;
    end
    T=T*0.95;
end
trace_local_v1(:,:)=trace_local(:,:,1);
trace_local_v2(:,:)=trace_local(:,:,2);
trace_local_v3(:,:)=trace_local(:,:,3);
trace_local_v4(:,:)=trace_local(:,:,4);
trace_local_v5(:,:)=trace_local(:,:,5);
trace_local_v6(:,:)=trace_local(:,:,6);
trace_local_v7(:,:)=trace_local(:,:,7);
trace_local_v8(:,:)=trace_local(:,:,8);
trace_local_v9(:,:)=trace_local(:,:,9);
trace_local_v10(:,:)=trace_local(:,:,10);
trace_local_v11(:,:)=trace_local(:,:,11);
trace_local_v12(:,:)=trace_local(:,:,12);

trace_local_v1_r=trace_local_v1(11:60,:);
trace_local_v2_r=trace_local_v2(11:60,:);
trace_local_v3_r=trace_local_v3(11:60,:);
trace_local_v4_r=trace_local_v4(11:60,:);
trace_local_v5_r=trace_local_v5(11:60,:);
trace_local_v6_r=trace_local_v6(11:60,:);
trace_local_v7_r=trace_local_v7(11:60,:);
trace_local_v8_r=trace_local_v8(11:60,:);
trace_local_v9_r=trace_local_v9(11:60,:);
trace_local_v10_r=trace_local_v10(11:60,:);
trace_local_v11_r=trace_local_v11(11:60,:);
trace_local_v12_r=trace_local_v12(11:60,:);
v1=trace_local_v1_r(:);
v2=trace_local_v2_r(:);
v3=trace_local_v3_r(:);
v4=trace_local_v4_r(:);
v5=trace_local_v5_r(:);
v6=trace_local_v6_r(:);
v7=trace_local_v7_r(:);
v8=trace_local_v8_r(:);
v9=trace_local_v9_r(:);
v10=trace_local_v10_r(:);
v11=trace_local_v11_r(:);
v12=trace_local_v12_r(:);
MAX=[599.6950677,219.5777216,0.27909677,0.299583466,700,0.340997326,0.3980923,37825.50072,8729.800881,60.70937087,15.40917255,130.2283353];
MIN=[440.5066384,60.70025821,0.080214354,0.100684851,400,0.280339587,0.331335197,31652.47927,7426.343354,38.91585912,8.680171185,114.5540089];
v1_r=v1*(MAX(1)-MIN(1))+MIN(1);
v2_r=v2*(MAX(2)-MIN(2))+MIN(2);
v3_r=v3*(MAX(3)-MIN(3))+MIN(3);
v4_r=v4*(MAX(4)-MIN(4))+MIN(4);
v5_r=v5*(MAX(5)-MIN(5))+MIN(5);
v6_r=v6*(MAX(6)-MIN(6))+MIN(6);
v7_r=v7*(MAX(7)-MIN(7))+MIN(7);
v8_r=v8*(MAX(8)-MIN(8))+MIN(8);
v9_r=v9*(MAX(9)-MIN(9))+MIN(9);
v10_r=v10*(MAX(10)-MIN(10))+MIN(10);
v11_r=v11*(MAX(11)-MIN(11))+MIN(11);
v12_r=((v12*(MAX(12)-MIN(12))+MIN(12))-101.325)/10.1325/650*1000;
save('P_S_PSO');
% histogram(v5_r,'Normalization','pdf')
% hold on
% ksdensity(v5_r)