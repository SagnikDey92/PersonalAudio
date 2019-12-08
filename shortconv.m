function [ res ] = shortconv( x, h, M,N )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here 
    size_x = size(x, 1);
    I = size(h, 1);
    res = zeros(M, 1);
    for n = N:-1:N-M+1
        for i = 1:I
            res(N-n+1, 1) = res(N-n+1, 1) + h(i, 1)*x(n-i, 1);
        end
    end
    res = res';
end

