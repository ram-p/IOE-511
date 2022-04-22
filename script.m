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

problem.name = 'P7_Rosenbrock_2';
problem.x0 = [-1.2; 1];
problem.n = length(problem.x0);

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

% problem.name = 'P12_Genhumps_5';
% problem.x0 = 506.2 * ones(5, 1); problem.x0(1) = -problem.x0(1);
% problem.n = length(problem.x0);


% Set method to solve the given problem.
% method.name = 'GradientDescent';
method.name = 'Newton';
% method.name = 'BFGS';
% method.name = 'DFP';
% method.name = 'TRNewtonCG';
% method.name = 'TRSR1CG';
method.options.step_type = 'Wolfe';
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
options.nu = 2;


% lambdas = [0, 100, 200, 300, 500, 700, 1000];
% l = length(lambdas);
leg = [];
solve_times = [];
solve_iters = [];
lambdas = [];

for i = 1:50
    lambda = 20*i;
    lambdas = [lambdas; lambda];
    options.lambda = lambdas(i);
    disp("Lambda="+lambdas(i))
    tic
    [x,f,n_f,n_g,eigvals, k] = optSolver_Northwood(problem, method, options);
    solve_time = toc;
    solve_times = [solve_times; solve_time];
    solve_iters = [solve_iters; k];

    if i == 1
        gca;
        hold on;
    end
    leg = [leg, "$\lambda = $" + options.lambda];
end

% method.name = 'GradientDescent';
% method.options.step_type = 'Wolfe';
% disp("GradientDescent")
% tic
% [x,f,n_f,n_g,eigvals] = optSolver_Northwood(problem, method, options);
% toc
% leg = [leg, "Gradient Descent"];

figure(1);
legend(leg, 'Interpreter', 'latex')

figure(2);
legend(leg)
legend(leg, 'Interpreter', 'latex')

figure;
subplot(1, 2, 1)
plot(lambdas, solve_times, 'LineWidth', 2);
xlabel('$\lambda$', 'Interpreter', 'latex')
ylabel('CPU Time to solve (s)', 'Interpreter', 'latex')
grid on
set(gca, 'FontName', 'Times New Roman', 'FontSize', 16)

subplot(1, 2, 2)
plot(lambdas, solve_iters, 'LineWidth', 2);
xlabel('$\lambda$', 'Interpreter', 'latex')
ylabel('Iterations to solve', 'Interpreter', 'latex')
grid on
set(gca, 'FontName', 'Times New Roman', 'FontSize', 16)

