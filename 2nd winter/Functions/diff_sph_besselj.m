function [ j_d ] = diff_sph_besselj( n,x )
%DIFF_SPH_BESSELJ Summary of this function goes here
%   Derivative of spherical bessel funtion of first kind order n
%   j_d(n,x)=j(n-1,x)-((n+1)/x) j(n,x)
%   n: order; x: input

    j = sph_besselj(n,x);
    j_d = sph_besselj(n-1,x)-((n+1)./x).*j;

end

