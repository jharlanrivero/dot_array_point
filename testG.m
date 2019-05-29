%%
% This is for testing functions.
s = 0:.01:1;
y = 0:.01:1;
N = 3;
H=1/3;
d = [.01 .2 1 5 10];
M = length(d); S = length(s);
i1 = zeros(S,M);error_i1 = zeros(S,M);
it2 = zeros(1,M);
it = zeros(S,M);error_it = zeros(S,M);
% 
%%
for n = 1:length(d)
 

[i1G(:,n), error_i1G(:,n)] = integral_oneG(N, 2, 1, d(n), s);
[itG(:,n), error_itG(:,n)] = integral_tG(N, 2, 1, d(n), s);
 
 
 end
%%
plot(s,i1G,'*-',s,itG,'+-')

%%
M = length(d);
d = (1:1000)'*0.01;
itG2 = zeros(1,M);
 for n = 1:M
 

itG2(n) = integral_oneG2(N, 1, 1, d(n));
 
 
 end
%%
plot(d,itG2,'+-')