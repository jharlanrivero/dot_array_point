q = 0.045
k = 5.6:0.25:49; %%kDm
L = 1
H = 0.5

vertical = @(u) L.*s.*(u.*exp(-u.^2)./((q.^2 + u.^2).^(H+3/2))).*((0.18)./((1-s).*k).^2)
total = @(u) L.*s.*(u.*exp(-u.^2)./((q.^2 + u.^2).^(H+3/2))).*((0.504)./((1-s).*k).^2)
horizontal = @(u) L.*s.*((u.*exp(-u.^2)./((q.^2 + u.^2).^(H+3/2))).*((0.504)./((1-s).*k).^2)-(u.*exp(-u.^2)./((q.^2 + u.^2).^(H+3/2))).*((0.18)./((1-s).*k).^2))

smax = 1

v = integral2(vertical,2,inf,0,smax)
h = integral2(horizontal,3,inf,0,smax)

[v,errbnd] = integral2(fun_vertical,3,inf,0,smax,'RelTol',0,'AbsTol',1.e-10)