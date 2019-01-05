function [ H ] = channel( s, r )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    c = 340;                    % Sound velocity (m/s)
    fs = 16000;                 % Sample frequency (samples/s)
    L = [10 10 10];             % Room dimensions [x y z] (m)
    beta = 0.4;                 % Reverberation time (s)
    n = 1024;                    % Number of samples
    H = rir_generator(c, fs, r, s, L, beta, n);
    H = H';
end

