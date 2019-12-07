function [ h_d ] = diff_sph_hankel2( n,x )
%DIFF_SPH_HANKEL2 Summary of this function goes here
%   Detailed explanation goes here
%   Derivative of spherical hankel funtion of second kind order n
%   h_d(n,x)=h(n-1,x)-((n+1)/x) h(n,x)
%   n: order; x: input

    h = sph_hankel2(n,x);
    h_d = sph_hankel2(n-1,x)-((n+1)./x).*h;

end

