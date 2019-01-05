function [ Rb, Rd ] = init_optparams( x, dcontrol1, dcontrol2, bcontrol1, bcontrol2, K, M )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    Rb = zeros(0, 1024*2);
    Rd = zeros(0, 1024*2);
    for i = 1 : K
        rB = zeros(0, 1);
        rBtemp1 = conv(x, bcontrol1(i, :));
        rBtemp1 = rBtemp1(end-M+1:end, 1);
        rBtemp1 = rBtemp1';
        rBtemp1 = fliplr(rBtemp1);
        rB = [rB rBtemp1];
        rBtemp2 = conv(x, bcontrol2(i, :));
        rBtemp2 = rBtemp2(end-M+1:end, 1);
        rBtemp2 = rBtemp2'; 
        rBtemp2 = fliplr(rBtemp2);
        rB = [rB rBtemp2];
        Rb = [Rb ; rB];
        disp(i);    %to check if stuck or progressing
    end
    Rb = Rb/sqrt(K);

    for i = 1 : K
        rD = zeros(0, 1);
        rDtemp1 = conv(x, dcontrol1(i, :));
        rDtemp1 = rDtemp1(end-M+1:end, 1);
        rDtemp1 = rDtemp1';
        rDtemp1 = fliplr(rDtemp1);
        rD = [rD rDtemp1];
        rDtemp2 = conv(x, dcontrol2(i, :));
        rDtemp2 = rDtemp2(end-M+1:end, 1);
        rDtemp2 = rDtemp2'; 
        rDtemp2 = fliplr(rDtemp2);
        rD = [rD rBtemp2];
        Rd = [Rd ; rB];
        disp(i);    %to check if stuck or progressing
    end
    Rd = Rd/sqrt(K);

end

