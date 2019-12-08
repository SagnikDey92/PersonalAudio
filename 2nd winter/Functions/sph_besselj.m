%%%%%%%%%%%%%%%%       JAI JAGANNATH      %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%        GYANAJYOTI        %%%%%%%%%%%%%%%%%%%%
function [B] = sph_besselj(n,x)
%SPH_BESSELJ Summary of this function goes here
%   This function finds the spherical besel function of first kind
%n: order of the bessel function
%x: input
%beselj gives the ordinary bessel coefficient of first kind
B=sqrt(pi./(2*x)) .* besselj(n+0.5,x);


end

