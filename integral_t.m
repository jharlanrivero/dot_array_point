function [it, error_it] = integral_t(N, km, H, q, fn, Rm, rm, s)
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
it = zeros(n,1);error_it = zeros(n,1);

for k=1:n
    if s(k) == 1
        it(k)=0; error_it(k)= 0;
    else
        et = @(x)((32*1.50459.*km.^(1-2.*H)./Rm.^2.*sin(pi.*H)).*x.*exp(-1*x.^2)./(x.^2+q^2).^(H+3/2).*cos((1-s(k)).^2.*x.^2.*fn).^2 ...
                .*(besselj(1,(1-s(k)).*Rm.*x)).^2 ...
            .*(1-besselj(0,(1-s(k)).*rm.*x)));
    
        [it(k),error_it(k)]= quadgk(et,0,N,'RelTol',0,'AbsTol',1e-10,... 
            'MaxIntervalCount',10468);%1e-13
    end
end