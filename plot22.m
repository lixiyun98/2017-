beta=1.314;
alpha=0.5;
r=8;
x=[-15:15];
y=zeros(1,31);
for j=1:31
y(1,j)=beta./(1+exp(alpha-r/x(1,j)));
end
plot(x,y)