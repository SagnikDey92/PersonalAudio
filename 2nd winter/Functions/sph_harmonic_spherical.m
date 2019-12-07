%%%%%%%%%%%%GYANAJYOTI %%%%%%%%%%%%%%%%

function Y = sph_harmonic_spherical(theta,phi,n)
%SPH_HARMONIOC_CARTECIAN Summary of this function goes here
%   Detailed explanation goes here
 %theta is elevation of the observation location in radian
  %phi is azimuth of the observation location in radian
%   theta=(theta*pi)/180;
%   phi=(phi*pi)/180;
  
Y_n=legendre(n,cos(theta));
Y_nm=Y_n;
    for nn=1:n
        Y_nm=[Y_n(nn+1,:);Y_nm];
    end

    for m=-n:1:n;
        A=sqrt(((2*n+1)/4*pi)*(factorial(n-abs(m))/factorial(n+abs(m))));

        Y(m+n+1,:)=A*Y_nm(m+n+1)*exp(i*m*phi);
    end

end

