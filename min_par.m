function [val] = min_par(x, Rb, Rd, delta)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
val = ((x'*(Rd'*Rd)*x) + delta*(x'*x))/(x'*(Rb'*Rb)*x);
end

