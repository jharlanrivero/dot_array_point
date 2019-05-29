function [itG2, error_itG2] = integral_tG2(N, L, D, d, s)
%
% [IT2, ERROR_IT2] = INTEGRAL_T2(N, Q, FN, KMPUP, KMDOT, S)
%
%   IT2 is the integral t value, for the cut-off N. See manuscript.
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
itG2 = zeros(n,1);error_itG2 = zeros(n,1);


for k=1:n 
    fun2 = @(y)(y.*(integral_tG(N, L, D, d, s)));
    [itG2(k),error_itG2(k)]= quadgk(fun2,0,1,'RelTol',0,'AbsTol',1e-10,... 
    'MaxIntervalCount',12536);%1e-13
      
end