function [ Rb, Rd ] = init_optparams( x, dcontrol, bcontrol, K, M )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    Rb = zeros(0, 1024*2);
    Rd = zeros(0, 1024*2);
    for i = 1 : K
        rB = zeros(0, 1);
        for j = 1:10
            rBtemp = shortconv(x, bcontrol(j, i, :), M);
            rB = [rB rBtemp];
        end
        Rb = [Rb ; rB];
        disp(i);    %to check if stuck or progressing
    end
    Rb = Rb/sqrt(K);

    for i = 1 : K
        rD = zeros(0, 1);
        for j = 1:10
            rDtemp = shortconv(x, dcontrol(j, i, :), M);
            rD = [rD rDtemp];
        end
        Rd = [Rd ; rD];
        disp(i);    % some places had b instead of d. Please check entire code for such bugs.
    end
    Rd = Rd/sqrt(K);

end

