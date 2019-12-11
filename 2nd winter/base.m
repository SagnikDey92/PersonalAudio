%{
point 11 is left. Is optional
%}
load('RIRdata.mat');
%{
%For generating data, remove load command and uncomment the below lines

clc;
close all;

addpath(strcat(pwd,'\Functions'));

fl = 1024;  %filter length
h = 40;     %room height
l = 5;      %room length
b = 5;      %room breadth
h_centre = h/2;

ext_source = [0.1, 0.1, h_centre];

L = 72; %number of loudspeakers
N = 64; %number of microphones

%Make circle of speakers using sin, cos
rad = 2;
speakers = zeros(L, 3);     
%speakers in a circle of radius rad, and centre at centre of room
for i = 0:L-1
    speakers(i+1, :) = [rad*sin(pi*i/L), rad*cos(pi*i/L), h_centre];
end
speakers = [speakers(:,1)+l/2 speakers(:,2)+b/2 speakers(:,3)];

points = ZoneCoordinate_prev(0.15, N);

%dark zone is fixed 
dark_centre = [3.5, 1.5, h_centre]; 
d_mics = ZoneCoordinate(dark_centre, points);
dcontrol = zeros(N, L, fl); %(dark point idx, loudspeaker idx)
for i = 1:N
    for j = 1:L
        dcontrol(i, j, :) = fft(channel(speakers(j, :), d_mics(i,:), fl));
    end
end

%grid points
gpoints = zeros(100, 3);
for i = 1:10
    for j = 1:10
        gpoints(10*(i-1)+j, :) = [i/11*l, j/11*b, h_centre];
    end
end

gpoints_int = zeros(0, 3);

for i = 1:100
    dist = pdist([l/2, b/2;gpoints(i, 1), gpoints(i, 2)], 'euclidean');
    if(dist<2)
        gpoints_int = [gpoints_int;gpoints(i, :)];
    end
end

disp(size(gpoints_int));
n_gp = size(gpoints_int,1);

%bright zone data for all grid points
bcontrol_gp = zeros(N, L, fl, n_gp);
for idx = 1:n_gp
    bright_centre = gpoints_int(idx, :); 
    b_mics = ZoneCoordinate(bright_centre, points);
    bcontrol = zeros(N, L, fl); %(bright point idx, loudspeaker idx)
    for i = 1:N
        for j = 1:L
            bcontrol(i, j, :) = fft(channel(speakers(j, :), b_mics(i,:), fl));
        end
    end
    bcontrol_gp(:, :, :, idx) = bcontrol;
end

%generate RIRs from ext_source
desired = zeros(N, 1, fl, n_gp);
for idx = 1:n_gp
    bright_centre = gpoints_int(idx, :); 
    b_mics = ZoneCoordinate(bright_centre, points);
    bcontrol = zeros(N, 1, fl); %(bright point idx, loudspeaker idx)
    for i = 1:N
        bcontrol(i, 1, :) = fft(channel(ext_source, b_mics(i,:), fl));
    end
    desired(:, :, :, idx) = bcontrol;
end

%}

%gonna calculate for grid point idx = 20
FinalWeights = zeros(L, fl, n_gp);
for idx = 1:n_gp
    bcontrol = bcontrol_gp(:, :, :, idx);

    %I assume that ZoneCoordinate always gives same output for same input
    bctemp = desired(:, :, :, idx);
    Y = zeros(N, fl);
    for i = 1:N
        H = bctemp(i, 1, :);
        H = H(:);
        Y(i, :) = H;
    end
    %Y = sum(W(i) * X * H(i));  %pointwise multiplication (.*)
    %For dark zone mics, use Y as zero vectors.
    %H(i) is from bcontrol from loudspeaker i to mic, X I have, W(i) is weight
    %vector for loudspeaker i. 
    %Finally, take IIFT for weight vector for each filter.

    partY = bcontrol;
    dpartY = dcontrol;

    %Optimization problem
    Weights = zeros(L, fl);
    for i = 1:fl
        cvx_begin quiet
        mat = partY(:, :, i);
        mat = mat';
        dmat = dpartY(:, :, i);
        dmat = dmat';
        variable W(L) complex
        %x = (sum(repmat(W,1,N).*mat))';
        %minimize(norm(W-ones(L, 1)))
        minimize(norm(Y(:, i)-(sum(repmat(W,1,N).*mat))') + norm(sum(repmat(W,1,N).*dmat)))
        % + norm(darkreceivedsignal))
        cvx_end
        Weights(:, i) = W;
        disp(idx);
        disp(i);
    end
    TWeights = (ifft(Weights'))';
    TWeights = real(TWeights);
    FinalWeights(:, :, idx) = TWeights;
    save('Results.mat', 'FinalWeights', 'idx');
end

%use half of fft rest is repeated (I dont't see the repetition)
