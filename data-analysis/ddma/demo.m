% Demo for Discriminant Diffusion Maps Analysis (DDMA), a manifold learning
% method for dimensionality reduction. 
%
% In this demo, a 3-D three-arm spiral is presented in a   
% low-dimensional space (2-D). 
%
% By Yixiang Huang, School of Mechanical Engineering, 
%                   Shanghai Jiao Tong University
% Email: huang.yixiang@sjtu.edu.cn with comments & questions
%
% Last modified on Feb.28,2015
%

clear all; clc; close all;
% Generate a three-arm spiral data
gen_spir_3d

figure('Color',[1 1 1])
plot3(dat(1:arm,1),dat(1:arm,2),dat(1:arm,3),'b.');hold on
plot3(dat(arm+1:arm2,1),dat(arm+1:arm2,2),dat(arm+1:arm2,3),'g+');
plot3(dat(arm2+1:end,1),dat(arm2+1:end,2),dat(arm2+1:end,3),'r^');hold off;
grid on
title('Original data','FontSize',15,'Interpreter','LaTex')

%% DDMA parameters
d=2; % Reduced dimensionality
r=1; % Discriminant constant
t=3; % Scale factor, a positive interger 
nb=20; % The number of neighbour

% Pre-classification to gain discriminant information
[s_train,s_test]=crossvalind('HoldOut',size(dat,1),4/5); 
prelab=knnclassify(dat,dat(s_train,:),lab(s_train,:),nb);

% Discriminant Diffusion Map estimation
[X_r, ctrs] = ddma(dat, prelab, d, r, t, nb);

figure('Color',[1 1 1])
plot(X_r(1:arm,1),X_r(1:arm,2),'b.');hold on
plot(X_r(arm+1:arm2,1),X_r(arm+1:arm2,2),'g+');
plot(X_r(arm2+1:end,1),X_r(arm2+1:end,2),'r^');hold off;
title('Discriminant Diffusion Maps Embedding','FontSize',15,'Interpreter','LaTex')
hold off;

% clear X
