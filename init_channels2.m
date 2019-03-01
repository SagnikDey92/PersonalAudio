function [ dcontrol, bcontrol, flg ] = init_channels2( x, darkcentre, brightcentre, speakers, L, pbcontrol, pdcontrol, thresh )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    flg = 0;
    epsilon = 1e-10;
    sigma2v = 1e-20;
    sigma2w = 1e-20;
    
    n = 1024;
    dcontrol = zeros(L, 1000, 1024);
    bcontrol = zeros(L, 1000, 1024);
    index = 1;
    for l = 1:L
        for i = brightcentre(1)-0.04 :0.01: brightcentre(1)+0.05
            for j = brightcentre(2)-0.04 :0.01: brightcentre(2)+0.05
                k = brightcentre(3);
                orichannel = channel(speakers(l, :), [i j k], n);
                simy = awgn(conv(x, orichannel), 100);
                temp = kalman2( x , simy, sigma2v, sigma2w, epsilon, n);
                bcontrol(l, index, :) = reshape(temp, 1, 1, n);
                index = index+1;
            end
        end
        index = 1;
    end
    for l = 1:L
        for i = darkcentre(1)-0.04 :0.01: darkcentre(1)+0.05
            for j = darkcentre(2)-0.04 :0.01: darkcentre(2)+0.05
                k = darkcentre(3);
                orichannel = channel(speakers(l, :), [i j k], n);
                simy = awgn(conv(x, orichannel), 100);
                temp = kalman2( x , simy, sigma2v, sigma2w, epsilon, n);
                dcontrol(l, index, :) = reshape(temp, 1, 1, n);
                index = index+1;
            end
        end
        index = 1;
    end
    diff = (norm(bcontrol-pbcontrol)+norm(dcontrol-pdcontrol))/(norm(bcontrol)+norm(dcontrol));
    if(diff<thresh)
        flg = 1;
    end
end

