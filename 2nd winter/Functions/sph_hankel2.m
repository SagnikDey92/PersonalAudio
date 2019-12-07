%%%%%%%%%%%%%%%%       JAI JAGANNATH      %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%        GYANAJYOTI        %%%%%%%%%%%%%%%%%%%%
%%% Spherical Harmonic Hankel Function of Seconf Kind

function [ h] = sph_hankel2(n,x)
%SPH_HANKEL2 : Spherical Hankel function of second kind
%   x: input for which we find the spherical Hankel function value
%   n: order of the function

h=sqrt(pi./(2*x)).*(besselj(n+0.5,x)-i*bessely(n+0.5,x));


end

