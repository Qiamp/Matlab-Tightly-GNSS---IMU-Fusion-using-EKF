function write_kml_from_lla(filename, ekf_lat_deg, ekf_lon_deg, ekf_alt_m, gnss_lat_deg, gnss_lon_deg, gnss_alt_m)
    ekf_lat_deg = ekf_lat_deg(:);
    ekf_lon_deg = ekf_lon_deg(:);
    ekf_alt_m   = ekf_alt_m(:);

    gnss_lat_deg = gnss_lat_deg(:);
    gnss_lon_deg = gnss_lon_deg(:);
    gnss_alt_m   = gnss_alt_m(:);

    if ~(numel(ekf_lat_deg) == numel(ekf_lon_deg) && numel(ekf_lat_deg) == numel(ekf_alt_m))
        error('write_kml_from_lla:InputSizeMismatch','EKF latitude, longitude, and altitude must have equal length.');
    end
    if ~(numel(gnss_lat_deg) == numel(gnss_lon_deg) && numel(gnss_lat_deg) == numel(gnss_alt_m))
        error('write_kml_from_lla:InputSizeMismatch','GNSS latitude, longitude, and altitude must have equal length.');
    end

    fid = fopen(filename,'w');
    if fid < 0
        error('write_kml_from_lla:FileOpenFailed','Unable to open %s for writing.', filename);
    end
    cleaner = onCleanup(@() fclose(fid));

    fprintf(fid,'<?xml version="1.0" encoding="UTF-8"?>\n');
    fprintf(fid,'<kml xmlns="http://www.opengis.net/kml/2.2">\n<Document>\n');

    % EKF trajectory (red)
    fprintf(fid,'<Placemark>\n<name>EKF Solution</name>\n');
    fprintf(fid,'<Style><LineStyle><color>ff0000ff</color><width>2.5</width></LineStyle></Style>\n');
    fprintf(fid,'<LineString>\n<tessellate>1</tessellate>\n<altitudeMode>absolute</altitudeMode>\n<coordinates>\n');
    for i = 1:numel(ekf_lat_deg)
        fprintf(fid,'%.10f,%.10f,%.3f\n', ekf_lon_deg(i), ekf_lat_deg(i), ekf_alt_m(i));
    end
    fprintf(fid,'</coordinates>\n</LineString>\n</Placemark>\n');

    % Raw GNSS trajectory (green)
    fprintf(fid,'<Placemark>\n<name>GNSS Measurements</name>\n');
    fprintf(fid,'<Style><LineStyle><color>ff00ff00</color><width>1.5</width></LineStyle></Style>\n');
    fprintf(fid,'<LineString>\n<tessellate>1</tessellate>\n<altitudeMode>absolute</altitudeMode>\n<coordinates>\n');
    for i = 1:numel(gnss_lat_deg)
        fprintf(fid,'%.10f,%.10f,%.3f\n', gnss_lon_deg(i), gnss_lat_deg(i), gnss_alt_m(i));
    end
    fprintf(fid,'</coordinates>\n</LineString>\n</Placemark>\n');

    fprintf(fid,'</Document>\n</kml>\n');
end