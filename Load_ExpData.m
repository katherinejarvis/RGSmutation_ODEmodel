%% Load the Experimental Profiles 

%load experimental results WT, s539d, s539a Galpha-GTP
load('MAPKnorm.mat')

% Results of best fit GaT distribution from Monte Carlo
load('WTBestFitEndoExoGaus63.mat') %Endo/Exo Gaussian Distributions N=63
load('WTbestfitparameters.mat') %Parameters (endo/exo scaling and baseline)

%% Experimental Data Average and Normalize
%Used in the end to compare Simulation Galpha-GTP distribution 
%The following are MAPK normalized fluorecense data which is then resize to
%the correct membrane length (N), center the data, average, subtract
%minimum and renormalize. This process is done for wildtype data and mutant
%data (s539d and s539a).

%WildType
wtprofile=resize(MAPKwtnorm,N);                         %Resize to correct length
wtflip=flipud(wtprofile);                               %flip the profile
maxwtflip=find(wtflip(:)==max(wtflip(:)));              %find peak MAPK
wtflip=circshift(wtflip,ceil(N/2)-maxwtflip);           %center the data
wtExpProfile=wtprofile;                                 %The following is averaging
wtExpProfile(1:ceil(N/2)-1)=(wtflip(1:ceil(N/2)-1)+wtprofile(1:ceil(N/2)-1))/2;
wtExpProfile(ceil(N/2)+1:N)=(wtflip(ceil(N/2)+1:N)+wtprofile(ceil(N/2)+1:N))/2;
wtExpProfile=wtExpProfile-min(wtExpProfile);            %subtract minimum
wtExpProfile=wtExpProfile/sum(wtExpProfile);            %renormalize

%s539a
s539a=resize(MAPKs539anorm,N);                          %Resize to correct length
s539aflip=flip(s539a);                                  %flip the profile
maxs539aflip=find(s539aflip(:)==max(s539aflip(:)));     %find peak MAPK
s539aflip=circshift(s539aflip,ceil(N/2)-maxs539aflip);  %center the data
s539aExpProfile=s539a;                                  %The following is averaging
s539aExpProfile(1:ceil(N/2)-1)=(s539aflip(1:ceil(N/2)-1)+s539a(1:ceil(N/2)-1))/2;
s539aExpProfile(ceil(N/2)+1:N)=(s539aflip(ceil(N/2)+1:N)+s539a(ceil(N/2)+1:N))/2;
s539aExpProfile=s539aExpProfile-min(s539aExpProfile);   %subtract minimum
s539aExpProfile=s539aExpProfile/sum(s539aExpProfile);   %renormalize

%s539d
s539d=resize(MAPKs539dnorm,N);                          %Resize to correct length
s539dflip=flip(s539d);                                  %flip the profile
maxs539dflip=find(s539dflip(:)==max(s539dflip(:)));     %find peak MAPK
s539dflip=circshift(s539dflip,ceil(N/2)-maxs539dflip);  %center the data
s539dExpProfile=s539d;                                  %The following is averaging
s539dExpProfile(1:ceil(N/2)-1)=(s539dflip(1:ceil(N/2)-1)+s539d(1:ceil(N/2)-1))/2;
s539dExpProfile(ceil(N/2)+1:N)=(s539dflip(ceil(N/2)+1:N)+s539d(ceil(N/2)+1:N))/2;
s539dExpProfile=s539dExpProfile-min(s539dExpProfile);   %subtract minimum
s539dExpProfile=s539dExpProfile/sum(s539dExpProfile);   %renormalize