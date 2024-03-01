clear all
close all
clc

%% add functions to path
addpath('../fcn/');

%% load data
load data/structural_connectivity.mat
load data/coordinates.mat
load data/brain_states.mat

%% rescale sc matrix
a = sc;
a = a/eigs(a,1);
a = a - eye(length(a));

%% define input matrices
% beta controls the decay rate
beta = 0.15;
n = length(sc);
b_local = eye(n);
b_spatial = exp(-beta*squareform(pdist(coor)));

%% set parameters for optimal control
% same parameters from the manuscript
rho = 100;
T = 1;

%% run all possible transitions
e_global_spatial = zeros(size(cent,2));
e_global_local = e_global_spatial;

% for each initial state
for initial = 1:size(cent,2)
    x0 = cent(:,initial);
    
    % for each target state
    for target = 1:size(cent,2)
        xt = cent(:,target);
        
        % print status
        fprintf('%i to %i',initial,target);
        tic;
        
        % calculate trajectories and input signals
        [x_spatial,u_spatial] = optimalControlContinuous(a,b_spatial,rho,x0,xt,T);
        [x_local,u_local] = optimalControlContinuous(a,b_local,rho,x0,xt,T);
        
        % calculate global energy
        e_global_spatial(initial,target) = mean(mean(u_spatial(:).^2));
        e_global_local(initial,target) = mean(mean(u_local(:).^2));
        
        % print timer
        fprintf(' ... %.2f s\n',toc);
    end
end