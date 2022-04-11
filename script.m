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


% set problem (minimal requirement: name of problem)
% problem.name = 'Rosenbrock';
% % problem.x0 = [1.2;1.2];
% problem.x0 = [-1.2;1];
% problem.n = length(problem.x0);
% x_star = [1;1];
% f_star = rosen_func(x_star);

% set problem (minimal requirement: name of problem)
problem.name = 'Function2';
problem.x0 = [1;1];
problem.n = length(problem.x0);

% set problem (minimal requirement: name of problem)
problem.name = 'Function3';
n = 1000;
x0 = zeros(n, 1);
x0(1) = 1;
problem.x0 = x0;
problem.n = length(problem.x0);

% load the data
% load('quadratic2.mat');
% load('quadratic10.mat');

% problem.name = 'Quadratic';
% problem.x0 = x_0;
% problem.A = A;
% problem.b = b;
% problem.c = c;
% problem.n = length(problem.x0);
% 

% set options
options.term_tol = term_tol;
options.max_iterations = max_iters;
options.alpha_bar = alpha_bar;
options.rho = rho;
options.c1 = c1;
options.beta = beta;
options.eps = eps;
options.track = true;

% set method (minimal requirement: name of method)
method.options.step_type = 'Backtracking';
method.name = 'GradientDescent';
% method.name = 'ModifiedNewton';
% method.name = 'BFGS';
% method.name = 'LBFGS';
% method.options.mem = 5;

tic
[x, f, fvals, norm_gs,~,~,~,~] = optSolver_Bhat_Shreyas(problem, method, options);
toc

grad_fig = figure;
plot(norm_gs, 'LineWidth', 1)
set(gca, 'Yscale', 'log')
title('Magnitude of gradient')
xlabel('Iterations')
ylabel('Norm g')

% func_fig = figure;
% plot(fvals, 'LineWidth', 2)
% % set(gca, 'Yscale', 'log')
% title('Function value')
% xlabel('Iterations')
% ylabel('fval')


% set method (minimal requirement: name of method)
method.options.step_type = 'Backtracking';
% method.name = 'GradientDescent';
method.name = 'ModifiedNewton';
% method.name = 'BFGS';
% method.name = 'LBFGS';
% method.options.mem = 5;

tic
[x, f, fvals, norm_gs, modification_counter, modified_iters,~,~] = optSolver_Bhat_Shreyas(problem, method, options);
toc

modification_counter
modified_iters

grad_fig;
hold on;
plot(norm_gs, 'LineWidth', 1)
% hold on;
title('Magnitude of gradient')
xlabel('Iterations')
ylabel('Norm g')

% set method (minimal requirement: name of method)
method.options.step_type = 'Backtracking';
% method.name = 'GradientDescent';
% method.name = 'ModifiedNewton';
method.name = 'BFGS';
% method.name = 'LBFGS';
% method.options.mem = 5;

tic
[x, f, fvals, norm_gs, ~, ~,skipped_counter,skipped_iters] = optSolver_Bhat_Shreyas(problem, method, options);
toc

skipped_counter
skipped_iters

grad_fig;
plot(norm_gs, 'LineWidth', 1)
title('Magnitude of gradient')
xlabel('Iterations')
ylabel('Norm g')

% set method (minimal requirement: name of method)
method.options.step_type = 'Backtracking';
% method.name = 'GradientDescent';
% method.name = 'ModifiedNewton';
% method.name = 'BFGS';
method.name = 'LBFGS';
method.options.mem = 2;

tic
[x, f, fvals, norm_gs, ~, ~,~,~] = optSolver_Bhat_Shreyas(problem, method, options);
toc

grad_fig;
plot(norm_gs, 'LineWidth', 1)
title('Magnitude of gradient')
xlabel('Iterations')
ylabel('Norm g')

% set method (minimal requirement: name of method)
method.options.step_type = 'Backtracking';
% method.name = 'GradientDescent';
% method.name = 'ModifiedNewton';
% method.name = 'BFGS';
method.name = 'LBFGS';
method.options.mem = 5;

tic
[x, f, fvals, norm_gs, ~, ~,~,~] = optSolver_Bhat_Shreyas(problem, method, options);
toc

grad_fig;
plot(norm_gs, 'LineWidth', 1)
title('Magnitude of gradient')
xlabel('Iterations')
ylabel('Norm g')


% set method (minimal requirement: name of method)
method.options.step_type = 'Backtracking';
% method.name = 'GradientDescent';
% method.name = 'ModifiedNewton';
% method.name = 'BFGS';
method.name = 'LBFGS';
method.options.mem = 10;

tic
[x, f, fvals, norm_gs, ~, ~,~,~] = optSolver_Bhat_Shreyas(problem, method, options);
toc

grad_fig;
plot(norm_gs, 'LineWidth', 1)
title('Magnitude of gradient')
xlabel('Iterations')
ylabel('Norm g')
set(gca, 'Yscale', 'log')
legend('Gradient Descent', 'ModifiedNewton', 'BFGS', 'LBFGS 2', 'LBFGS 5', 'LBFGS 10')

