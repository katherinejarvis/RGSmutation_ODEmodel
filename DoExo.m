%% Exocytosis
global reactCol

membraneProt = lastOde;     % The last ODE is now the protein in the membrane

%% Determine how many proteins synthesised/degraded since last exocytic event
    
    ste2syn=.0101*time*exodiff;                 %Synthesis of receptor
    betagammasyn=0.009*time*exodiff;            %Synthesis of BetaGamma
    gaDsyn=0.00386*time*exodiff;                %Synthesis of Galpha-GDP
    ste2deg=.00001*time*exodiff;                %Degradation of Receptor
    betagammadeg=0.000001*time*exodiff;         %Degradation of BetaGamma
    gaDdeg=0.000001*time*exodiff;               %Degradation of Galpha-D
    bynet=betagammasyn-betagammadeg;            %Net amount of BetaGamma
    gaDnet=gaDsyn-gaDdeg;                       %Net amount of Galpha-D
    gproteinnet=bynet;          %Amount of Gprotein (based on betagamma)
                    
% [Ste2(1),Ste2phe(2), GProtein(3), GProteinp(4),AlphaT(5), BetaGamma(6), AlphaD(7),RGS];
    golgi=[(ste2syn-ste2deg),0, gproteinnet,0,0,0, gaDnet,0];

%% Exocytosis 
 % Place holder for proteins to go from golgi -> membrane
tempExoComp = zeros(N,reactCol);

        %Normalize the Exocytosis gaussian with the scaling factor and baseline 
        %(in order to keep concentration of protein exocytosed consistant)
        Exonormalization=(exocytosispro*ExoShaped+ExoBaseline)./sum(exocytosispro*ExoShaped+ExoBaseline);
        
        %Multiply the distribution of exocytosis by golgi, the
        %concentration going into the membrane
        tempExoComp = (Exonormalization).*golgi;
        
       %Add distribution of protein from golgi to membrane
       membraneProt = membraneProt + tempExoComp;
%% Reconstruct lastODE

% Reassign the new membrane to last ODE
lastOde = membraneProt;
