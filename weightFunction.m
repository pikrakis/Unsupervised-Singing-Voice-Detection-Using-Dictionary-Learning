function [w]=weightFunction(X)

A=X; L=size(A,2);

X(X~=0)=1;
P=sum(X,2);
P=P/sum(P);
H=zeros(size(P));
for k=1:length(P)
    if P(k)>0
        H(k)=log2(1/P(k));
    end
end

X=A;
w=zeros(1,L);
for k=1:size(X,2)
    col=abs(X(:,k));
    ind=find(col>0);
    v=col(ind)/sum(col);
    w(k)=sum(H(ind).*v);
end


% Copyright   :Aggelos Pikrakis, Yannis Kopsinis, Nadine Kroher, Jose Miguel
%             Diaz-Banez
% This software is a copy provided for PRIVATE, RESEARCH use, NOT to be redistributed.
%
% Please reference the following paper:
% Aggelos Pikrakis, Yannis Kopsinis, Nadine Kroher, Jose Miguel Diaz-Banez,
% "Unsupervised Singing Voice Detection Using Dictionary Learning", 24th
% European Signal Processing Conference (EUSIPCO), Budapest, Hungary, 2016.
