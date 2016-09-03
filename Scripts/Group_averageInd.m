clc;clear all;close all;

% Example input: Group_EEGind.mat
path = 'U:\Vahab\My Matlab\Persons\Nadeem_Face data\Outputs\Group\source';
[filename,PathName] = uigetfile(path,'load average DCMs');
load([PathName,filename])

for i=1:size(A,2)
    mA = cell2mat(A(1,i));
    for j=1:size(A,1)
        tmp = cell2mat(A(j,i));
        mA = (mA + tmp)/2;
    end
    maA{i}=mA;
end


nr = 6;
nf = 8;
DCM.Sname={
    'rOFA'
    'lOFA'
    'rFFA'
    'lFFA'
    'rSTS'
    'lSTS'};

kkk=1;
figure,
for i = 1:nr
    for j = 1:nr
        subplot(nr,nr,j + nr*(i - 1))
        ii = [1:nf]*nr - nr + i;
        jj = [1:nf]*nr - nr + j;
        A = mean(maA{1,kkk},1);kkk=kkk+1;
        plot(Hz,A,'LineWidth',2);  
        if i == 1, title({'from'; DCM.Sname{j}}), end
        if j == 1, ylabel({'to';  DCM.Sname{i}}), end
    end
end
set(gcf, 'Position', [700   10   800   1000]);



% reconstitute time-frequency coupling
% ----------------------------------------------------------------------
kkk=1;
figure,
for i = 1:nr
    for j = 1:nr
        subplot(nr,nr,j + nr*(i - 1))
        ii = [1:nf]*nr - nr + i;
        jj = [1:nf]*nr - nr + j;
        A = maA{1,kkk};kkk=kkk+1;
        imagesc(Hz,Hz,A)
        caxis(max(abs(caxis))*[-1 1]);
        axis image
        if i == 1, title({'from'; DCM.Sname{j}}), end
        if j == 1, ylabel({'to';  DCM.Sname{i}}), end    
    end
end

axes('position', [0.4, 0.95, 0.2, 0.01]);
axis off;
title('endogenous coupling (A)','FontSize',16)
colormap(winter);
set(gcf, 'Position', [700   10   800   1000]);
