function N = errorbound1T(f1t,glz,H,errbound)
% 
%   N = ERRORBOUND1T(F1T,GLZ,H,ERRBOUND)
%
%   N is the upper limit of the finite integrals replacing the 0 to
%   infinity exact ones.
%
%   F1T is 1 for F_1 and F_t otherwise. 
% 
%   GLZ is 1 for the Gladysz bound, and any other value our approach.
% 
%   H is the Hurst exponent.
%
%   ERRBOUND is the expected error.
%
if f1t==1
    maxf1t = 0.5661397436980502;
else
    maxf1t = 1.402759395702553;
end

if glz ==1
    
    N = (3*maxf1t/(5*(2*H+1)*errbound))^(1/(2*H+1));
    N = ceil(N);
    
else
    
    bfun = @(x) log(3*maxf1t/(10*errbound))-x^2-(2*H+3)*x;  % parameterized function
    N = fzero(bfun,1);
    N = ceil(N);
    
end


