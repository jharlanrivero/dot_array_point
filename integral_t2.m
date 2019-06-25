function [it2, error_it2] = integral_t2(N, H, L, q, fn, kmpup, kmdot, s)
%
% [IT2, ERROR_IT2] = INTEGRAL_T2(N, Q, FN, KMPUP, KMDOT, S)
%
%   IT2 integration in s, for the cut-off N. See manuscript.
%  
%   ERROR_IT2 is the error from the numerical approxiamtion to IT.
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
it2 = zeros(n,1);error_it2 = zeros(n,1);


for k=1:n 
    fun1 = @(y)(y.*(integral_t(N, H, L, q, fn, kmpup, kmdot, s)));
    [it2(k),error_it2(k)]= quadgk(fun1,0,1,'RelTol',0,'AbsTol',1e-10,... 
    'MaxIntervalCount',10468);%1e-13
      
end

