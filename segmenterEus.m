function [binaryAudio,voiceSegments,backgroundSegments,aux]=segmenterEus(dlRuns,params,wins,fs)

for k=1:dlRuns
    params.initdict = randn(size(params.data,1),params.dictsize);
    [~,X] = ksvd(params,'');
    X=full(X);
    fprintf('Run %% %d\n',k);
    [w(k,:)]=weightFunction(X);
end
aux=w;
if size(w,1)>1
    w=medfilt1(mean(w),round(fs/wins)); % 1 s long median filter
else
    w=medfilt1(w,round(fs/wins));
end
G=w;G(G<eps)=[];
Th=multithresh(G,1); % Otsu threshold is computed here
% Detect vocal segments
bind= w>=Th;
binaryAudio=zeros(size(w));
binaryAudio(bind)=1;
voiceSegments=detectSegments(binaryAudio);
% Detect background segments
bind= w<=multithresh(G,1);
binaryAudio=zeros(size(w));
binaryAudio(bind)=1;
backgroundSegments=detectSegments(binaryAudio);


% Copyright   :Aggelos Pikrakis, Yannis Kopsinis, Nadine Kroher, Jose Miguel
%             Diaz-Banez
% This software is a copy provided for PRIVATE, RESEARCH use, NOT to be redistributed.
%
% Please reference the following paper:
% Aggelos Pikrakis, Yannis Kopsinis, Nadine Kroher, Jose Miguel Diaz-Banez,
% "Unsupervised Singing Voice Detection Using Dictionary Learning", 24th
% European Signal Processing Conference (EUSIPCO), Budapest, Hungary, 2016.
