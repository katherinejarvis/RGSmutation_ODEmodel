# RGSmutation_ODEmodel

Welcome to the Model 

These scripts uses ODE and enzyme kinetics to simulate a yeast cell 
going through the pheromone response. 

START: FoldChange_MainDriver.m
   
    This script will set up the simulations and cause a change to the
the RGS activity and then the Endocytosis frequency.
    The fold change amount can be changed by altering the array 
'scalingfactor' please ensure there are values <1, =1 and >1 in order for 
errors to not occur in the code.
    
    This script will print out one full screen figure of 4 subplots,
        1) The endocytosis and exocytosis gaussian profiles
        2) WT and Mutant GalphaT profiles along with the wildtype the 
        simulation produces
        3) GaT Average Profile of varying RGS Activity 
        (of each scaling factor) compared to the mutants
        4) GaT Average Profile of varying Endocytosis Frequency
        (of each scaling factor) compared to the mutants


Thank you!
