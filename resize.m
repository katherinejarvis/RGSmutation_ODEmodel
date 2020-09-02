function [output]=resize(membrane,membranegoal)
    lenmem=size(membrane,1); %find size of og membrane
%     membranegoal=(lenmem-delete); %finallength=goal
    membrane1=zeros(lenmem*membranegoal,1); %64*60 %each bin is divided into 60 parts
    index=zeros(lenmem,1); %

    for i=1:length(membrane)
        index(i)=membranegoal*(i-1)+1; %1:63 then 64:
        %First bin is divided by 60 and put into 1:63
        membrane1(index(i):index(i)+membranegoal-1)=membrane(i)./membranegoal*ones(membranegoal,1); 
    end

    membrane2=zeros(membranegoal,1);

    for i=1:membranegoal
        index1=lenmem*(i-1)+1;
        index2=index1+lenmem-1;
        membrane2(i)=sum(membrane1(index1:index2));%Take what is in the appropriate
    end
    
    output=membrane2;
end