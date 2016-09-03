clc;clear all;close all;

% load DCM_MEG_Induced.mat of e.g. subject 1 
[filename,PathName] = uigetfile;
load([PathName,filename])

S = full(DCM.xY.S);

VE = S.^2/sum(S.^2);

figure,
bar(VE)


% spm_dcm_ind_results(DCM,'Coupling (A - Hz)')


xY     = DCM.xY;
xU     = DCM.xU;
nt     = length(xY.y);           % Nr of trial types
nr     = size(xY.xf,2);          % Nr of sources
nu     = size(xU.X, 2);          % Nr of experimental effects
nf     = DCM.options.Nmodes;     % Nr of frequency modes explained
ns     = size(xY.y{1},1);        % Nr of time bins
pst    = xY.pst;                 % peri-stmulus time
Hz     = xY.Hz;                  % frequencies
xY.U   = xY.U(:,1:nf);           % remove unmodelled frequency modes

figure,
for i = 1:nr
    for j = 1:nr
        subplot(nr,nr,j + nr*(i - 1))
        ii = [1:nf]*nr - nr + i;
        jj = [1:nf]*nr - nr + j;
        A  = xY.U*DCM.Ep.A(ii,jj)*xY.U';
        A1 = mean(A,1);
        plot(Hz,A1,'LineWidth',2);
%         imagesc(Hz,Hz,A)
%         caxis(max(abs(caxis))*[-1 1]);
%         axis image
        
        % source names
        %--------------------------------------------------------------
        if i == 1, title({'from'; DCM.Sname{j}}), end
        if j == 1, ylabel({'to';  DCM.Sname{i}}), end
        

        
    end
end

axes('position', [0.4, 0.95, 0.2, 0.01]);
axis off;
title('endogenous coupling (A)','FontSize',16)
colormap(jet);
set(gcf, 'Position', [700   10   800   1000]);

% reconstitute time-frequency coupling
% ----------------------------------------------------------------------
figure,
for i = 1:nr
    for j = 1:nr
        subplot(nr,nr,j + nr*(i - 1))
        ii = [1:nf]*nr - nr + i;
        jj = [1:nf]*nr - nr + j;
        A  = xY.U*DCM.Ep.A(ii,jj)*xY.U';
%         A = mean(A,1);
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
colormap(jet);
set(gcf, 'Position', [700   10   800   1000]);
