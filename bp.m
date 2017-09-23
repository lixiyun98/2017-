clc,clear;
data=xlsread('I:\数学建模国赛真\data13.xls');
x=data(243:691,[7 8]);
y=data(243:691,6);
[XN,XS1]=mapminmax(x);%归一化y = (ymax-ymin)*(x-xmin)/(xmax-xmin) + ymin
[YN XS2]=mapminmax(y);%归一化
x=x';
y=y';
net=newff(minmax(x),[80,1],{'tansig','purelin'},'traingdm');%网络训练函数
%当前输入层权值和阙值
inputWeights=net.IW{1,1};
inputbias=net.b{1};
%当前网络层权值和阙值
layerWeights=net.IW{2,1};
iayerbias=net.b{2};
%训练参数
net.trainParam.show=50;
net.trainParam.lr=0.01;
net.trainParam.mc=0.9;
net.trainParam.epochs=400;
net.trainParam.goal=1e-3;
%调用TRAINGDM算法训练BP网络
[net,tr]=train(net,x,y);
%BP仿真
A_train=sim(net,x);
%计算仿真误差
E=y-A_train;
%均方误差
disp '网络训练均方误差'
MSE=mse(E,net)
ms=msereg(E,net)
figure(1)
plot(y,'ro--','linewidth',2)
hold on
plot(A_train,'bs--','linewidth',2)
legend('实际值','输出值')
lat=[22.718];
lon=[114.26];
x=[lat lon];
x=x';
x=mapminmax(x);
y0=sim(net,x);
y1=mapminmax(y0)
