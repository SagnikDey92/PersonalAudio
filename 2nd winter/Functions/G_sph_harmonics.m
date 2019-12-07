function [ Ynm ] = G_sph_harmonics( order,mode,elevation,azimuth )
%G_SPH_HARMONICS Summary of this function goes here
% elevation and azimuth are in radians
%   Detailed explanation goes here
if nargin==0
  order=3;    % ORDER
  mode=-2;   % DEGREE
  elevation=pi/4;  
  azimuth=pi/4;
end

if nargin<3
  elevation=45;  
  azimuth=45;
end

if order < abs(mode), error('The MODE (M) must be less than or eqaul to the ORDER(N).'); end


Lmn=legendre(order,cos(elevation));

if order~=0
  Lmn=squeeze(Lmn(abs(mode)+1,:,:));
end

a1=((2*order+1)/(4*pi));
a2=factorial(order-abs(mode))/factorial(order+abs(mode));
C=sqrt(a1*a2);

Ynm=C*Lmn.*exp(1i*mode*azimuth);
end

