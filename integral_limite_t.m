function [itl, error_itl] = integral_limite_t(N, H, q, kmpup, kmdot, s)
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
%----------------------------------------------------------------------------
% con km -> infy / exp[-(k/km)^2] = 1, con  Cos = 1 una aproximacion dada
% por gladys.
% luego de esto hacemos el cambio de variable de k = km.*u

n = length(s);
itl = zeros(n,1);error_itl = zeros(n,1);

for k=1:n
    if s(k) == 1
        itl(k)=0; error_itl(k)= 0;
    else
        et = @(x)((x.^2+q^2).^(-H-3/2)...
            .*(besselj(1,(1-s(k)).*kmpup.*x/2)./((1-s(k)).*kmpup)).^2 ...
            .*(1-besselj(0,kmdot.*x.*(1-s(k)))));
    
        [itl(k),error_itl(k)]= quadgk(et,0,N,'RelTol',0,'AbsTol',1e-10,... 
            'MaxIntervalCount',10461);%1e-13
    end
end