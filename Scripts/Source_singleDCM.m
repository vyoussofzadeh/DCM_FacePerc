clc;clear all;close all;

path  = 'U:\Vahab\My Matlab\Persons\Nadeem_Face data\Output2\Outputs';
[filename,PathName] = uigetfile(path,'load single DCMs');
load([PathName,filename])

xY  = DCM.xY;                   % data
nt  = length(xY.nt);            % Nr trial types
t   = xY.pst;                   % PST

% post inversion parameters
%--------------------------------------------------------------------------
nu  = length(DCM.B);          % Nr inputs
nc  = size(DCM.H{1},2);       % Nr modes
ns  = size(DCM.A{1},1);       % Nr of sources
np  = size(DCM.K{1},2)/ns;    % Nr of population per source

A = [0 0];

allcolors = { [1 0 0]
    [0 0.5000 0]
    [0 0 1]
    [0.2500 0.2500 0.2500]
    [0 0.75 0]
    [0.2500 0 0.2500]
    [0.2500 0.2 0.700]
    [0.700 0.2 0.2500]
    [0.2500 0.5 0.500]
    [0.2500 1 0.500]}; % colors from real plots
col = cell2mat(allcolors);

figure
z = 1;
for i = 3:3:18
    hold on
    Y_source = DCM.K{1}(:,i);
    plot(t,Y_source, 'Color',col(z,:),'LineWidth',2);
    z = z+1;
    hold off
    set(gca,'color','none'),box off
    grid off
    axis square
    a    = axis;
    A(1) = min(A(1),a(3));
    A(2) = max(A(2),a(4));
    ylabel('Amplitude (\muV)','FontSize',11)
end
legend([
    'rOFA';
    'lOFA';
    'rFFA';
    'lFFA';
    'rSTS';
    'lSTS';
    ])


%%
% U = DCM.M.U';
% Y_observed  = (DCM.H{1} + DCM.R{1})*U;
% Y_sensor = DCM.H{1}*U;
% 
% figure,
% headplot(Y_observed(J,:),'meffdcpca_cga_1034227-vep2.spl','view',[-66 6],'electrodes','off');
% title(['Obreved (',mat2str(t(J)),') ms'],'fontsize',14);


% A matrix
mAcoup{1} = exp(DCM.Ep.A{1}); % Forward  connections
mAcoup{2} = exp(DCM.Ep.A{2}); % Backward connections
mAcoup{3} = exp(DCM.Ep.A{3}); % Lateral  connections

label = {'rOFA','lOFA','rFFA','lFFA','rSTS','lSTS'};
% 
%% Forward
F = find(mAcoup{1} > 0.1);
[a,b] = find(mAcoup{1} > 0.1);
figure (2),
subplot 131
% h = barwitherr(zeros(length(F),1), (mAcoup{1}(F)));% Plot with errorbars
bar((mAcoup{1}(F)))
for i=1:length(F)
   L{i} = [label{b(i)},'-',label{a(i)}]; 
end
set(gca,'XTickLabel',L)
XYrotalabel(45,0)
title('Forward connection')

F = find(mAcoup{1} < 0.1);
mAcoup{1}(F) = 0.01;
CH = {'rOFA','lOFA','rFFA','lFFA','rSTS','lSTS'};
figure(3),
subplot 131
plot_matrix_image (mAcoup{1}, CH);
title('Posterior means (F) ','fontsize', 14);

%% Backward
F = find(mAcoup{2} > 0.1);
[a,b] = find(mAcoup{2} > 0.1);
figure (2),
subplot 132
% h = barwitherr(zeros(length(F),1), (mAcoup{2}(F)));% Plot with errorbars
bar((mAcoup{2}(F)))
for i=1:length(F)
   L{i} = [label{b(i)},'-',label{a(i)}]; 
end
set(gca,'XTickLabel',L)
XYrotalabel(45,0)
title('Backward connection')

F = find(mAcoup{2} < 0.1);
mAcoup{2}(F) = 0.01;
% CH = {'rOFA','lOFA','rFFA','lFFA','rSTS','lSTS'};
figure(3),
subplot 132
plot_matrix_image (mAcoup{2}, CH);
title('Posterior means (B)','fontsize', 14);

%% Laterral
F = find(mAcoup{3} > 0.1);
[a,b] = find(mAcoup{3} > 0.1);
figure(2),
subplot 133
% h = barwitherr(zeros(length(F),1), (mAcoup{3}(F)));% Plot with errorbars
bar((mAcoup{3}(F)))
for i=1:length(F)
   L{i} = [label{b(i)},'-',label{a(i)}]; 
end
set(gca,'XTickLabel',L)
XYrotalabel(45,0)
title('Lateral connection')

F = find(mAcoup{3} < 0.1);
mAcoup{3}(F) = 0.01;
% CH = {'rOFA','lOFA','rFFA','lFFA','rSTS','lSTS'};
figure(3),
subplot 133
plot_matrix_image (mAcoup{3}, CH);
title('Posterior means (L)','fontsize', 14);

% post inversion parameters
%--------------------------------------------------------------------------
nu  = length(DCM.B);          % Nr inputs
nc  = size(DCM.H{1},2);       % Nr modes
ns  = size(DCM.A{1},1);       % Nr of sources
np  = size(DCM.K{1},2)/ns;    % Nr of population per source

colormap(gray)
clf
for i = 1:ns
    for j = 1:ns
        
        % ensure connection is enabled
        %----------------------------------------------------------
        q     = 0;
        for k = 1:nu
            try, q = q | DCM.Ep.B{k}(i,j); end
            try, q = q | DCM.Ep.N{k}(i,j); end
        end
        
        % plot trial-specific effects
        %----------------------------------------------------------
        if q
            D     = zeros(nt,0);
            B     = zeros(nt,1);
            N     = zeros(nt,1);
            for k = 1:nu
                try, B = B + DCM.xU.X(:,k)*DCM.Ep.B{k}(i,j); end
                try, N = N + DCM.xU.X(:,k)*DCM.Ep.N{k}(i,j); end
            end
            
            if any(B(:)), D = B;     end
            if any(N(:)), D = [D N]; end
            
            subplot(ns,ns,(i - 1)*ns + j)
            bar(exp(D)*100)
            title([DCM.Sname{j}, ' to ' DCM.Sname{i}],'FontSize',10)
            xlabel('trial',  'FontSize',8)
            ylabel('strength (%)','FontSize',8)
            set(gca,'XLim',[0 nt + 1])
            set(gca,'yLim',[0 150])
        end
    end
end
set(gcf, 'Position', [700   10   800   1000]);


a = DCM.Ep.B{1,1};
figure, imagesc(exp(a))
b = exp(a);
% F = find(b == 1);
% b(F) = 0.01;
% [l1,l2] = find(b==1);
% b(l1,l2)=NaN;
plot_matrix_image (b, label);
colorbar
colormap gray
set(gca,'XTickLabel',CH)
set(gca,'YTickLabel',CH)


 
% %% Modulatory
% F = find(mBcoup{1} ~= 1);
% [a,b] = find(mBcoup{1} ~= 1);
% figure(1),
% subplot 134
% % h = barwitherr(zeros(length(F),1), (mBcoup{1}(F)));% Plot with errorbars
% bar((mBcoup{1}(F)))
% for i=1:length(F)
%    L{i} = [label{b(i)},'-',label{a(i)}]; 
% end
% set(gca,'XTickLabel',L)
% XYrotalabel(45,0)
% title('Modulatory connection')
% 
% F = find(mBcoup{1} == 1);
% mBcoup{1}(F) = 0.01;
% figure(2),
% subplot 134
% plot_matrix_image (mBcoup{1}, CH);
% title('Posterior means (madulatory, B) ','fontsize', 14);


