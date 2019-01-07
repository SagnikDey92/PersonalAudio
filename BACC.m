%Sudhanshu I've finished it mostly. Please do the checking part cause my laptop slow.
[x,Fs] = audioread('audioshort.wav');
x = x(:, 1);
delta = 0.1;                % what to do? 
x = x(1:160000, 1);         % cutting audio short
M = 1024;                   % filter length

%fiddled around with speaker and control positions
%this gives best possible output
speaker1 = [5.2 2 5];
speaker2 = [5 2 5];
%place 10 speakers along x axis centered at 5, 2, 5
speakers = zeros(10, 3);
index = 1;
for i = 4.2:0.2:6
    speakers(index, :) = [i, 2, 5];
    index = index+1;
end

darkcentre = [ 2 7 5 ];
brightcentre = [ 7 7 5 ];  

%channel for control points below (1000 around dark zone and brightzone of volume 10x10x10 cm^3)
[ dcontrol, bcontrol ] = init_channels(darkcentre, brightcentre, speakers);
K = 100;

[Rb, Rd] = init_optparams( x, dcontrol, bcontrol, K, M );
opt = pinv(Rd'*Rd + delta*eye(M*10, M*10))*(Rb'*Rb);
[filterpred, ~] = eigs(opt, 1);
filters = zeros(M, 10);
for i = 1:10
    filters(:, i) = filterpred(M*(i-1)+1:M*i, 1);
end

%{
filter1 = filterpred(1:M, 1);       %filter for speaker 1
filter2 = filterpred(M+1:end, 1);   %filter for speaker 2

centreindex = 50;%index of original control point for both bright and dark

%Applying filter to input signal
u1=conv(x,filter1);
u2=conv(x,filter2);

%Applying channel to filtered input
ybright = conv(bcontrol1(centreindex,:),u1)+conv(bcontrol2(centreindex,:),u2);
ydark = conv(dcontrol1(centreindex,:),u1)+conv(dcontrol2(centreindex,:),u2);

%plot of both output signals for comparison
plot(ybright);
figure;
plot(ydark);
figure
%plot of old and new bright zone vs darkzone for comparison  
ybrightold = conv(bcontrol1(centreindex,:),x)+conv(bcontrol2(centreindex,:),x);
ydarkold = conv(dcontrol1(centreindex,:),x)+conv(dcontrol2(centreindex,:),x);
plot(ybright);
figure;
plot(ydark);
%norm of this difference represents the contrast between the 2 signals higher norm higher contrast
disp(2*norm(ybright-ydark)/(norm(ybright)+norm(ydark))*100);

%Figure 1: ybright, 2: ydark, 3: ybrightold, 4: ydarkold
%}