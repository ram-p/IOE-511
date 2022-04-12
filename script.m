% IOE 511/MATH 562, University of Michigan
% Code written by: Batman

% Script to run code

% close all figures, clear all variables from workspace and clear command window
close all
clear
clc

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
options.term_tol = 1e-6;
options.max_iterations = 1e3;

% run method and return x^* and f^*
tic
[x,f] = optSolver_Northwood(problem, method, options)
toc