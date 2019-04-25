% This is for testing functions.
s = 0:.02:1;
N = 3;
H=1/3;

[i1, error_i1] = integral_one(N,H, .045, .055, 6, 40, s);
[it, error_it] = integral_t(N, H,  .045, .055, 6, 40, s);

%%
plot(s,i1,'*-',s,it,'+-')