%% Scales for outdoor experiments
s = 0:.01:1;
H=1/3; %Kolmogorov case.
gammas= gammaswave('divergent',s);
errorb= .0000001;
% Generalized parameters outdoors
% Inner scale is 5 millimiters
Rm= 2*pi*.1/.005;
q = 0.00866;
deltam = .05*2*pi/.005;
% Gladysz parameters outdoors
% [it, error_it] = weight_integral_t(glz,Fn, Rm, deltam, gammas, errorb, H, q, s)
Fn=.0055;
R0 = Rm*q ;
delta0 = deltam*q;
q0 =1;
%% integral comparison
[it_glz, error_glz] = weight_integral_t(1,Fn, R0, delta0, gammas, errorb, H, q0, s);
[it_ok, error_ok] = weight_integral_t(1,Fn, R0, delta0, gammas, errorb, H, 0, s);
[it_gen, error_gen] = weight_integral_t(0,Fn, Rm, deltam, gammas, errorb, H, q, s);

%%
f1 = figure;
plot(s,q^(-2*H-1)*it_glz,'r-'); 
hold on;

plot(s,it_gen,'b-');

plot(s,q^(-2*H-1)*it_ok,'g-');

%%
figure;plot(s,q^(-2*H-1)*it_glz./it_gen);
%% Indoors
% Generalized parameters 
Rm1= 2*pi*.1/.005;
q1 = 0.001;
deltam1 = .0005*2*pi/.005;
% Gladysz parameters 
% [it, error_it] = weight_integral_t(glz,Fn, Rm, deltam, gammas, errorb, H, q, s)
Fn=.0055;
R01 = Rm1*q1 ;
delta01 = deltam1*q1;
q0 =1;

%%
[it_glz1, error_glz1] = weight_integral_t(1,Fn, R01, delta01, gammas, errorb.^2, H, q0, s);
[it_ok1, error_ok1] = weight_integral_t(1,Fn, R01, delta01, gammas, errorb.^2, H, 0, s);
[it_gen1, error_gen1] = weight_integral_t(0,Fn, Rm1, deltam1, gammas, errorb, H, q1, s);
%%
figure,
plot(s,q1^(-2*H-1)*it_glz1,'r-'); 
hold on;

plot(s,it_gen1,'b-');

plot(s,q1^(-2*H-1)*it_ok1,'g-');
%% Parameters for the lab
c2nlab = 5E-8;
qlab = .008/.13;
Rmlab = 2*pi*.01/.008;
deltamlab=2*pi*.002/.008;
Fmlab = pi*625E-9*.37/0.008^2;


% Parameters for the dome
c2ndome = 1E-11;
qdome = .008/2;
deltamdome=2*pi*.02/.008;
Fmdome = pi*625E-9*8/0.008^2;
Rmdome = 2*pi*.05/.008;

%%
varparglz = variance_constant(H,8,Rmdome,2*pi/.008,qdome).*...
    integral1T(1,1,qdome^2*Fmdome, qdome*Rmdome, qdome*deltamdome, 'divergent', errorb, H, qdome,c2ndome);
%