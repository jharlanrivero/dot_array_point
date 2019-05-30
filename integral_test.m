%%
% This is for testing functions.
s = 0:.01:1;
y = 0:.01:1;
N = 3;
H=1/3;
kmd = [.01 .2 1 5 10];
M = length(kmd); S = length(s);
i1 = zeros(S,M);error_i1 = zeros(S,M);
it2 = zeros(1,M);
it = zeros(S,M);error_it = zeros(S,M);
% 
%%
for n = 1:length(kmd)
 
%n=2;
[i1(:,n), error_i1(:,n)] = integral_one(N, H,  .045, .055, 6, kmd(n), s);
[it(:,n), error_it(:,n)] = integral_t(N, H,  .045, .055, 6, kmd(n), s);
 
 
 end
%%
plot(s,i1,'*-',s,it,'+-')


%%
M = length(kmd);
kmd = (1:1000)'*0.01;
it2 = zeros(1,M);
 for n = 1:M
 
% [i12(:,n), error_i12(:,n)] = integral_one2(N, H, .045, .055, 6, kmd(n), s);
% n =2;
it2(n) = integral_one2(N, H,  .045, .055, 6, kmd(n));
 
 
 end
%%
plot(kmd,it2,'+-')