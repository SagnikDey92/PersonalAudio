%%%%%%%%%%%%%%%%       JAI JAGANNATH      %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%        GYANAJYOTI        %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%Finding R of specific order and kr value
function [ R ] = R_n_kr(n, k, x )
%R_N_KR =-ikre^(ikr) i^(-n) h_n(kr)
%   n=order
%   k: wave number
%   x: observation point

R= -i*k*x*exp(i*k*x) *i^(-n)*sph_hankel2(k*x,n);


end

