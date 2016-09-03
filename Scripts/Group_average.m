clc;clear all;close all;

% Example inout: Group_EEG.mat
path = 'U:\Vahab\My Matlab\Persons\Nadeem_Face data\Outputs\Group\source';
[filename,PathName] = uigetfile(path,'load average DCMs');
load([PathName,filename])

mY_source    = Y_source{1};
mACoupling_F = ACoupling_F{1};
mACoupling_B = ACoupling_B{1};
mACoupling_L = ACoupling_L{1};

mAPosProb_F = APosProb_F{1};
mAPosProb_B = APosProb_B{1};
mAPosProb_L = APosProb_L{1};

% B matrix
mBCoupling_F = BCoupling_F{1};
mBPosProb_F  = BPosProb_F{1};

for i = 1:length(Y_source)
    mY_source = (mY_source + Y_source{i})./2;
    
    mACoupling_F = (mACoupling_F + ACoupling_F{i})./2;
    mACoupling_B = (mACoupling_B + ACoupling_B{i})./2;
    mACoupling_L = (mACoupling_L + ACoupling_L{i})./2;
    
    mAPosProb_F = (mAPosProb_F + APosProb_F{i})./2;
    mAPosProb_B = (mAPosProb_B + APosProb_B{i})./2;
    mAPosProb_L = (mAPosProb_L + APosProb_L{i})./2;
    
    % B matrix
    mBCoupling_F = (mBCoupling_F + BCoupling_F{i})./2;
    mBPosProb_F = (mBPosProb_F + BPosProb_F{i})./2;

end


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
%% Source
figure
z = 1;
for i = 3:3:18
    hold on
    plot(t,mY_source(:,i), 'Color',col(z,:),'LineWidth',2);
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

mACoupling{1} = mACoupling_F;
mACoupling{2} = mACoupling_B;
mACoupling{3} = mACoupling_L;
    
mAPosProb{1} = mAPosProb_F;
mAPosProb{2} = mAPosProb_B;
mAPosProb{3} = mAPosProb_L;

Sname = ['rOFA';'lOFA';'rFFA';'lFFA';'rSTS';'lSTS'];
str = ['Forward ';'Backward';'Lateral '];
ns = 6;
n  = 3;

figure,
for i = 1:n
    % images
    %--------------------------------------------------------------
    subplot(4,n,i)
    mAcoup{i} = exp(mACoupling{i});
    imagesc(mAcoup{i})
    title(str(i,:),'FontSize',10)
    set(gca,'YTick',1:ns,'YTickLabel',Sname,'FontSize',8)
    set(gca,'XTick',[])
    xlabel('from','FontSize',8)
    ylabel('to','FontSize',8)
    axis square
    
    % table
    %--------------------------------------------------------------
    subplot(4,n,i + n)
    text(0,1/2,num2str(full(exp(mACoupling{i})),' %.2f'),'FontSize',8)
    axis off,axis square
    
    
    % PPM
    %--------------------------------------------------------------
    subplot(4,n,i + n + n)
    image(64*mAPosProb{i})
    set(gca,'YTick',1:ns,'YTickLabel',Sname,'FontSize',8)
    set(gca,'XTick',[])
    title('PPM')
    axis square
    
    % table
    %--------------------------------------------------------------
    subplot(4,n,i + n + n + n)
    text(0,1/2,num2str(mAPosProb{i},' %.2f'),'FontSize',8)
    axis off, axis square
    
end

% B matrix
mBCoupling{1} = mBCoupling_F;
mBPosProb{1} = mBPosProb_F;

str = 'B matrix';
ns = 6;
n  = 1;

figure,
for i = 1:n
    % images
    %--------------------------------------------------------------
    subplot(4,n,i)
    mBcoup{i} = exp(mBCoupling{i});
    imagesc(mBcoup{i})
    title(str(i,:),'FontSize',10)
    set(gca,'YTick',1:ns,'YTickLabel',Sname,'FontSize',8)
    set(gca,'XTick',[])
    xlabel('from','FontSize',8)
    ylabel('to','FontSize',8)
    axis square
    
    % table
    %--------------------------------------------------------------
    subplot(4,n,i + n)
    text(0,1/2,num2str(full(exp(mBCoupling{i})),' %.2f'),'FontSize',8)
    axis off,axis square
    
    
    % PPM
    %--------------------------------------------------------------
    subplot(4,n,i + n + n)
    image(64*mBPosProb{i})
    set(gca,'YTick',1:ns,'YTickLabel',Sname,'FontSize',8)
    set(gca,'XTick',[])
    title('PPM')
    axis square
    
    % table
    %--------------------------------------------------------------
    subplot(4,n,i + n + n + n)
    text(0,1/2,num2str(mBPosProb{i},' %.2f'),'FontSize',8)
    axis off, axis square
    
end
savepath = 'U:\Vahab\My Matlab\Persons\Nadeem_Face data\Outputs\Group\';
s = input('Save (y:1)?');
if s==1
    e = input('EEG(1) or MEG(2) or MEEG(3)?');
    if e==1
        save([savepath,'CoupEEG'], 'mBcoup','mAcoup');
    elseif e==2
        save([savepath,'CoupMEG'], 'mBcoup','mAcoup');
    elseif e==3
        save([savepath,'CoupMEEG'], 'mBcoup','mAcoup');
    end
end
