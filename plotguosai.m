a=xlsread('I:\数学建模国赛真\fujian1.xls');
b=xlsread('I:\数学建模国赛真\fujian2.xls');
c=b(:,1);
d=b(:,2);
e=(1:1877);
count=zeros(1,5);
di=zeros(1877,1);
dis=zeros(1877,1);
lat=input('请输入纬度');
lon=input('请输入经度');
for i=1:1877
    count=zeros(1,5);
    di(i,1)=sin(lat(j,1))*sin(c(i,1))*(lon-d(i,1))+cos(lat(j,1))*cos(c(i,1));
    dis=acos(di)*pi/180*6371;
    if dis(i,1)<=4
       count(1,1)=count(1,1)+1 ;
    end
    if dis(i,1)<=8 &&dis(i,1)>4
       count(1,2)=count(1,2)+1 ;
    end
     if dis(i,1)<=12 &&dis(i,1)>8
       count(1,3)=count(1,3)+1 ;
     end
     if dis(i,1)<=16 &&dis(i,1)>12
       count(1,4)=count(1,4)+1 ;
     end
     if dis(i,1)<=20 &&dis(i,1)>16
       count(1,5)=count(1,5)+1 ;
     end
end
count
figure(1)
plot(e,dis,'.');
title('1877个距离的分布情况')
xlabel('会员编号/个')
ylabel('距离大小/km')
figure(2)
bili1=[count(1,1),count(1,2),count(1,3),count(1,4),count(1,5)];
labels={'x1','x2','x3','x4','x5'};
pie3(bili1,labels);
title('半径R内分区域会员人数比例')