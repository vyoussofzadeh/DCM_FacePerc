clc;clear all;close all;

n = 1; ff = 1;
while n==1
    
    [filename,PathName] = uigetfile('U:\Vahab\My Matlab\Persons\Nadeem_Face data\Output2\Outputs','insert DCM models');
    ['...',PathName(end-3:end),filename]
    load([PathName,filename]);
    
    % A matrix
%     ACoupling_F{i} = DCM.Ep.A{1}; % Forward  connections
%     ACoupling_B{i} = DCM.Ep.A{2}; % Backward connections
%     ACoupling_L{i} = DCM.Ep.A{3}; % Lateral  connections
%     
%     APosProb_F{i} = DCM.Pp.A{1}; % Forward  connections
%     APosProb_B{i} = DCM.Pp.A{2}; % Backward connections
%     APosProb_L{i} = DCM.Pp.A{3}; % Lateral  connections
    
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
    k = 1;
    for i = 1:nr
        for j = 1:nr
            ii = (1:nf)*nr - nr + i;
            jj = (1:nf)*nr - nr + j;
            A{ff,k}  = xY.U*DCM.Ep.A(ii,jj)*xY.U'; k= k+1;
        end
    end
    
    ff=ff+1;
    c = input('continue(y:1, n:0)?');
    if c==0
        n=0;
    end
end
t   = DCM.xY.pst;  % PST

savepath = 'U:\Vahab\My Matlab\Persons\Nadeem_Face data\Outputs\Group\Group';
s = input('Save (y:1)?');
if s == 1
    e = input('EEG(1) or MEG(2) or MEEG(3)?');
    if s==1
        if e==1
            save([savepath,'_EEGind'], 'A','Hz');
        elseif e==2
            save([savepath,'_MEGind'], 'A','Hz');
        elseif e==3
            save([savepath,'_MEEGind'], 'A','Hz');
        end
    end
end



