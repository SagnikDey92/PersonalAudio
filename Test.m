[x,Fs] = audioread('audioshort.wav');
x = x(:, 1);
c = 340;                    % Sound velocity (m/s)
fs = 16000;                 % Sample frequency (samples/s)
r = [1 2.5 3];              % Receiver position [x y z] (m)
s = [2 4.5 5];              % Source position [x y z] (m)
L = [15 12 18];             % Room dimensions [x y z] (m)
beta = 0.4;                 % Reverberation time (s)
n = 512;                    % Number of samples
SNR = 5;
h = rir_generator(c, fs, r, s, L, beta, n);
x1 = x(1:n);
terminated = false;
H = zeros(1, n);
threshlow = 10^-6;
e = 0; 
epsilon = 10^-5;
wnoise = 0;
Rnu = epsilon*eye(n);
start = 1;
y = x1'*h';
y = awgn(y, SNR, 'measured');
sigp = 10*log10(norm(y,2)^2/numel(y));
snr = sigp-5;
variance = 10^(snr/10);
x1 = x(start:start+n-1);
while ~terminated
    R=h'*h;
    sigma2v = trace(x1'*R*x1)/(n*(10^(SNR/20)));
    Rm = Rnu + wnoise*eye(n);
    Re = x1'*Rm*x1 + sigma2v*eye(1);
    K = Rm*x1*pinv(Re);
    e = y - x1'*H';
    H = H + K'*e;
    Rnu = (eye(n) - K*x1')*Rm;
    if norm(H-h)<threshlow
        terminated = true;
    end
end

    