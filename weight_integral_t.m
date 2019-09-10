function [it, error_it] = weight_integral_t(glz,Fn, Rm, deltam, gammas, errorb, H, q, s)
%
% [IT, ERROR_IT] = WEIGHT_INTEGRAL_T(FN, RM, DELTAM, GAMMAS, ERRORB, H, Q, S)
%
%   IT is the integral t value, for the cut-off N. See manuscript.
%  
%   ERROR_IT is the error from the numerical approxiamtion to IT.
%
%   N is the cut off.
%
%   Q is the quotient between the inner and outer scales.
%
%   Fm = km^2 L / 2k is the Fresnel number for the inner-scale frequency.
%
%   Rm = km D /2 is the dimensionless entrance pupil
%
%   deltam = km d is the dimensionless separation between dots in the array.
%
%   S is the layer position where IT is evaluated.
%

n = length(s);
it = zeros(n,1);error_it = zeros(n,1);

for k=1:n
    if gammas(k) == 1
        it(k)=0; error_it(k)= 0;%error_it2(k)= 0;
    else
        et = @(x)(x.*Phin(glz,q,H,x).*cos(gammas(k).*s(k).*x.^2.*Fn).^2 ...
            .*(besselj(1,gammas(k).*Rm.*x)).^2 ...
            .*(1-besselj(0,(1-gammas(k)).*deltam.*x)));
    
        [it(k),error_it(k)]= quadgk(et,0,Inf,'RelTol',0,'AbsTol',errorb,... 
            'MaxIntervalCount',16468);%1e-13
        
        %f1t=0;glz=0;
        %error_it2(k) = errorbound1T(f1t,glz,H,errorb);
    
    end
end

 function phi = Phin(glz,q,H,x)
        
        if glz==1
            phi = 1./(x.^2+q.^2).^(H+3/2);    
        else
            phi = exp(-1*x.^2)./(x.^2+q^2).^(H+3/2);
        end
        
    end

end