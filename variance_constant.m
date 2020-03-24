function varc = variance_constant(H, L, Rm,km,varargin)
%
%
%
%
%
if nargin==5
    q = varargin{1};
elseif nargin>5
    disp("Too many arguments.");
    return
else
    q = 1;
end
varc = 4/pi*km.^(1-2.*H).*gamma(2.*H+2).*sin(pi*H).*L./Rm.^2./q^(2*H+1);
