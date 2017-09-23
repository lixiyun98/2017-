la=xlsread('I:\数学建模国赛真\fujian1.xls');
lat=la(:,1);
lon=la(:,2);
pri=la(:,3);
b=xlsread('I:\数学建模国赛真\fujian2.xls');
data1=load('I:\数学建模国赛真\第二问\xuandian.txt');
data2=load('I:\数学建模国赛真\第二问\dengxiao.txt');
c=b(:,1);
d=b(:,2);
count=zeros(1,8);
di=zeros(1877,1);
dis=zeros(1877,1);
R=24;
for j=1:40
    count=zeros(1,8);
    count(1,6)=data1(j,3);%价格
    count(1,7)=data1(j,1);%纬度
    count(1,8)=data1(j,2);%经度
for i=1:1877
    di(i,1)=sin(data1(j,1))*sin(c(i,1))*(data1(j,2)-d(i,1))+cos(data1(j,1))*cos(c(i,1));
    dis(i,1)=acos(di(i,1))*pi/180*6371;
    if dis(i,1)<=R/5
       count(1,1)=count(1,1)+1*data2(i,1) ;
      count(1,1)=vpa(count(1,1),3);
    end
    if dis(i,1)<=R/5*2 &&dis(i,1)>R/5
       count(1,2)=count(1,2)+1*data2(i,1) ;
      count(1,2)=vpa(count(1,2),3);
    end
     if dis(i,1)<=R/5*3 &&dis(i,1)>R/5*2
       count(1,3)=count(1,3)+1*data2(i,1) ;
      count(1,3)=vpa(count(1,3),3);
     end
     if dis(i,1)<=R/5*4 &&dis(i,1)>R/5*3
       count(1,4)=count(1,4)+1*data2(i,1) ;
    count(1,4)=vpa(count(1,4),3);
     end
     if dis(i,1)<=R &&dis(i,1)>R/5*4
       count(1,5)=count(1,5)+1*data2(i,1) ;
       count(1,5)=vpa(count(1,5),3);
     end
end
dlmwrite('I:\数学建模国赛真\第二问\data2.txt',count,'delimiter','\t','newline','pc','-append')

end


