% IOE 511/MATH 562, University of Michigan
% Code written by: Batman

% Script to run code

% close all figures, clear all variables from workspace and clear command window
close all
clear
clc

addpath(genpath('Functions'))

% set problem (minimal requirement: name of problem)
problem.name = 'Rosenbrock';
problem.x0 = [-1.2; 1];
% problem.x0 = load('quadratic2.mat').x_0;
% problem.x0 = load('quadratic10.mat').x_0;
problem.n = length(problem.x0);

% set method (minimal requirement: name of method)
method.name = 'GradientDescent';
method.options.step_type = 'Backtracking';
method.options.constant_step_size = 1e-3;

% set options
options.term_tol = 1e-6;
options.max_iterations = 1e3;

% run method and return x^* and f^*
tic
[x,f] = optSolver_Padmanabhan_Ram(problem, method, options);
toc