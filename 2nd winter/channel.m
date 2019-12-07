function [ H ] = channel( s, r, n )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    c = 340;                    % Sound velocity (m/s)
    fs = 16000;                 % Sample frequency (samples/s)
    L = [5 5 40];               % Room dimensions [x y z] (m)
    beta = 0.28;                % Reverberation time (s)
    mtype = 'hypercardioid';    % Type of microphone
    H = rir_generator(c, fs, r, s, L, beta, n, mtype, 1);
    H = H';
end

