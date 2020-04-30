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
<<<<<<< HEAD
%% Parameters for the lab
c2nlab = 5E-8;
qlab = .008/.13;
Rmlab = 2*pi*.025/.008;
deltamlab=2*pi*.0014/.008;
Fmlab = pi*625E-9*.37/0.008^2;


%% Parameters for the dome (supposing measuring with Szymon device
% 10 LEDS spread 5 cm each gives a deltamax 
%deltamdomemax = 2*pi*.5/.008;
%deltamdome=2*pi*.05/.008;
% is the minimum separation
qdome = .005; qdomemin = .008/8;
%
Rmdome = 45.5;
% supposing this turbulence.
c2ndome = 1E-11;
% and Fresnel number.
Fmdome = 0.46;
%%
deltam = deltamlab:.5:(deltamlab*10);
L = 10;
km = 0.01;
%% 
%figure;
var1parglz = variance_constant(H,L,Rmdome,km,qdome).*...
    integral1T(1,1,qdome^2*Fmdome, qdome*Rmdome, qdome*deltam, 'divergent', errorb, H, qdome,c2ndome);
var2parglz = variance_constant(H,L,Rmdome,km,qdome).*...
    integral1T(2,1,qdome^2*Fmdome, qdome*Rmdome, qdome*deltam, 'divergent', errorb, H, qdome,c2ndome);
%
var1parint = variance_constant(H,L,Rmdome,km).*...
    integral1T(1,2,Fmdome, Rmdome, deltam, 'divergent', errorb, H, qdome,c2ndome);
var2parint = variance_constant(H,L,Rmdome,km).*...
    integral1T(2,2,Fmdome, Rmdome, deltam, 'divergent', errorb, H, qdome,c2ndome);
%
figure;
plot(deltam,100*(var1parglz-var1parint)./var1parglz,'k-',deltam,100*((var2parglz-var1parglz)-(var2parint-var1parint))./(var2parglz-var1parglz),'c-');

%% Parameters for the dome (supposing measuring with Szymon device
% 10 LEDS spread 5 cm each gives a deltamax 
%deltamdomemax = 2*pi*.5/.008;
%deltamdome=2*pi*.05/.008;
% is the minimum separation
qdome = 0.8/13;
%
Rmdome = 45.5;
% supposing this turbulence.
c2ndome = 1E-11;
% and Fresnel number.
Fmdome = 0.46;
%%
deltam = 15.7:20:196;
L = 10;
km = 0.008;
%% 
%figure;
var1parglz = variance_constant(H,L,Rmlab,km,qlab).*...
    integral1T(1,1,qlab^2*Fmlab, qlab*Rmlab, qlab*deltam, 'divergent', errorb, H, qlab,c2nlab);
var2parglz = variance_constant(H,L,Rmlab,km,qlab).*...
    integral1T(2,1,qlab^2*Fmlab, qlab*Rmlab, qlab*deltam, 'divergent', errorb, H, qlab,c2nlab);
%
var1parint = variance_constant(H,L,Rmlab,km).*...
    integral1T(1,2,Fmlab, Rmlab, deltam, 'divergent', errorb, H, qlab,c2nlab);
var2parint = variance_constant(H,L,Rmlab,km).*...
    integral1T(2,2,Fmlab, Rmlab, deltam, 'divergent', errorb, H, qlab,c2nlab);
%
%figure;
plot(deltam,var1parint,'b-',deltam,var1parglz,'k-',deltam,(var2parint-var1parint),'r-',deltam,(var2parglz-var1parglz),'g-');
 %%
figure;
plot(deltam,100*(var1parglz-var1parint)./var1parglz,'k-',deltam,100*((var2parglz-var1parglz)-(var2parint-var1parint))./(var2parglz-var1parglz),'c-');
    

%% Resolution
Rm =16;
L=8;
deltam0=16; pixel=5.5E-3;focal=300;km0=2*pi/.008;

min_separation = 1.22*625E-9/(2*Rm/km0),
target_separation = deltam0/L/km0,
sys_separation = pixel/focal,
=======
%% Parameters for the lab.
Fmlab = pi*625E-9*.37/0.008^2;
deltamlab=2*pi*.002/.008;
qlab = .008/.13;
Rmlab = 2*pi*.01/.008;
kmlab = 2*pi/.008;
H = 1/3;

% Parameter for dome
Fmdome = pi*625E-9*8/0.008^2;
qdome = .008/2;
Rmdome = 2*pi*.05/.008;
deltamdome=2*pi*.02/.008;
>>>>>>> master
