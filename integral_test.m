% This is for testing functions.
s = 0:.01:1;
N = 3;
H=1/3;

kmd = [.01 .2 1 5 10 20 40];
M = length(kmd); S = length(s);
i1 = zeros(S,M);error_i1 = zeros(S,M);
it = zeros(S,M);error_it = zeros(S,M);

for n = 1:M

[i1(:,n), error_i1(:,n)] = integral_one(N,H, .045, .055, 6, kmd(n), s);
[it(:,n), error_it(:,n)] = integral_t(N, H,  .045, .055, 6, kmd(n), s);


end
%%
i1 = kmd.^(-2*H+1).*i1;it = kmd.^(-2*H+1).*it;
plot(s,i1,'*-')

%%
figure;plot(s,it,'o-')
%%
[tiltx, tilty]=tptiltvariances(N,H, .045, .055, 6, kmd(7));
