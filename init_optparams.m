function [ Rb, Rd ] = init_optparams( x, bcontrol, dcontrol, K, M, L )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    Rb = zeros(0, 1024*L);
    Rd = zeros(0, 1024*L);
    for i = 1 : K
        rB = zeros(0, 1);
        for j = 1:L
            rBtempconv = conv(x, reshape(bcontrol(j, i, :), [M, 1]));
            rBtemp = zeros(M ,1);
            idx = 0;
            for fr = M:M:size(x, 1)-M
                rBtemp = rBtemp+rBtempconv(fr-M+1:fr, 1);
                idx = idx+1;
            end
            rBtemp = rBtemp/idx;
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
        for j = 1:L
            rDtempconv = conv(x, reshape(dcontrol(j, i, :), [M, 1]));
            rDtemp = zeros(M ,1);
            idx = 0;
            for fr = M:M:size(x, 1)-M
                rDtemp = rDtemp+rDtempconv(fr-M+1:fr, 1);
                idx = idx+1;
            end
            rDtemp = rDtemp/idx;
            rDtemp = flipud(rDtemp);
            rDtemp = rDtemp';
            rD = [rD rDtemp];
        end
        Rd = [Rd ; rD];
        disp(i);    % some places had b instead of d. Please check entire code for such bugs.
    end
    Rd = Rd/sqrt(K);

end

