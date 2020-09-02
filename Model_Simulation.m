%% Model Simulation
% Simulates the protein concentration and its changes of a yeast cell going
% through the pheromone response

global reactCol
global N

% Reaction
    % Time span for the integration
    tspan = [0 0.03 0.1];       
    dt=tspan(3); 
  
    % The experiment time - the number of time you are running ODE
     numtimept = 6000; 

    % Load the inital values of each protein    
    InitialValues  

    % The total results of the experiment below (for-loop)
    totResults = zeros(N,reactCol,numtimept);
    totOde  = zeros(N,reactCol,numtimept);
    
for n = 1:numtimept        
%%  ================= Reaction =================
        
        % Perform ODE solver based on the reaction in the time span based
        % on the protein concentration in the membrane
        [t,y] = ode23(@reactions,tspan,y0); 
      
        y= round(y,5);     %minimum molar is 0.01nm

        % Find the number of solution existed in y
        [row1,col1] = size(y);
        
        % Assign the last solution of the ODE45 to perform diffusion
        lastOde = reshape(y(row1,:),[N,reactCol]);

%%        ================== Endocytosis & Exocytosis ===================

            %If this is the timepoint which endocytosis should occur
            if any(n==endotimept)
                    DoEndo
            end
            %if this is the time point whihc exocytosis should occur
            if any(n==exotimept(:))
                DoExo
            end
            
%%         ================== Diffusion ===================
        % Reducing the frequency amplutide
        vv_ff= fft(lastOde);            % Fourier Transform the Membrane
        vv_nn= vv_ff.* dF;              % Add diffusion to ft membrane
        vv1 = real(ifft(vv_nn));        % Inverse ft the membrane
     
%%         ==============Initial variables value=============
        
        %Assign the diffused membrane as the inital value
         y0 = vv1;

        % Save in the total results
        totResults(:,:,n) = y0;
end
