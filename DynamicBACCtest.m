[x,Fs] = audioread('audioshort.wav');
x = x(:, 1);            
x = x(1:160000, 1);         % cutting audio short
delta = 0.1;
M = 1024;
L = 5;
thresh = 1e-10;
filters = zeros(M, L);

darkcentre = [3, 5, 5];
brightcentre = [6, 9, 5];

dcontrol = zeros(L, 1000, 1024);
bcontrol = zeros(L, 1000, 1024);

for i = 1 : 3
    [filters, bcontrol, dcontrol] = BACC2(x, delta, M, darkcentre, brightcentre, filters, bcontrol, dcontrol, thresh); 
    brightcentre = brightcentre + [0.1, 0.1, 0];
end