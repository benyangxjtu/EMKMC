load WebKB

numView = length(X);
c = length(unique(Y));                     
M=[11, 7];
gamma = 1.6; 
RESULT=[];T=[];
for II=1:10
[Result, t] = EMKMC(X, Y, M, gamma);
RESULT = [RESULT;Result];
T = [T;t];
end
t=mean(T)
[mean(RESULT(:,1)),std(RESULT(:,1));
 mean(RESULT(:,2)),std(RESULT(:,2));
 mean(RESULT(:,3)),std(RESULT(:,3))]