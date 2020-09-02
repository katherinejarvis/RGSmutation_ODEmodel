%% Scripts to Alter RGS and Endocytic Rate by 10 fold

    % Clear the Workspace, command window and close all the figures
    clear
    clc
    close all

    % Set  up
    global N

    % Load k value parameters 
    Model_Setup    

%% Set it Up

    %Scale parameters of interest will change
    scalingfactor=[ 1/10 1 10];

    %Which parameter is WT
    normal=find(scalingfactor==1);
    
    %Allotting place to put legend information
    legendInfonormEndo(size(scalingfactor,2)+3)=strings;
    legendInfonormEndo(size(scalingfactor,2)+1:size(scalingfactor,2)+3)={'WT',...
        's539a','s539d'};
     legendInfonormRGS=legendInfonormEndo;
      
    %For Plotting x-axis
    windowsize = N;
    range = (windowsize-1)/2;
    distancerange=(-range * 0.1833):0.1833:(range*0.1833);
    
%% Figure for all 4 subplots

    %Plotting the Endo Exo Gaussian Distribution for WildType
    figure();
    subplot(2,2,1)
        plot(distancerange,endocytosispro,distancerange,exocytosispro)
        title('Endocytosis and Exocytosis Estimates')
        a=legend('Endocytosis Profile','Exocytosis Profile');
        a.Location='bestoutside';
        ylabel('Fraction')
        xlabel('Distance (um)')
     hold on


%% Fold Change: RGS

    %Save value of RGS originally
    OriginalRGS=RGSactivity;
    
    %Location to Save Results
    AllVariationsRGS_results=zeros(N,size(scalingfactor,2));
    AllVariationsRGS_norm=zeros(N,size(scalingfactor,2));

    %For each scaling factor
    for i=1:size(scalingfactor,2)
        
        %Change the RGS activity by the scaling factor
        RGSactivity=OriginalRGS*scalingfactor(i);
        
        %Run the Simulation with new activity level
        Model_Simulation
        
        %Get the mean results of the distribution of Galpha-GTP
        GaT_results=mean(squeeze(totResults(:,5,1:numtimept)),2);
        
        %Save the Results and normalized min subtracted results
        [AllVariationsRGS_results(:,i),AllVariationsRGS_norm(:,i)]=findingresults(GaT_results);
        
        %Save Legend Info for the figure
        legendInfonormRGS(i)=sprintf('RGS X %.1d', ...
            round(scalingfactor(i),1,'significant'));
    end

%%  %Print Figure for Fold Change of RGS's effect on the Galpha-GTP distribution
    subplot(2,2,2)
        plot(distancerange,AllVariationsRGS_norm(:,normal),'LineWidth',2,...
            'Color',[0.4940 0.1840 0.5560])
        hold on
        plot(distancerange,wtExpProfile,'k--',distancerange,...
              s539aExpProfile,'k:',distancerange,s539dExpProfile,'k-.')
        a=legend('WT Simulation','WT Data','s539a Data','s539d Data');
        a.Location='bestoutside';
        title('Simulation Fit to WT Data')
        ylabel('Fraction')
        xlabel('Distance (um)')
        
    %Print Figure for Fold Change of RGS's effect on the Galpha-GTP distribution
    subplot(2,2,3)
        plot(distancerange,AllVariationsRGS_norm(:,1:normal-1),'Color',...
            [0 0.88 1],'LineWidth',1)
        hold on
        plot(distancerange,AllVariationsRGS_norm(:,normal),'LineWidth',2,...
            'Color',[0.4940 0.1840 0.5560])
        hold on
        plot(distancerange,AllVariationsRGS_norm(:,normal+1:size(scalingfactor,2)),...
            'Color',[0 0.4470 0.7410],'LineWidth',1)
        title('RGS Fold Change: Total normalized AlphaT')
        hold on
        plot(distancerange,wtExpProfile,'k--',distancerange,...
            s539aExpProfile,'k:',distancerange,s539dExpProfile,'k-.')
        a=legend(legendInfonormRGS);
        a.Location='bestoutside';
        ylabel('Fraction')
        xlabel('Distance (um)')
        hold on

%     Resassign RGSactivity to what it was originally
    RGSactivity=OriginalRGS;    
 
%% Fold Change: Endocytosis Frequency

    %Save value of Endocytosis Frequency originally
    Originalendorate=endorate;
    
    %Location to Save Results
    AllVariationsendorate_results=zeros(N,size(scalingfactor,2));
    AllVariationsendorate_norm=zeros(N,size(scalingfactor,2));

    %For each scaling factor
    for i=1:size(scalingfactor,2)
        
        %Change the Endocytosis Frequency by the scaling factor
        endorate=Originalendorate*scalingfactor(i);
        
        %Run the Simulation with new activity level
        Model_Simulation
        
        %Get the mean results of the distribution of Galpha-GTP
        GaT_results=mean(squeeze(totResults(:,5,1:numtimept)),2);
        
        %Save the Results and normalized min subtracted results
        [AllVariationsendorate_results(:,i),AllVariationsendorate_norm(:,i)]=findingresults(GaT_results);
        
        %Save Legend Info for the figure
        legendInfonormEndo(i)=sprintf('Endo X %.1d', scalingfactor(i));
    end 

    %Print Figure for Fold Change of Endocytosis Frequency's effect 
    %on the Galpha-GTP distribution
    subplot(2,2,4)
        plot(distancerange,AllVariationsendorate_norm(:,1:normal-1),...
            'Color',[0 0.88 1],'LineWidth',1)
        hold on
        plot(distancerange,AllVariationsendorate_norm(:,normal),...
            'LineWidth',2,'Color',[0.4940 0.1840 0.5560])
        hold on
        plot(distancerange,AllVariationsendorate_norm(:,normal+1:size(scalingfactor,2)),...
            'Color',[0 0.4470 0.7410],'LineWidth',1)
        title('Endo Frequency Fold Change: Total normalized AlphaT')
        hold on
        plot(distancerange,wtExpProfile,'k--',distancerange,...
            s539aExpProfile,'k:',distancerange,s539dExpProfile,'k-.')
        a=legend(legendInfonormEndo);
        a.Location='bestoutside';
        ylabel('Fraction')
        xlabel('Distance (um)')
        set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
        
%     Resassign endorate to what it was originally
    endorate=Originalendorate; 
   