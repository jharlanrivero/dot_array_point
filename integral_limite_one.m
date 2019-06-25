function [i1l, error_i1l] = integral_limite_one(N, H, q, kmpup, kmdot, s)
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
%----------------------------------------------------------------------------
% con km -> infy / exp[-(k/km)^2] = 1, con  Cos = 1 una aproximacion dada
% por gladys.
% luego de esto hacemos el cambio de variable de k = km.*u


n = length(s);
i1l = zeros(n,1);error_i1l = zeros(n,1);

for k=1:n
        if s(k) == 1
            i1l(k)=0; error_i1l(k)= 0;
        else
            eone = @(x)((x.^2+q^2).^(-H-3/2)...
                .*(besselj(1,(1-s(k)).*kmpup.*x/2)./((1-s(k)).*kmpup)).^2 ...
                .*(1/2-besselj(1,(1-s(k)).*kmdot.*x)./((1-s(k)).*kmdot.*x)));
        
            [i1l(k),error_i1l(k)]= quadgk(eone,0,N,'RelTol',0,'AbsTol',1e-10,... 
                'MaxIntervalCount',10468);%1e-13
        end
end
