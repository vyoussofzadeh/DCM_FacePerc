clc;clear all;close all;

n = 1; i = 1;
while n==1
    
    [filename,PathName] = uigetfile('U:\Vahab\My Matlab\Persons\Nadeem_Face data\Outputs','insert DCM models');
    ['...',PathName(end-3:end),filename]
    load([PathName,filename]);
    
    % A matrix
    ACoupling_F{i} = DCM.Ep.A{1}; % Forward  connections
    ACoupling_B{i} = DCM.Ep.A{2}; % Backward connections
    ACoupling_L{i} = DCM.Ep.A{3}; % Lateral  connections
    
    APosProb_F{i} = DCM.Pp.A{1}; % Forward  connections
    APosProb_B{i} = DCM.Pp.A{2}; % Backward connections
    APosProb_L{i} = DCM.Pp.A{3}; % Lateral  connections
    
    % B matrix
    BCoupling_F{i} = DCM.Ep.B{1};
    BPosProb_F{i}  = DCM.Pp.B{1};
    
    Y_source{i} = DCM.K{1};      % Estimated sources
    
    i=i+1;
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
            save([savepath,'_EEG'], 'Y_source','t','ACoupling_F','ACoupling_B','ACoupling_L','APosProb_F','APosProb_B','APosProb_L','BCoupling_F','BPosProb_F');
        elseif e==2
            save([savepath,'_MEG'], 'Y_source','t','ACoupling_F','ACoupling_B','ACoupling_L','APosProb_F','APosProb_B','APosProb_L','BCoupling_F','BPosProb_F');
        elseif e==3
            save([savepath,'_MEEG'], 'Y_source','t','ACoupling_F','ACoupling_B','ACoupling_L','APosProb_F','APosProb_B','APosProb_L','BCoupling_F','BPosProb_F');
        end
    end
end



