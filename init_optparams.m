function [ Rb, Rd ] = init_optparams( x, dcontrol1, dcontrol2, bcontrol1, bcontrol2, K, M )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    Rb = zeros(0, 1024*2);
    Rd = zeros(0, 1024*2);
    for i = 1 : K
        rB = zeros(0, 1);
        rBtemp1 = shortconv(x, bcontrol1(i, :), M);
        rB = [rB rBtemp1];
        rBtemp2 = shortconv(x, bcontrol2(i, :), M);
        rB = [rB rBtemp2];
        Rb = [Rb ; rB];
        disp(i);    %to check if stuck or progressing
    end
    Rb = Rb/sqrt(K);

    for i = 1 : K
        rD = zeros(0, 1);
        rDtemp1 = shortconv(x, dcontrol1(i, :), M);
        rD = [rD rDtemp1];
        rDtemp2 = shortconv(x, dcontrol2(i, :), M);
        rD = [rD rDtemp2];
        Rd = [Rd ; rD];
        disp(i);    % some places had b instead of d. Please check entire code for such bugs.
    end
    Rd = Rd/sqrt(K);

end

