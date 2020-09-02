function [results,norm]=findingresults(GaT_results)
%Function to save both the normal results and normalized min subtracted
%results
    results(:)=GaT_results(:);
    GaT_min=min(GaT_results);
    GaT_results=GaT_results-GaT_min;
    GaT_norm=GaT_results/sum(GaT_results);
    norm=GaT_norm(:);
end
 
