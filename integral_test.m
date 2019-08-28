%%
% This is for testing functions.
s = 0:.01:1;
y = 0:.01:1;
N = 3;
H=1/3;
%rm = [.01 .2 1 5 10];
rm = [0 10 20 30 40 50];
M = length(rm); S = length(s);
%i12 = zeros(S,M);error_i1 = zeros(S,M);
%it2 = zeros(1,M);
it = zeros(S,M);error_it = zeros(S,M);
km = 1; %Cn2(H)
% 
%%
for n = 1:length(rm)
 
%n=2;
[i1(:,n), error_i1(:,n)] = integral_one(N, km, H, .045, .055, 3, rm(n), s);
[it(:,n), error_it(:,n)] = integral_t(N, km, H, .045, .055, 3, rm(n), s);
 
 
 end
%%
%%plot(s,i1(:,100),'*-',s,it(:,100),'+-')
plot(s,i1,'*-',s,it,'+-')
%%

%rm = (1:1000)'*0.01;
%M = length(rm);
%i12 = zeros(1,M);
% for n = 1:M
 
i12 = integral_one2(N, km, H, .045, .055, 3, rm);
it2 = integral_t2(N, km, H, .045, .055, 3, rm);
 
 
% end
