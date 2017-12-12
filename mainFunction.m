function [binarySequence,voiceSegments,backgroundSegments,w,x,fs]=mainFunction(fstr,winl,wins,dictsize,sparsity,dlRuns)

% INPUT
% fstr  : path to the audio file
% winl  : moving window length (in seconds)
% wins  : moving window step (in seconds)
% dictsize  : dictionary size 
% sparsity  : number of nonzeros at each sparse code
% dlRuns    : number of times that the segmenter is repeated to compute an
%             averaged weight function (default is 1)
%
% OUTPUT
% binarySequence    : sequence of binary decisions, one decision per frame
% voiceSegments     : array of vocal segment endpoints, one segment per row
% backgroundSegments: array of background segment endpoits, ine segment per
%                     row
% w                 : array, where the i-th row contains the weight function 
%                     from the i-th application of the segmenter  
% x                 : audio signal
% fs                : audio signal sampling rate
%
%
% Please reference the following paper:
% Aggelos Pikrakis, Yannis Kopsinis, Nadine Kroher, Jose Miguel Diaz-Banez,
% "Unsupervised Singing Voice Detection Using Dictionary Learning", 24th
% European Signal Processing Conference (EUSIPCO), Budapest, Hungary, 2016.


[x,fs]=audioread(fstr);
if size(x,2)==2
    x=0.5*x(:,1)+0.5*x(:,2);
end

wins=round(wins*fs);
winl=round(winl*fs);

% K-SVD training algorithm. Struct params is passed to the segmenter
params.data=barkBandsFeature(x,winl,wins,fs); % feature sequence
params.dictsize = dictsize; % dictionary size
params.Tdata = sparsity; % number of nonzeros that each sparse code has
params.iternum = 10; % number of training iterations for the K-SVD algorithm
params.exact = 1;params.memusage = 'high';params.howinit = 'random';params.preserveDCAtom = 0; % refer to the K-SVD implementation for more details

% run the segmenter
[binarySequence,voiceSegments,backgroundSegments,w]=segmenterEus(dlRuns,params,wins,fs);

