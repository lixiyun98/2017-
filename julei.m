b=xlsread('I:\数学建模国赛真\fujian1.xls');
b(:,4)=[];
a=b(523:835,:);
a=zscore(a);
y=pdist(a);
z=linkage(y,'average');
h=dendrogram(z);
set(h,'Color','k','LineWidth',2.0)

fprintf('划分为%d结果如下：\n',2)
T=cluster(z,'maxclust',k);
k=3
for i=1:k
        tm=find(T==i);
        tm=reshape(tm,1,length(tm));
        fprintf('第%d类的方案有%s\n',i,int2str(tm));
end


