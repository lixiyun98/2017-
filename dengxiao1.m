data=xlsread('I:\数学建模国赛真\fujian33.xls');
a=data(:,1);%纬度
b=data(:,2);
c=xlsread('I:\数学建模国赛真\fujian22.xls');
llat=c(:,1);%会员
llon=c(:,2);
ledu=c(:,4);%额度
dengxiao2=zeros(1877,1);%人均等效
R=24;
di=zeros(835,1);
dis=zeros(835,1);
for i=1:1877
    t=0;
   for j=1:2066
    di(j,1)=sin(a(j,1))*sin(llat(i,1))*(b(j,1)-llon(i,1))+cos(a(j,1))*cos(llat(i,1));
    dis(j,1)=acos(di(j,1))*pi/180*6371;
   if dis(j,1)<=R 
      t=t+1;
   end
   end
   if t<=ledu(i,1)
       dengxiao2(i,1)=1;
   end
   if t>ledu(i,1)
       dengxiao2(i,1)=ledu(i,1)/t;
   end
end
dlmwrite('I:\数学建模国赛真\第四问\dengxiao1.txt',dengxiao2,'delimiter','\t','newline','pc','-append')