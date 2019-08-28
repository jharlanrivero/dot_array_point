function i12 = integral_one2(N, km, H, q, fn, Rm, rm)
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
%
%i12 = zeros(n,1);%error_i12 = zeros(n,1);

n = length(rm);
i12 = zeros(n,1);
    
    

for k=1:n
      if rm(k)==1
          i12(k)=0;
%             i12(k)=0; error_i12(k)= 0;
      else
           fun1 = @(x)(ione2(N, km, H, q, fn, Rm, rm(k), x));
           i12(k) = integral(fun1,0,1)

      end    
end
  
function I = ione2(N, km, H, q, fn, Rm, rm, s)
 
         [I, ~] = integral_one(N, km, H, q, fn, Rm, rm, s);   
         
         I = I';
end

plot(rm, i12,'+-')
end
