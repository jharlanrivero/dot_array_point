function [i1G, error_i1G] = integral_oneG(N, kmpup, kmdot, s)
%
% [IT, ERROR_IT] = INTEGRAL_T(N, Q, FN, KMPUP, KMDOT, S)
%
%   IT is the integral t value, for the cut-off N. See manuscript.
%  
%   ERROR_IT is the error from the numerical approxiamtion to IT.
%
%   N is the cut off.
%
%   Q is the quotient between the inner and outer scales.
%
%   FN is the Fresnel number for the inner-scale frequency.
%
%   KMPUP is the dimensionless entrance pupil
%
%   'kmdot' is the dimensionless separation between dots, $\kappa_m d$, in the array.
%
%   's' is the dimensionless layer position ($\xi/L$) where IT is evaluated.
%
%

n = length(s);
i1G = zeros(n,1);error_i1G = zeros(n,1);

for k=1:n
    if s(k) == 1
        i1G(k)=0; error_i1G(k)= 0;
    else
        e1G = @(x)(x.^(-8/3).*(besselj(1,(1-s(k)).*kmpup.*x/2)./((1-s(k)).*kmpup)).^2....
            .*(1/2-besselj(1,(1-s(k)).*kmdot.*x)./((1-s(k)).*kmdot.*x)));
    
        [i1G(k),error_i1G(k)]= quadgk(e1G,0,N,'RelTol',0,'AbsTol',1e-10,... 
            'MaxIntervalCount',10461);%1e-13
    end
end