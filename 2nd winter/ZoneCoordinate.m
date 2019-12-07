function cord = ZoneCoordinate(center, r_zone, points)

[V,~,~,~]=ParticleSampleSphere('N', points);
V = r_zone * V;

V =[V(:,1)+center(1) V(:,2)+center(2) V(:,3)+center(3)];

cord = V;

end