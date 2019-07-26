function [i1, error_i1] = integral_one(N, km, H, q, fn, Rm, rm, s)
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
n = length(s);
i1 = zeros(n,1);error_i1 = zeros(n,1);


for k=1:n
        if s(k) == 1
            i1(k)=0; error_i1(k)= 0;
        else
            eone = @(x)((32*1.50459.*km.^(1-2.*H)./Rm.^2.*sin(pi.*H)).*x.*exp(-1*x.^2)./(x.^2+q^2).^(H+3/2).*cos((1-s(k)).^2.*x.^2.*fn).^2 ...
                .*(besselj(1,(1-s(k)).*Rm.*x)).^2 ...
                .*(1/2-besselj(1,(1-s(k)).*rm.*x)./((1-s(k)).*rm.*x)));
        
            [i1(k),error_i1(k)]= quadgk(eone,0,N,'RelTol',0,'AbsTol',1e-10,... 
                'MaxIntervalCount',10468);%1e-13
        end
end
