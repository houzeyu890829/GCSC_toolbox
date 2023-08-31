function error=ES_weight_setup(c)
%y标准化了精度高，用这个
% figure(1);
% plot(d,'o-');
% % grid on;
% whos d;
load 'weight_optimization.txt'

M=weight_optimization;
b1 = M(1:20,1:3);
b2 = M(21:40,1:3);
b3 = M(41:60,1:3);
b4 = M(61:80,1:3);
b5 = c(1)/(c(1)+c(2)+c(3))*b2+c(2)/(c(1)+c(2)+c(3))*b3+c(3)/(c(1)+c(2)+c(3))*b4;


error=sum(sum(abs(b5-b1)));