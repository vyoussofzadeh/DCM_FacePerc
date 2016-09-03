clc;clear all;close all;

n = 1; i = 1;
while n==1
    [filename,PathName] = uigetfile('U:\Vahab\My Matlab\Persons\Nadeem_Face data\Output2\Outputs','insert DCM models');
    ['...',PathName(end-3:end),filename]
    load([PathName,filename])
    Y_source{i} = DCM.K{1}; i=i+1;
    c = input('continue(y:1, n:0)?');
    if c==0
        n=0;
    end
end
t   = DCM.xY.pst;                   % PST

savepath = 'U:\Vahab\My Matlab\Persons\Nadeem_Face data\Outputs\Group\source';
s = input('Save (y:1)?');
e = input('EEG(1) or MEG(2) or MEEG(3)?');
if s==1
    if e==1
        save([savepath,'_EEG'], 't','Y_source');
    elseif e==2
        save([savepath,'_MEG'], 't','Y_source');
    elseif e==3
        save([savepath,'_MEEG'], 't','Y_source');
    end
end




