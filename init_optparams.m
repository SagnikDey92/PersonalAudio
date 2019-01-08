function [ Rb, Rd ] = init_optparams( x, bcontrol, dcontrol, K, M )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    Rb = zeros(0, 1024*10);
    Rd = zeros(0, 1024*10);
    for i = 1 : K
        rB = zeros(0, 1);
        for j = 1:10
            rBtemp = conv(x, reshape(bcontrol(j, i, :), [M, 1]));
            rBtemp = rBtemp(end-M+1:end, 1);
            rBtemp = flipud(rBtemp);
            rBtemp = rBtemp';
            rB = [rB rBtemp];
        end
        Rb = [Rb ; rB];
        disp(i);    %to check if stuck or progressing
    end
    Rb = Rb/sqrt(K);

    for i = 1 : K
        rD = zeros(0, 1);
        for j = 1:10
            rDtemp = conv(x, reshape(dcontrol(j, i, :), [M, 1]));
            rDtemp = rDtemp(end-M+1:end, 1);
            rDtemp = flipud(rDtemp);
            rDtemp = rDtemp';
            rD = [rD rDtemp];
        end
        Rd = [Rd ; rD];
        disp(i);    % some places had b instead of d. Please check entire code for such bugs.
    end
    Rd = Rd/sqrt(K);

end

