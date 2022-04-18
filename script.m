% Main script file to run code.
% Code written by Northwood Team.

% Close all figures, clear all variables from workspace, clear the command window and improve appearance.
close all
clear
clc
format compact

% Add required folders to the current Matlab path.
addpath(genpath('Functions'))
addpath(genpath('Methods'))

% Set problem name and initial condition.
problem.name = 'P4_quad_1000_1000';
rng(0); problem.x0 = 20*rand(1000, 1) - 10;
problem.n = length(problem.x0);

% Set method to solve the given problem.
method.name = 'DFP';
method.options.step_type = 'Wolfe';

% Set different constants.
options.term_tol = 1e-6;
options.max_iterations = 1e3;
options.c1_ls = 1e-3;
options.c2_ls = 0.9;
options.c1_tr = 1e-3;
options.c2_tr = 0.5;
options.term_tol_CG = 1e-6;
options.max_iterations_CG = 1e3;
options.beta = 1e-6;
options.eps = 1e-6;
options.delta = 1;

% Run the solver to return x*, f* and the CPU computation time in seconds.
tic
[x,f] = optSolver_Northwood(problem, method, options);
toc