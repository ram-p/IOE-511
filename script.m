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
% problem.name = 'P1_quad_10_10';
% rng(0); problem.x0 = 20*rand(10, 1) - 10;
% problem.n = length(problem.x0);

% problem.name = 'P2_quad_10_1000';
% rng(0); problem.x0 = 20*rand(10, 1) - 10;
% problem.n = length(problem.x0);
 
% problem.name = 'P3_quad_1000_10';
% rng(0); problem.x0 = 20*rand(1000, 1) - 10;
% problem.n = length(problem.x0);

% problem.name = 'P4_quad_1000_1000';
% rng(0); problem.x0 = 20*rand(1000, 1) - 10;
% problem.n = length(problem.x0);

% problem.name = 'P5_Quartic_1';
% theta = 7*pi/18; problem.x0 = [cos(theta); sin(theta); cos(theta); sin(theta)];
% problem.n = length(problem.x0);

% problem.name = 'P6_Quartic_2';
% theta = 7*pi/18; problem.x0 = [cos(theta); sin(theta); cos(theta); sin(theta)];
% problem.n = length(problem.x0);

% problem.name = 'P7_Rosenbrock_2';
% problem.x0 = [-1.2; 1];
% problem.n = length(problem.x0);

% problem.name = 'P8_Rosenbrock_100';
% problem.x0 = ones(100, 1);
% problem.x0(1) = -1.2;
% problem.n = length(problem.x0);

% problem.name = 'P9_DataFit_2';
% problem.x0 = [1; 1];
% problem.n = length(problem.x0);

% problem.name = 'P10_Exponential_10';
% problem.x0 = zeros(10, 1); problem.x0(1) = 1;
% problem.n = length(problem.x0);

% problem.name = 'P11_Exponential_100';
% problem.x0 = zeros(100, 1); problem.x0(1) = 1;
% problem.n = length(problem.x0);

problem.name = 'P12_Genhumps_5';
problem.x0 = 506.2 * ones(5, 1); problem.x0(1) = -problem.x0(1);
problem.n = length(problem.x0);


% Set method to solve the given problem.
% method.name = 'GradientDescent';
% method.name = 'Newton';
% method.name = 'BFGS';
% method.name = 'DFP';
% method.name = 'TRNewtonCG';
method.name = 'TRSR1CG';
% method.options.step_type = 'Wolfe';
% method.options.step_type = 'Backtracking';

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
options.delta = 10;

% Multiplication factor in the Cholesky subroutine. Defaults to 2
% options.nu = 2;
% Direct modification to the Hessian. Defaults to 0
% options.lambda = 0;

% Run the solver to return x*, f*, number of function and gradient evaluations, and the CPU computation time in seconds.
tic
[x,f,n_f,n_g] = optSolver_Northwood(problem, method, options);
toc

% gca
% hold on;
% 
% % Direct modification to the Hessian. Defaults to 0
% options.lambda = 2;
% 
% tic
% [x,f,n_f,n_g] = optSolver_Northwood(problem, method, options);
% toc
% 
% % Direct modification to the Hessian. Defaults to 0
% options.lambda = 5;
% 
% tic
% [x,f,n_f,n_g] = optSolver_Northwood(problem, method, options);
% toc
% 
% gca;
% legend(["lambda=0", "lambda=2", "lambda=5"])
