% IOE 511/MATH 562, University of Michigan
% Code written by: Shreyas Bhat

% Function that specifies the method and method specific options. 
% 
%           Input: method (struct); required (method.name)
%           Output: method (struct)
%
% Error(s): 
%   (1) if method not specified
% Warning(s)
%   (1) if method is LBFGS and memory length is uspecified
function [method] = setMethod(method)

% check is method name specified
if ~isfield(method,'name')
    error('Method not specified!!!')
end

switch method.name
    case 'LBFGS'
        if ~isfield(method.options, 'mem')
            warning('Memory length not sepcified, defaulting to 5 pairs')
            method.options.mem = 5;
        end
%         % Initialize the memory
%         method.sks = [];
%         method.yks = [];
end