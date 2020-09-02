%% Endocytosis 
global reactCol

membraneProt = lastOde;             % The last ODE is now the protein in the membrane

%% Applying the scaling and baseline to the endocytosis distribution

%proteinendo is the percentage needed to be endocytosis for each protein
%at each bin in the membrane (N x reactCol)
proteinendo=endocytosispro.*endoarray+EndoBaseline;

%% Endocytosis 

% Place holder for proteins to go from membrane -> endo compartment
tempEndoComp = zeros(N,reactCol);

    %Multiply the distribution needed to be endocytosed by what is on the
    %membrane by component
    tempEndoComp(:,1:7)=(proteinendo).*membraneProt(:,1:7);

    % Put proteins from membrane that are endocytosed total into endo
    % compartment (housekeeping)
    endoComp = sum(tempEndoComp);
     
    % Remove tempEndo from membrane based on distribution from membraneProt
    membraneProt = membraneProt - tempEndoComp;
    
%% Reconstruct lastODE

% Reassign the new updated membrane to lastODE
lastOde = membraneProt;
