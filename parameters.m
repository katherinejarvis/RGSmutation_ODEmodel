%% Parameters of Endo/Exo and Reaction Rates
%Initialize rates, Gaussian profile, baseline, and scaling factors of the
%endo/exo profiles used in DoEndo and DoExo. Also this is where the
%reaction rates are initialized used in @reactions

%% Endo/Exo Infomation
%Frequencies of Endo/Exo Events Per Minute
endorate=96;
exorate=24;

%Scales the Gaussian Endocytic Profile
EndoShaped=WTbestfitparameters(1);

%Increases Endocytic Profile Baseline
EndoBaseline=WTbestfitparameters(2);

%Scales the Gaussian Exocytic Profile
ExoShaped=WTbestfitparameters(3);

%Increases Exocytic Profile Baseline
ExoBaseline=WTbestfitparameters(4);

%Gaussian Profiles of Endo/Exo Profiles
endocytosispro=transpose(WTbestfitendoexoGaus(1,1:N));
exocytosispro=transpose(WTbestfitendoexoGaus(2,1:N));

%% Reaction Rates
global k

k1=5.6;
% k1r=k1*0.007;
k2=3.3;
% k2r=k2/33;
k3=10;
k3r=.01;
k4=2;
% k4r=k2;   %.3*k7g;
k5=32;
% k5r=k5/1000;

%Struct of all of the reaction rates to be used in @reactions
k=struct('k1',k1,'k1r',k1*0.007,'k2',k2,'k2r',k2/33,'k3',k3,...
    'k3r',k3r,'k4',k4,'k4r',k2,'k5',k5,'k5r', k5/1000);

%% RGS

%Initalize RGS activity level to be used in InitialValues
RGSactivity=7.8;
