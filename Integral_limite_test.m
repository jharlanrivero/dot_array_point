%%
% This is for testing functions.
s = 0:.01:1;
y = 0:.01:1;
N = 3;
H=1/3;
d = [.01 .2 1 5 10];

kmd = [.01 .2 1 5 10];

% 
%%
for n = 1:length(d)
 

[i1G(:,n), error_i1G(:,n)] = integral_oneG(N, 0.45, 6, d(n), s);
[itG(:,n), error_itG(:,n)] = integral_tG(N, 0.45, 6, d(n), s);

end

for n = 1:length(kmd)
 
%n=2;
[i1l(:,n), error_i1l(:,n)] = integral_limite_one(N, H,  .045, 6, kmd(n), s);
[itl(:,n), error_itl(:,n)] = integral_limite_t(N, H,  .045, 6, kmd(n), s);
 
end

m1 = [i1G(:,n), error_i1G(:,n)] /[i1l(:,n), error_i1l(:,n)]

mT = [itG(:,n), error_itG(:,n)] / [itl(:,n), error_itl(:,n)]

%%
plot(s,m1,'*-',s,mT,'->')