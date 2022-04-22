% Function that specifies the method.
% Input: method (struct).
% Output: method (struct).
% Error: If method name is not specified.
% Code written by Northwood Team.

function [method] = setMethod(method)

% Check if method name is specified.
if ~isfield(method,'name')
    error('Method not specified!!!')
end

end