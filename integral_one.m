function [i1, error_it] = integral_one(N,H, q, fn, kmpup, kmdot, s)
%
% [I1, ERROR_I1] = INTEGRAL_ONE(N, Q, FN, KMPUP, KMDOT, S)
%
%   I1 is the integral one value, for the cut-off N. See manuscript.
%  
%   ERROR_I1 is the error from the numerical approxiamtion to IT.
%
%   N is the cut off.
%
%   Q is the quotient between the inner and outer scales.
%
%   FN is the Fresnel number for the inner-scale frequency.
%
%   KMPUP is the dimensionless entrance pupil
%
%   KMDOT is the dimensionless separation between dots in the array.
%
%   S is the layer position where IT is evaluated.
%
%

n = length(s);
i1 = zeros(n,1);error_it = zeros(n,1);

for k=1:n
        if s(k) == 1
            i1(k)=0; error_it(k)= 0;
        else
            eone = @(x)(x.^3.*exp(-1*x.^2)./(x.^2+q^2).^(H+3/2).*cos(-1*fn.*(1-s(k))^2.*x.^2).^2 ...
                .*(besselj(1,(1-s(k)).*kmpup.*x/2)./((1-s(k)).*kmpup.*x)).^2 ...
                .*(1/2-besselj(1,(1-s(k)).*kmdot.*x)./((1-s(k)).*kmdot.*x)));
        
            [i1(k),error_it(k)]= quadgk(eone,0,N,'RelTol',0,'AbsTol',1e-10,... 
                'MaxIntervalCount',10468);%1e-13
        end
end
