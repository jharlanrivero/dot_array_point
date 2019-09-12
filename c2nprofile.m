function c2n = c2nprofile(x,varargin)
%
%
%
%
%
%
%
n= length(x);
c2n = zeros(1,n);

if nargin == 2
    c2n = varargin{1}*ones(1,n);
elseif nargin == 3
    for k=1:n
        c2n(k) = spline(varargin{1},varargin{2},x(k));
    end
else 
    c2n = ones(1,n);
end