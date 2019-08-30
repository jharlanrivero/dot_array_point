function i12 = integral1T(f1t,glz,Fn, Rm, deltam, gammas, errorb, H, q,c2n)
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
      if deltam(k)==1
          i12(k)=0;
%             i12(k)=0; error_i12(k)= 0;
      else
          
           dim = size(c2n);
           if dim(1) == 1
               fun1 = @(x)(c2nprofile(x,c2n).*ione2(f1t,glz,Fn, Rm, deltam(k), gammas, errorb, H, q, x));
           else
               fun1 = @(x)(c2nprofile(x,c2n(1,:),c2n(2,:)).*ione2(f1t,glz,Fn, Rm, deltam(k), gammas, errorb, H, q, x));
           end
           
           i12(k) = integral(fun1,0,1,'RelTol',0,'AbsTol',errorb);
      end    
end
  
function I = ione2(f1t,glz,Fn, Rm, deltam, gammas, errorb, H, q, s)

    if f1t==1
         [I, ~] = weight_integral_1(glz,Fn, Rm, deltam, gammas, errorb, H, q, s);   
    else
         [I, ~] = weight_integral_t(glz,Fn, Rm, deltam, gammas, errorb, H, q, s);
    end
         I = I';
end
end
