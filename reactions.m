function dydt = reactions(t,y)


% The ODEs below were 'derived' from the diagram in Meng's paper.
global reactCol
global phe
% global BemExp_norm

global k
global N

% Organize y
y = reshape(y,[N,reactCol]);

%% the reactions
dydt = zeros(N,reactCol); 


% Ste2 -> y(:,1)
dydt(:,1) = -k.k1*y(:,1).*phe + k.k1r*y(:,2);

% ste2p-> y(:,2)
dydt(:,2) = k.k1*y(:,1).*phe - k.k1r*y(:,2);

% GProtein -> y(:,3)
dydt(:,3) = -k.k2*y(:,3).*y(:,2) + k.k2r*y(:,4) + k.k5*y(:,6).*y(:,7) - k.k5r*y(:,3);

% GProteinp -> y(:,4)
dydt(:,4) = k.k2*y(:,3).*y(:,2) - k.k2r*y(:,4) + k.k3r*y(:,5).*y(:,6)- k.k3*y(:,4);

% AlphaT -> y(:,5)
% dydt(:,5) = k(3).*y(:,4) - k(5).*y(:,5).*y(:,6) - k(5).*RGS.*y(:,5) + 3.22*k(5).*y(:,2).*y(:,7) ;
dydt(:,5) = k.k3*y(:,4)  -k.k3r*y(:,5).*y(:,6) - k.k4*y(:,8).*y(:,5) + k.k4r*y(:,2).*y(:,7);

% BetaGamma -> y(:,6)
dydt(:,6) = k.k3*y(:,4) - k.k3r*y(:,5).*y(:,6) - k.k5*y(:,6).*y(:,7) + k.k5r*y(:,3);

% AlphaD -> y(:,7)
dydt(:,7) = k.k4*y(:,8).*y(:,5) - k.k4r*y(:,2).*y(:,7) - k.k5*y(:,6).*y(:,7) + k.k5r*y(:,3);

dydt(:,8)=0;

% Reshape it to a column vector
totCol = N*reactCol;
dydt = reshape(dydt,[totCol,1]);

end
