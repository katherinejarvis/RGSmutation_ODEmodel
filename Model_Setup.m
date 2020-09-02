%% Setup Basics of the Simulation
% Loads experimental data, parameters (k values) and Pheromone                 

N=63; %Length of membrane=bin number

%% Load Experimental Data
Load_ExpData

%% Calculating the required bin number from the window size in um
% Number of bin... 64 bin * 183nm = 11712 nm*bin
% so 11712nm * bin / 404bin = 29 nm (0.029um)
umPin = 0.183*64;    % um*pin
newUm = umPin/N;    % um for each pin

%% Pheromone acting on the membrane
Pheromone

%% Equation's parameters            
parameters