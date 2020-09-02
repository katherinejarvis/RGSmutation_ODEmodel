%% Pheromone
global phe

% Pheromone - normal dist
if mod(N,2)==0 %if N is an even number
    meanN = N/2;
    pp = 0:1:meanN-1;
    pp1 = meanN-1:-1:0;
else %if N is an odd number
    meanN = floor(N/2);
    pp = 0:1:meanN;
    pp1 = meanN-1:-1:0;
end 
p = [pp pp1]; %paste both sides of the peak pheromone together
phe = 0.007*p'/max(p)+.002; %Max 0.009 at bin #32 and min 0.002 at bin #1 and #63