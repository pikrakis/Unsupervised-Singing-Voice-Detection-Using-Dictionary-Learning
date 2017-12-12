function seg=detectSegments(winner)

% seg=detectSegments(winner)
% Given a sequence of binary classification decisions, computes the
% endpoints of the segments that have been formed. A seqment is a sequence
% of successive 1s. This is an auxiliary function.
%
% INPUT
% winner : binary sequence (zero stands for background, one for the singing voice)
%
% OUTPUT
% seg: array of segment endpoints, one row per segment
%
%
% Please reference the following paper:
% Aggelos Pikrakis, Yannis Kopsinis, Nadine Kroher, Jose Miguel Diaz-Banez,
% "Unsupervised Singing Voice Detection Using Dictionary Learning", 24th
% European Signal Processing Conference (EUSIPCO), Budapest, Hungary, 2016.

seg=[];
ind=find(winner>0);
if isempty(ind)
    return;
end
seg(1,:)=[ind(1) 0];
for k=2:length(ind)
    if ind(k)-ind(k-1)>1
        seg(end,2)=ind(k-1);
        seg(end+1,1)=ind(k);
    end
end
if seg(end,2)==0
    seg(end,2)=ind(end);
end

% Copyright   :Aggelos Pikrakis, Yannis Kopsinis, Nadine Kroher, Jose Miguel
%             Diaz-Banez
% This software is a copy provided for PRIVATE, RESEARCH use, NOT to be redistributed.
%
% Please reference the following paper:
% Aggelos Pikrakis, Yannis Kopsinis, Nadine Kroher, Jose Miguel Diaz-Banez,
% "Unsupervised Singing Voice Detection Using Dictionary Learning", 24th
% European Signal Processing Conference (EUSIPCO), Budapest, Hungary, 2016.
