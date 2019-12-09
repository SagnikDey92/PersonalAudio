function cord = ZoneCoordinate(center, points)

cord = bsxfun(@plus, points', center')';

end