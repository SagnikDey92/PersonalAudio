function [ dcontrol1, dcontrol2, bcontrol1, bcontrol2 ] = init_channels( darkcentre, brightcentre, speaker1, speaker2 )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    n = 1024;
    dcontrol1 = zeros(1000, 1024);
    bcontrol1 = zeros(1000, 1024);
    dcontrol2 = zeros(1000, 1024);
    bcontrol2 = zeros(1000, 1024);
    index = 1;
    for i = brightcentre(1)-0.04 :0.01: brightcentre(1)+0.05
        for j = brightcentre(2)-0.04 :0.01: brightcentre(2)+0.05
            for k = brightcentre(3)-0.04 :0.01: brightcentre(3)+0.05
                bcontrol1(index, :) = channel(speaker1, [i j k], n);
                bcontrol2(index, :) = channel(speaker2, [i j k], n);
                index = index+1;
            end
        end
    end
    index = 1;
    for i = darkcentre(1)-0.04 :0.01: darkcentre(1)+0.05
        for j = darkcentre(2)-0.04 :0.01: darkcentre(2)+0.05
            for k = darkcentre(3)-0.04 :0.01: darkcentre(3)+0.05
                dcontrol1(index, :) = channel(speaker1, [i j k], n);
                dcontrol2(index, :) = channel(speaker2, [i j k], n);
                index = index+1;
            end
        end
    end
end

