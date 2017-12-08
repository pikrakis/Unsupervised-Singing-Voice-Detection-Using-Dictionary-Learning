function S=barkBandsFeature(x,winl,wins,fs)
% Copyright   :Aggelos Pikrakis, Yannis Kopsinis, Nadine Kroher, Jose Miguel
%             Diaz-Banez
%
% Please reference the following paper:
% Aggelos Pikrakis, Yannis Kopsinis, Nadine Kroher, Jose Miguel Diaz-Banez,
% "Unsupervised Singing Voice Detection Using Dictionary Learning", 24th
% European Signal Processing Conference (EUSIPCO), Budapest, Hungary, 2016.

edges=[0 100;100 200;200 300;300 400;400 510;510 630;630 770
    770 920;920 1080;1080 1270;1270 1480;1480 1720;1720 2000
    2000 2320;2320 2700;2700 3150;3150 3700;3700 4400;4400 5300
    5300 6400;6400 7700;7700 9500;9500 12000;12000 15500];

fk=(0:winl/2+1)*(fs/winl);
fk(fk>15500)=[];
aux=zeros(length(edges),length(fk));
for kk=1:length(fk)
    ind= fk(kk)>=edges(:,1) & fk(kk)<=edges(:,2);
    aux(ind,kk)=1;
end

V=abs(spectrogram(x,winl,winl-wins,[],fs));
V(length(fk)+1:end,:)=[];
S=aux*V;

