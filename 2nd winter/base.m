clc;
close all;

addpath(strcat(pwd,'\Functions'));
%{
cord_zone1 = ZoneCoordinate([1, 2, 3], 0.15, 20);
cord_zone1
%}
fl = 1024;  %filter length
h = 40;     %room height
l = 5;      %room length
b = 5;      %room breadth
h_centre = h/2;

ext_source = [0.5, 0.5, h_centre];

L = 30; %number of loudspeakers
N = 20; %number of microphones

%H = channel([9 7 4], [9, 9, 9], 1024); Large room won't work

%Make circle of speakers using sin, cos
rad = 2;
speakers = zeros(L, 3);     
%speakers in a circle of radius rad, and centre at centre of room
for i = 0:L-1
    speakers(i+1, :) = [rad*sin(pi*i/L), rad*cos(pi*i/L), h_centre];
end
speakers = [speakers(:,1)+l/2 speakers(:,2)+b/2 speakers(:,3)];

%dark zone is fixed 
dark_centre = [3.5, 1.5, h_centre]; 
d_mics = ZoneCoordinate(dark_centre, 0.15, 20);
dcontrol = zeros(N, L, fl); %(dark point idx, loudspeaker idx)
for i = 1:N
    for j = 1:L
        dcontrol(i, j, :) = channel(speakers(j, :), d_mics(i,:), fl);
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
    b_mics = ZoneCoordinate(bright_centre, 0.15, 20);
    bcontrol = zeros(N, L, fl); %(bright point idx, loudspeaker idx)
    for i = 1:N
        for j = 1:L
            bcontrol(i, j, :) = channel(speakers(j, :), b_mics(i,:), fl);
        end
    end
    bcontrol_gp(:, :, :, idx) = bcontrol;
end

%generate RIRs from ext_source
desired = zeros(N, 1, fl, n_gp);
for idx = 1:n_gp
    bright_centre = gpoints_int(idx, :); 
    b_mics = ZoneCoordinate(bright_centre, 0.15, 20);
    bcontrol = zeros(N, 1, fl); %(bright point idx, loudspeaker idx)
    for i = 1:N
        bcontrol(i, 1, :) = channel(ext_source, b_mics(i,:), fl);
    end
    desired(:, :, :, idx) = bcontrol;
end



