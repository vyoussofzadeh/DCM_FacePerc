clc;clear all;close all;

% Example inout: CoupEEG.mat
path = 'U:\Vahab\My Matlab\Persons\Nadeem_Face data\Outputs\Group\source';
[filename,PathName] = uigetfile(path,'load average DCMs');
load([PathName,filename])

% n = 16;
% for i = 1:6
%     for j = 1:6
%         for k = 1:n
%             
%             A_F(k,:) =  ACoupling_F{k}(i,j);
%             A_B(k,:) =  ACoupling_B{k}(i,j);
%             A_L(k,:) =  ACoupling_L{k}(i,j);
%             
%             B_c(k,:) =  BCoupling_F{k}(i,j);
%              
% 
%             
%         end
%         AF.m(i,j) = mean(A_F); AF.s(i,j) = std(A_F); AF.t(i,j) = ttest(A_F);
%         AB.m(i,j) = mean(A_B); AB.s(i,j) = std(A_B); AB.t(i,j) = ttest(A_B);
%         AL.m(i,j) = mean(A_L); AL.s(i,j) = std(A_L); AL.t(i,j) = ttest(A_L);
%         
%         B.m(i,j) = mean(B_c); B.s(i,j) = std(B_c); B.t(i,j) = ttest(B_c);
%     end
% end


%     Symmetric Example:
% figure,
% h = barwitherr(B.s, B.m);% Plot with errorbars
% 
label = {'rOFA','lOFA','rFFA','lFFA','rSTS','lSTS'};
% 
%% Forward
F = find(mAcoup{1} > 0.1);
[a,b] = find(mAcoup{1} > 0.1);
figure (1),
subplot 221
% h = barwitherr(zeros(length(F),1), (mAcoup{1}(F))-1);% Plot with errorbars
bar((mAcoup{1}(F))-1)
for i=1:length(F)
   L{i} = [label{b(i)},'-',label{a(i)}]; 
end
set(gca,'XTickLabel',L)
XYrotalabel(45,0)
title('Forward connection')

F = find(mAcoup{1} < 0.1);
mAcoup{1}(F) = 0.01;
CH = {'rOFA','lOFA','rFFA','lFFA','rSTS','lSTS'};
figure(2),
subplot 221
plot_matrix_image (mAcoup{1}, CH);
title('Posterior means (F) ','fontsize', 14);

%% Backward
F = find(mAcoup{2} > 0.1);
[a,b] = find(mAcoup{2} > 0.1);
figure (1),
subplot 222
% h = barwitherr(zeros(length(F),1), (mAcoup{2}(F))-1);% Plot with errorbars
bar((mAcoup{2}(F))-1)
for i=1:length(F)
   L{i} = [label{b(i)},'-',label{a(i)}]; 
end
set(gca,'XTickLabel',L)
XYrotalabel(45,0)
title('Backward connection')

F = find(mAcoup{2} < 0.1);
mAcoup{2}(F) = 0.01;
% CH = {'rOFA','lOFA','rFFA','lFFA','rSTS','lSTS'};
figure(2),
subplot 222
plot_matrix_image (mAcoup{2}, CH);
title('Posterior means (B)','fontsize', 14);

%% Laterral
F = find(mAcoup{3} > 0.1);
[a,b] = find(mAcoup{3} > 0.1);
figure(1),
subplot 223
% h = barwitherr(zeros(length(F),1), (mAcoup{3}(F))-1);% Plot with errorbars
bar((mAcoup{3}(F))-1)
for i=1:length(F)
   L{i} = [label{b(i)},'-',label{a(i)}]; 
end
set(gca,'XTickLabel',L)
XYrotalabel(45,0)
title('Lateral connection')

F = find(mAcoup{3} < 0.1);
mAcoup{3}(F) = 0.01;
% CH = {'rOFA','lOFA','rFFA','lFFA','rSTS','lSTS'};
figure(2),
subplot 223
plot_matrix_image (mAcoup{3}, CH);
title('Posterior means (L)','fontsize', 14);

%% Modulatory
F = find(mBcoup{1} ~= 1);
[a,b] = find(mBcoup{1} ~= 1);
figure(1),
subplot 224
% h = barwitherr(zeros(length(F),1), (mBcoup{1}(F))-1);% Plot with errorbars
bar((mBcoup{1}(F))-1)
for i=1:length(F)
   L{i} = [label{b(i)},'-',label{a(i)}]; 
end
set(gca,'XTickLabel',L)
XYrotalabel(45,0)
title('Modulatory connection')

F = find(mBcoup{1} == 1);
mBcoup{1}(F) = 0.01;
figure(2),
subplot 224
plot_matrix_image (mBcoup{1}, CH);
title('Posterior means (madulatory, B) ','fontsize', 14);


% F = find(mBcoup{1} ~= 1);
% figure,
% h = barwitherr(zeros(length(F),1), (mBcoup{1}(F)));% Plot with errorbars
% set(gca,'XTickLabel',{'rOFA-rFFA','rOFA-rSTS','lOFA-lFFA','lOFA-lSTS','rFFA-rSTS','lFFA-lSTS'})
% XYrotalabel(45,0)
% title('Forward connection')


