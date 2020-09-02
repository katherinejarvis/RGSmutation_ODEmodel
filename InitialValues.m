% Diffusion
global eta
global reactCol

time=tspan(end);                        %sec per timepoint
totaltime=time*numtimept/60;            %total time of simulation in minutes

%% Diffusion Set up
eta=100;                    % eta: membrane/cytoplasm volume correction, Vm/Vc
Dc=10;                      % Diffusion coeff for cytosolic proteins
Dm=0.0025;                  % Diffusion coeff for membrane proteins

% Array of proteins, their order in the array and their locations
% (either membrane or cytosol)
% [Ste2(dm),Ste2phe(dm), GProtein(dm), GProteinp(dm),AlphaT,(dm) BetaGamma(dm), AlphaD(dm)];

dif=[Dm Dm Dm Dm Dm Dm Dm Dm];          % Diffusion constant for each protein
L=N*0.183;                              % length of each bin
fk=(2*pi/L)*[0:N/2 -ceil(N/2)+1:-1]';   
dF=exp(-dt*(fk.^2)*dif);                % Diffusion for each protein


%% Initalize Protein Concentrations
% Each protein is the inital concentration accross the membrane divided by
% the bin number

Ste2 =zeros(N,1);               % Receptor without Pheromone
Ste2phe =  22*ones(N,1)/N;      % Receptor with Pheromone
GProtein = zeros(N,1);          % GProtein-GDP
GProteinp = 14*ones(N,1)/N;     % GProtein-GTP
AlphaT = 14*ones(N,1)/N;        % Galpha-GTP
BetaGamma = 3.5*ones(N,1)/N;    % BetaGamma
AlphaD = zeros(N,1);            % Galpha-GDP
RGS=RGSactivity.*ones(N,1)/N;   % RGSactivity: initalized in parameters

% Initial concentrations of each protein in an array
y0 = [ Ste2, Ste2phe, GProtein, GProteinp,AlphaT, BetaGamma, AlphaD,RGS];

 % Initial values for the exocytosis
InitialVal = y0(1,:);

% Size of the inital concentrations Row and Column
[reactRow, reactCol] = size(y0);

%% Endo Exo Set up

                          %Initalizing
                          
endoComp=zeros(1,reactCol);     % Endocytic Compartment (housekeeping)
golgi=zeros(1,reactCol);        % Golgi (Exocytic Compartment)

const_endo=EndoShaped;          % Scaling factor multiply Endo profile by

          %Endocytosis profile scaling is dependant on the protein
          
ste2endo=const_endo;            % Receptor without Pheromone         
ste2pheendo=const_endo;         % Receptor with Pheromone
gproteinendo=const_endo;        % Gprotein-GDP
gproteinpendo=const_endo;       % Gprotein-GTP
alphaTendo=const_endo;          % Galpha-GTP
betagammaendo=const_endo;       % BetaGamma
alphaDendo=const_endo;          % Galpha-GDP
sst2endo=0;                     % RGS=> not endocytosed in this model

% Array of the proteins endocytosis scaling amount 
endoarray=[ste2endo,ste2pheendo,gproteinendo,...
    gproteinpendo,alphaTendo,betagammaendo,alphaDendo];

          % Determining Endocytosis/Exocytosis Event timing

% Number of times endo happens in 1 min*# of min=total amount time of endo
endotimepttotal=endorate*totaltime; 

% Determine which timepoints specifically endocytosis will happen
endotimept=floor(linspace(0,numtimept,endotimepttotal));

% Number of times exo happens in 1 min*# of min=total amount time of exo
exotimepttotal=exorate*totaltime; 

% Determine which timepoints specifically exocytosis will happen
exotimept=floor(linspace(0,numtimept,exotimepttotal));

%Number of timepoints between two exocytic events 
%(used to determine amount in the golgi)
exodiff=exotimept(2)-exotimept(1);
