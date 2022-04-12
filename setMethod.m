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
%   (1) if method is a trust region method and radius is unspecified
function [method] = setMethod(method)

% check is method name specified
if ~isfield(method,'name')
    error('Method not specified!!!')
end

switch method.name
    case 'TRNewtonCG'
        if ~isfield(method.options, 'delta')
            warning('Initial trust region radius not specified, defaulting to 1')
            method.options.delta = 1.0;
        end
    case 'TRSR1CG'
        if ~isfield(method.options, 'delta')
            warning('Initial trust region radius not specified, defaulting to 1')
            method.options.delta = 1.0;
        end
        
end