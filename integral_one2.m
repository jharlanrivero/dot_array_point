function i12 = integral_one2(N, H, q, fn, kmpup, kmdot)
%
% [I1, ERROR_I1] = INTEGRAL_ONE(N, Q, FN, KMPUP, KMDOT, S)
%
%   I1 integrate in s, for the cut-off N. See manuscript.
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
    fun1 = @(y)(eone(N, H, q, fn, kmpup, kmdot, y));
    i12= integral(fun1,0,1,'RelTol',0,'AbsTol',1e-10);%1e-13

function I = eone(N, H, q, fn, kmpup, kmdot, y)
 
         [I, ~] = integral_one(N, H, q, fn, kmpup, kmdot, y);   
         
         I = I';
end

end