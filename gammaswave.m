function gammas = gammaswave(type, s)
%
%
%   gammas = gammaswave(type,s)
%
%
%
%
%
%
%
%
n= length(s);
switch type
    case 'plane' 
        gammas = ones(1,n);
    case 'divergent'
        gammas = s;
    otherwise
        gammas = 1-s;
end
