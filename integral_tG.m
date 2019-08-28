function [itG, error_itG] = integral_tG(N, km, H, Rm, rm, s)
%
% [ITG, ERROR_ITG] = INTEGRAL_TG(N, Q, kmD, kmd, s)
%
%   ITG is the integral t value, for the cut-off N. See manuscript of Gladys(2017).
%  
%   ERROR_ITG is the error from the numerical approxiamtion to ITG.
%
%   N is the cut off.
%
%   Q is the quotient between the inner and outer scales.
%
%   FN = km^2 L / 2k is the Fresnel number for the inner-scale frequency.
%
%   RM = km D /2 is the dimensionless entrance pupil
%
%   rm = km d is the dimensionless separation between dots in the array.
%
%   S is the layer position where IT is evaluated.
%   48 = 32.*gamma(2H+2) para H=1/3 -> gamma(8/3)=1.5 aprox.
%
%   1.50459 is the gamma function evaluated with H=1/3
%------------------------------------------------------------------------------------
%
n = length(s);
itG = zeros(n,1);error_itG = zeros(n,1);

for k=1:n
    if s(k) == 1
        itG(k)=0; error_itG(k)= 0;
    else
        et = @(x)((32*gamma(2.*H+2).*km.^(1-2.*H)./Rm.^2.*sin(pi.*H))...
            .*x.^(-8/3)...
            .*(besselj(1,s(k).*Rm.*x)).^2 ...
            .*(1-besselj(0,(1-s(k)).*rm.*x)));
    
        [itG(k),error_itG(k)]= quadgk(et,0,N,'RelTol',0,'AbsTol',1e-10,... 
            'MaxIntervalCount',10468);%1e-13
    end
end