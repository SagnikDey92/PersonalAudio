%Sudhanshu please verify and add comments if you change something.
[x,Fs] = audioread('audioshort.wav');
x = x(:, 1);
delta = 0.1;                % what to do? 
x = x(1:160000, 1);         % cutting audio short
M = 512;                    % filter length
W = zeros(M, 1);            % filter initialisation
c = 340;                    % Sound velocity (m/s)
fs = 16000;                 % Sample frequency (samples/s)
r = [9 9 9];                % Receiver position [x y z] (m)
s = [9 7 4];                % Source position [x y z] (m)
L = [10 10 10];             % Room dimensions [x y z] (m)
beta = 0.4;                 % Reverberation time (s)
n = 512;                    % Number of samples
H1 = rir_generator(c, fs, r, s, L, beta, n); %assuming Kalman gave us the right H1(bright);
r = [8 8 8];
H2 = rir_generator(c, fs, r, s, L, beta, n); %assuming Kalman gave us the right H2(dark);
rb = conv(H1, x);
rd = conv(H2, x);
rb = rb(1:M, 1);%last m elements and flip
rd = rd(1:M, 1);%last m elements and flip
%K is 1 for both bright and dark
Rb = rb'; %array of 1
Rd = rd'; %array of 1
opt = pinv(Rd'*Rd + delta*eye(M, M))*(Rb'*Rb);
[filterpred, ~] = eigs(opt, 1);
%I guess this is the required filterpred
%Sudhanshu please check bright zone and dark zone using this filter
