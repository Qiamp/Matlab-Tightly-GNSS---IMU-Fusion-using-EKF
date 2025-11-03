function write_kml_from_lla(filename, lat_deg, lon_deg, alt_m)
    lat_deg = lat_deg(:);
    lon_deg = lon_deg(:);
    alt_m   = alt_m(:);
    if ~(numel(lat_deg) == numel(lon_deg) && numel(lat_deg) == numel(alt_m))
        error('write_kml_from_lla:InputSizeMismatch','Latitude, longitude, and altitude must have equal length.');
    end
    fid = fopen(filename,'w');
    if fid < 0
        error('write_kml_from_lla:FileOpenFailed','Unable to open %s for writing.', filename);
    end
    cleaner = onCleanup(@() fclose(fid));
    fprintf(fid,'<?xml version="1.0" encoding="UTF-8"?>\n');
    fprintf(fid,'<kml xmlns="http://www.opengis.net/kml/2.2">\n<Document>\n');
    fprintf(fid,'<Placemark>\n<name>EKF Trajectory</name>\n');
    fprintf(fid,'<Style><LineStyle><color>ff0000ff</color><width>2</width></LineStyle></Style>\n');
    fprintf(fid,'<LineString>\n<tessellate>1</tessellate>\n<altitudeMode>absolute</altitudeMode>\n<coordinates>\n');
    for i = 1:numel(lat_deg)
        fprintf(fid,'%.10f,%.10f,%.3f\n', lon_deg(i), lat_deg(i), alt_m(i));
    end
    fprintf(fid,'</coordinates>\n</LineString>\n</Placemark>\n</Document>\n</kml>\n');
end