function cord = ZoneCoordinate_prev(r_zone, points)

[V,~,~,~]=ParticleSampleSphere('N', points);
V = r_zone * V;

cord = V;

end