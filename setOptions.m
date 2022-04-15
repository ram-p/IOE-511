% Function that specifies general options. 
% Input: options (struct).
% Output: options (struct).
% Warning: If tolerance and maximum iterations not specified.
% Code written by Northwood Team.

function [options] = setOptions(options)

% Check if termination tolerance is specified.
if ~isfield(options,'term_tol')
    warning('Termination tolerance not specified!!! Setting to default: 1e-6')
    options.term_tol = 1e-6;
end

% Check if max iterations is specified
if ~isfield(options,'max_iterations')
    warning('Maximum iterations not specified!!! Setting to default: 1e2')
    options.max_iterations = 1e2;
end

end