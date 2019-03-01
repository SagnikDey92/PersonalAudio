function [ H ] = kalman2 ( x , y, sigma2v, sigma2w, epsilon, n )
H = zeros(n, 1);
index = 1;
Ru=epsilon*eye(n);
while index < n
    xf = splitv(x, index, n);%taking new sample of x from which kalman filter will be updated
    Rm = Ru + sigma2w*eye(n);%calculating correlation matrix of m,i.e priori misalignment of h
    sigma2e = xf'*Rm*xf + sigma2v;%calculating variance of priori error
    K = Rm*xf/sigma2e;%Calculating Kalmann gain
    e = y(index) - xf'*H;%calculating priori error    
    H = H + K*e;                  %Updating estimated h
    Ru = (eye(n) - K*xf')*Rm;     %Updating Ru
    index=index+1;                %Updating index 
    clc;
    index
end  
H = flipud(H);