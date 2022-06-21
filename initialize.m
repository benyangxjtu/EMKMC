function [B] = initialize(m,n)
%生成初始化矩阵
B1=zeros(1,m);
for i=1:m
B1(1,i)=ceil(i*n/m);
end
B2=B1(:,randperm(size(B1,2)));
B= zeros(m,n);
for i=1:size(B,1)
j=B2(1,i);
B(i,j)=1;
end
end

