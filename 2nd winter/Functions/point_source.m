function [ S ] = point_source( x, y, x_s, y_s, z_s, k )
%function [ S ] = point_source( x, y, x_s, y_s, z_s, k )
%
% calculates the sound field at the grid points given by x and y with z = 0
% of a monochromatic point source located at [ x_s y_s z_s ];
% k = 2*pi*f/c
%
r = sqrt( ( x - x_s ).^2 + ( y - y_s ).^2 + ( z_s ).^2 );

S = (1 ./ r) .* exp( -i .* k .* r );