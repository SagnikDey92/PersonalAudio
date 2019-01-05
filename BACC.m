%Sudhanshu I've finished it mostly. Please do the checking part cause my laptop slow.
[x,Fs] = audioread('audioshort.wav');
x = x(:, 1);
delta = 0.1;                % what to do? 
x = x(1:160000, 1);         % cutting audio short
M = 1024;                   % filter length
speaker1 = [3 3 3];
speaker2 = [5 5 5];
darkcentre = [1 2 3];
brightcentre = [7 5 2];
%channel for control points below (1000 around dark zone and brightzone of volume 10x10x10 cm^3)
[ dcontrol1, dcontrol2, bcontrol1, bcontrol2 ] = init_channels(darkcentre, brightcentre, speaker1, speaker2);
K = 1000;

[Rb, Rd] = init_optparams( x, dcontrol1, dcontrol2, bcontrol1, bcontrol2, K, M );
opt = pinv(Rd'*Rd + delta*eye(M*2, M*2))*(Rb'*Rb);
[filterpred, ~] = eigs(opt, 1);
filter1 = filterpred(1:M, 1);       %filter for speaker 1
filter2 = filterpred(M+1:end, 1);   %filter for speaker 2


%OLD CODE BELOW

%{
H1 = channel([5, 5, 5], [7, 5, 2]); %assuming Kalman gave us the right H1(bright);
H2 = channel([5, 5, 5], [1, 2, 3]); %assuming Kalman gave us the right H2(dark);
rb = conv(H1, x);
rd = conv(H2, x);
rb = rb(end-M+1:end, 1);
rb = flipud(rb);
rd = rd(end-M+1:end, 1);
rd = flipud(rd);
K = 1000    %K is 1000 for both bright and dark
Rb = rb';   %array of 1
Rd = rd';   %array of 1
opt = pinv(Rd'*Rd + delta*eye(M, M))*(Rb'*Rb);
[filterpred, ~] = eigs(opt, 1);
%I guess this is the required filterpred
%Sudhanshu please check bright zone and dark zone using this filter
xf = conv(x, filterpred);
bz = conv(xf, H1);
dz = conv(xf, H2);
plot(bz);
hold on;
plot(dz);
figure;
plot(bz);
hold on;
plot(conv(x,  H1));
%}