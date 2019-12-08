[x,Fs] = audioread('audioshort.wav');
x = x(:, 1);
x = x(1:160000, 1);         % cutting audio short
n = 512;                    % Number of samples(taking 1024 reveals  the current h has bumps after 512 too)
SNR = 100;                  % high SNR

%Generating h from rir_generator
h = channel([9 7 4], [9, 9, 9], n);
h = h(200:end, 1);
n = 512-200+1; %cutting h to remove blank part
hnoise = awgn(h, 100)-h;%generating noise for h
sigp2 = 10*log10(norm(hnoise,2)^2/numel(hnoise));%signal power for noise in h
snr2 = sigp2-SNR;%snr of hnoise
sigma2w = 10^(snr2/10);%Calculating variance of noise in h
h = h + hnoise;%generating final h after adding noise

%Actual received signal data
y=conv(x,h);%signal received at microphone
ynoise=awgn(y,SNR);%adding noise to the signal received
v=ynoise-y;%noise present in the receive signal
sigp1 = 10*log10(norm(v,2)^2/numel(v));%signal power of noise in y
snr1 = sigp1-SNR;%snr of noise in y
sigma2v = 10^(snr1/10);%variance of noise in y
y = ynoise;%Final received signal with noise

%Kalmann Filter begins here
H=zeros(n, 1);%initializing the estimated h with zeros
epsilon=1e-10;%using very low epsilon
index=1;
Xsize=size(x, 1);%size of input signal
Ru=epsilon*eye(n);%Correlation matrix of u ,i.e uncertainitites in h

%threshlow = 1e-5;

%Testing values for variance of v and w
%sigma2v = 1e-30;
%sigma2w = 1e-30;

%Estimation of channel using Kalmann Filter
%running till the whole input is not scanned
while index < 512
    %After 1000 iterations h has been estimated 
    %So adding noise to h to see if Kalmann Filter is still able to estimate h
    if(mod(index, 1600)==0)
        h = awgn(h, SNR);       %Adding noise to h
        y = conv(x, h);         %new actual received signal
        y = awgn(y, SNR);       %new actual received signal with noise
        Ru = epsilon*eye(n);    %Re intializing correlation matrix of u
        %index  = 1;            %Resetting index to 1
        
        %Note : Kalmann Filter becomes very slow if index is not changed to 1
        %Problem still unresolved
    end
    xf = splitv(x, index, n);%taking new sample of x from which kalman filter will be updated
    Rm = Ru + sigma2w*eye(n);%calculating correlation matrix of m,i.e priori misalignment of h
    sigma2e = xf'*Rm*xf + sigma2v;%calculating variance of priori error
    K = Rm*xf/sigma2e;%Calculating Kalmann gain
    e = y(index) - xf'*H;%calculating priori error
    %Note:
    %xf'*H should be equal to convolution of xf with h
    %But it generating more error in estimation of h
    
    H = H + K*e;                  %Updating estimated h
    Ru = (eye(n) - K*xf')*Rm;     %Updating Ru
    index=index+1;                %Updating index 
    clc;
    norm(h-flipud(H))/norm(h)*100 %This gives the percentage error in estimated h
    index
end  
%plot lines for copy paste
plot(h)
figure
plot(flipud(H))