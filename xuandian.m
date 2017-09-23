xuandian1=zeros(40,3);
data=load('I:\数学建模国赛真\data1.txt');
a=data(:,1);
b=data(:,2);
t=1;
for i=1:800
    if data(i,1)+data(i,2)<10
        continue
    end
    if data(i,1)+data(i,2)>=10
        xuandian1(t,1)=data(i,7);
        xuandian1(t,2)=data(i,8);
        xuandian1(t,3)=data(i,6);
        xuandian1(t,4)=data(i,1);
        xuandian1(t,5)=data(i,2);
        xuandian1(t,6)=data(i,3);
        xuandian1(t,7)=data(i,4);
        xuandian1(t,8)=data(i,5);
        t=t+1;
    end
    if t>40
        break;
    end
end
dlmwrite('I:\数学建模国赛真\第二问\xuandian.txt',xuandian1,'delimiter','\t','newline','pc','-append')


        
        