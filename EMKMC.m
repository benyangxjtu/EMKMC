function [Result, t] = EMKMC(X, Y, M, gamma)
tic
numView = length(X);
for i=1:numView
    X{i}=double(X{i});
    X{i}=mapstd(X{i});
end
Y=double(Y);
%% Initialization
maxIter = 10;
numView = length(X);
c = length(unique(Y));                      % number of cluster
[n,~] = size(X{1});                         % number of samples 
%M=(c+7)*ones(1,numView);                    % number of anchors
%gamma = 1.6;                                % 1<gamma<2
alpha = ones(numView,1)/numView;

F = initialize(n,c);

for v = 1:numView
    G{v} = rand(M(v),c);
end

%% Get Anchor Graph
T=0;
for v = 1:size(X,2)
[~,d] = size(X{v}); 
[label, Anchors] = litekmeans(X{v}, M(v));
B{v} = ConstructA_NP(X{v}', Anchors');
end

%% Optimization

for Iter = 1:maxIter
% Update F
Gtemp = 0;
for v = 1:numView
    Gtemp=Gtemp+(alpha(v)^gamma)*B{v}*G{v};
end
[AA,BB,CC] = svd(Gtemp','econ');
F = (AA*CC')';

% Update G{v}
%Ftemp = F*pinv(F'*F);
for v = 1:numView
    G{v} = B{v}'*F;
end

% Update \alpha
for v = 1:numView
    W{v} = trace((B{v}-F*G{v}')'*(B{v}-F*G{v}'));
    r = 1/(1-gamma);
    Wtemp(v) = (gamma*W{v})^r; 
end
alpha = Wtemp./(sum(Wtemp,2));
end
[~,ind]=max(F,[],2);
Result = ClusteringMeasure(Y, ind);
t=toc;
