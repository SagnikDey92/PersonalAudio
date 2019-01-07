function [ dcontrol, bcontrol ] = init_channels( darkcentre, brightcentre, speakers )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    n = 1024;
    dcontrol = zeros(10, 1000, 1024);
    bcontrol = zeros(10, 1000, 1024);
    index = 1;
    for l = 1:10
        for i = brightcentre(1)-0.04 :0.01: brightcentre(1)+0.05
            for j = brightcentre(2)-0.04 :0.01: brightcentre(2)+0.05
                k = brightcentre(3);
                bcontrol(l, index, :) = channel(speakers(l, :), [i j k], n);
                index = index+1;
            end
        end
        index = 1;
    end
    for l = 1:10
        for i = darkcentre(1)-0.04 :0.01: darkcentre(1)+0.05
            for j = darkcentre(2)-0.04 :0.01: darkcentre(2)+0.05
                k = darkcentre(3);
                dcontrol(l, index, :) = channel(speakers(l, :), [i j k], n);
                index = index+1;
            end
        end
        index = 1;
    end
end

