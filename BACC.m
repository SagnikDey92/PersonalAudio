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

[Rb, Rd] = init_optparams( x, bcontrol, dcontrol, K, M );
opt = pinv(Rd'*Rd + delta*eye(M*10, M*10))*(Rb'*Rb);
[filterpred, ~] = eigs(opt, 1);
filters = zeros(M, 10);
for i = 1:10
    filters(:, i) = filterpred(M*(i-1)+1:M*i, 1);
end
centreindex = 50;

u=conv(x,filters(:,1));
for i=2:10
    u=[u conv(x,filters(:,i))];
end

ybright=conv(reshape(bcontrol(1,centreindex,:),[1 M]),u(:,1));
ydark=conv(reshape(dcontrol(1,centreindex,:),[1 M]),u(:,1));

for i= 2 : 10
    ybright = ybright + conv(reshape(bcontrol(i,centreindex,:),[1 M]),u(:,i));
    ydark  = ydark  + conv(reshape(dcontrol(i,centreindex,:),[1 M]),u(:,i));
end

t1=conv(reshape(bcontrol(1,centreindex,:),[1 M]),x);
t2=conv(reshape(dcontrol(1,centreindex,:),[1 M]),x);
for i = 2 : 10
    t1 = t1 + conv(reshape(bcontrol(i,centreindex,:),[1 M]),x);
    t2  = t2  + conv(reshape(dcontrol(i,centreindex,:),[1 M]),x);
end

figure(1);
plot(ybright);
hold on;
plot(ydark);
figure(2);
plot(t1);
hold on;
plot(t2);