function [ res ] = shortconv( vec1, vec2, M )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here 
    n = size(vec1, 1);
    I = size(vec2, 1);
    res = zeros(M, 1);
    for i = n:-1:n-M+1
        for j = 1:I
            res(n-i+1, 1) = res(n-i+1, 1) + vec2(j, 1)*vec1(i-j, 1);
        end
    end
    res = res';
end

