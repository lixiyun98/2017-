function main()
clc                          % 清屏
clear all;                  %清除内存以便加快运算速度
close all;                  %关闭当前所有figure图像
SamNum=20;                  %输入样本数量为20
TestSamNum=20;              %测试样本数量也是20
ForcastSamNum=2;            %预测样本数量为2
HiddenUnitNum=8;            %中间层隐节点数量取8,比工具箱程序多了1个
InDim=3;                    %网络输入维度为3
OutDim=2;                   %网络输出维度为2
data=xlsread('I:\数学建模国赛真\data13.xls');
x=data(243:691,7);
y=data(243:691,6);
z=data(243:691,8);
x=x';
z=z';
y=y';
p=[x;z];  %输入数据矩阵
t=[y];           %目标数据矩阵
[SamIn,minp,maxp,tn,mint,maxt]=premnmx(p,t); %原始样本对（输入和输出）初始化
rand('state',sum(100*clock))   %依据系统时钟种子产生随机数         
NoiseVar=0.01;                    %噪声强度为0.01（添加噪声的目的是为了防止网络过度拟合）
Noise=NoiseVar*randn(2,SamNum);   %生成噪声
SamOut=tn + Noise;                   %将噪声添加到输出样本上

TestSamIn=SamIn;                           %这里取输入样本与测试样本相同因为样本容量偏少
TestSamOut=SamOut;                         %也取输出样本与测试样本相同

MaxEpochs=50000;                              %最多训练次数为50000
lr=0.035;                                       %学习速率为0.035
E0=0.65*10^(-3);                              %目标误差为0.65*10^(-3)
W1=0.5*rand(HiddenUnitNum,InDim)-0.1;   %初始化输入层与隐含层之间的权值
B1=0.5*rand(HiddenUnitNum,1)-0.1;       %初始化输入层与隐含层之间的阈值
W2=0.5*rand(OutDim,HiddenUnitNum)-0.1; %初始化输出层与隐含层之间的权值              
B2=0.5*rand(OutDim,1)-0.1;                %初始化输出层与隐含层之间的阈值

ErrHistory=[];                              %给中间变量预先占据内存
for i=1:MaxEpochs
    
    HiddenOut=logsig(W1*SamIn+repmat(B1,1,SamNum)); % 隐含层网络输出
    NetworkOut=W2*HiddenOut+repmat(B2,1,SamNum);    % 输出层网络输出
    Error=SamOut-NetworkOut;                       % 实际输出与网络输出之差
    SSE=sumsqr(Error)                               %能量函数（误差平方和）

    ErrHistory=[ErrHistory SSE];

    if SSE<E0,break, end      %如果达到误差要求则跳出学习循环
    
    % 以下六行是BP网络最核心的程序
    % 他们是权值（阈值）依据能量函数负梯度下降原理所作的每一步动态调整量
    Delta2=Error;
    Delta1=W2'*Delta2.*HiddenOut.*(1-HiddenOut);    
    dW2=Delta2*HiddenOut';
    dB2=Delta2*ones(SamNum,1);
    dW1=Delta1*SamIn';
    dB1=Delta1*ones(SamNum,1);
    %对输出层与隐含层之间的权值和阈值进行修正
    W2=W2+lr*dW2;
    B2=B2+lr*dB2;
    %对输入层与隐含层之间的权值和阈值进行修正
    W1=W1+lr*dW1;
    B1=B1+lr*dB1;
end
HiddenOut=logsig(W1*SamIn+repmat(B1,1,TestSamNum)); % 隐含层输出最终结果
NetworkOut=W2*HiddenOut+repmat(B2,1,TestSamNum);    % 输出层输出最终结果
a=postmnmx(NetworkOut,mint,maxt);               % 还原网络输出层的结果
x=1990:2009;                                        % 时间轴刻度
newk=a(1,:);                                        % 网络输出价格
figure ;
subplot(2,1,1);plot(x,newk,'r-o')    %绘值公路客运量对比图；
legend('网络输出客运量','实际客运量');
xlabel('年份');ylabel('客运量/万人');
% 当用训练好的网络对新数据pnew进行预测时，也应作相应的处理
lat1=input('请输入纬度');
lon1=input('请输入经度');
pnew=[lat1 lon1];                     %2010年和2011年的相关数据；
pnewn=tramnmx(pnew,minp,maxp);         %利用原始输入数据的归一化参数对新数据进行归一化；
HiddenOut=logsig(W1*pnewn+repmat(B1,1,ForcastSamNum)); % 隐含层输出预测结果
anewn=W2*HiddenOut+repmat(B2,1,ForcastSamNum);           % 输出层输出预测结果

%把网络预测得到的数据还原为原始的数量级；
anew=postmnmx(anewn,mint,maxt)         
