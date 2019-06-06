function i1G2 = integral_oneG2(N, kmpup, kmdot)
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
%
    fun2 = @(y)(ione2(N, kmpup, kmdot, y));
    i1G2= integral(fun2,0,1,'RelTol',0,'AbsTol',1e-10);%1e-13

function I = ione2(N, kmpup, kmdot, y)
 
         [I, ~] = integral_oneG(N, kmpup, kmdot, y);   
         
         I = I';
end

end