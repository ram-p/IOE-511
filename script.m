% IOE 511/MATH 562, University of Michigan
% Code written by: Shreyas Bhat

% Script to run code

% close all figures, clear all variables from workspace and clear command
% window
close all
clear all
clc

% constants
alpha_bar = 1;
c1 = 1e-4;
rho = 0.5;
max_iters = 1000;
term_tol = 1e-6;
beta = 1e-6;
eps = 1e-6;

% Add paths with the functions
addpath(genpath('./Functions'))

%% Part 0: Example of running the solver

format compact

addpath(genpath('Functions'))
addpath(genpath('Methods'))

% set problem (minimal requirement: name of problem)
problem.name = 'P7_Rosenbrock_2';
problem.x0 = [-1.2; ones(1, 1)];
problem.n = length(problem.x0);

% set method (minimal requirement: name of method)
method.name = 'Newton';
method.options.step_type = 'Wolfe';

% set options
options.term_tol = term_tol;
options.max_iterations = max_iters;
options.alpha_bar = alpha_bar;
options.rho = rho;
options.c1 = c1;
options.beta = beta;
options.eps = eps;
options.track = true;

tic
[x,f] = optSolver_Northwood(problem, method, options);
toc
