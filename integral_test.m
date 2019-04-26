% This is for testing functions.
s = 0:.02:1;
N = 3;
H=1/3;

[i1, error_i1] = integral_one(N,H, .045, .055, 6, 40, s);
[it, error_it] = integral_t(N, H,  .045, .055, 6, 40, s);
%%
s = 0:.02:1;
N = 3;
H=1/3;

[i12, error_i12] = integral_one2(N,H, .045, .055, 6, 40, s);
[it2, error_it2] = integral_t2(N, H,  .045, .055, 6, 40, s);

%%
subplot(2,1,1);
plot(s,i1,'*-',s,it,'+-')

subplot(2,1,2);  
plot(s,i12,'c-',s,it2,'>-')

