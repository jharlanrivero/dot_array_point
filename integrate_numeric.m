function [int_horizontal, int_vertical] = integrate_numeric(q,k,L,H)
%% This is not a function.
% You did not use the examples I gave you to build the integrals.

% q = 0.045
% k = 5.6:0.25:49; %%kDm
% L = 1
% H = 0.5

% The three functions below are 1-dimensional functions, although other
% undefined parameters are given: s. 
% Where are the Bessel functions??
vertical = @(u) L.*s.*(u.*exp(-u.^2)./((q.^2 + u.^2).^(H+3/2))).*((0.18)./((1-s).*k).^2)
total = @(u) L.*s.*(u.*exp(-u.^2)./((q.^2 + u.^2).^(H+3/2))).*((0.504)./((1-s).*k).^2)
horizontal = @(u) L.*s.*((u.*exp(-u.^2)./((q.^2 + u.^2).^(H+3/2))).*((0.504)./((1-s).*k).^2)-(u.*exp(-u.^2)./((q.^2 + u.^2).^(H+3/2))).*((0.18)./((1-s).*k).^2))

smax = 1

v = integral2(vertical,2,inf,0,smax) %integral2 command is a two variable integral, but the functions only have one!
h = integral2(horizontal,3,inf,0,smax) %NUNERICAL INTEGRALS CANNOT be integrated to inf.!!

[v,errbnd] = integral2(fun_vertical,3,inf,0,smax,'RelTol',0,'AbsTol',1.e-10) %'fun_vertical' is not defined (!), also the integral gives v wichi is already a function.