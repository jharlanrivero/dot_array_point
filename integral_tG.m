function [itG, error_itG] = integral_tG(N, D, d, L, s)
%
% [ITG, ERROR_ITG] = INTEGRAL_TG(N, D, d, L, s)
%
%   ITG is the integral t value, for the cut-off N. See manuscript of Gladys(2017).
%  
%   ERROR_ITG is the error from the numerical approxiamtion to ITG.
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
itG = zeros(n,1);error_itG = zeros(n,1);

for k=1:n
    if s(k) == 1
        itG(k)=0; error_itG(k)= 0;
    else
        etG = @(x)(x.^(-8/3).*(besselj(1,((s(k).*x.*D)./2.*L))).^2....
            .*(1-besselj(0,(x.*d.*((L-s(k))./L)))));
    
        [itG(k),error_itG(k)]= quadgk(etG,0,N,'RelTol',0,'AbsTol',1e-10,... 
            'MaxIntervalCount',12536);%1e-13
    end
end