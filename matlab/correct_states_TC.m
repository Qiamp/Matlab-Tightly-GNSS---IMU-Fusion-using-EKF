%--> Use the ekf state_correction_vector to correct all states 
lat_value(index+1) = (lat_value(index+1)*D2R + state_correction_vector(2)/(Rm_value(index+1)+alt_value(index+1)))*R2D;
lon_value(index+1) = (lon_value(index+1)*D2R + state_correction_vector(1)/((Rn_value(index+1)+alt_value(index+1))*cos(lat_value(index+1)*D2R)))*R2D;
C_EN_value = C_EN_fun(lat_value(index+1)*D2R , lon_value(index+1)*D2R);
pos_quat_vector = dcm2quat (C_EN_value');
a_pos_value(index+1) = pos_quat_vector(1);
b_pos_value(index+1) = pos_quat_vector(2);
c_pos_value(index+1) = pos_quat_vector(3);
d_pos_value(index+1) = pos_quat_vector(4);
normalization_factor = sqrt(a_pos_value(index+1)^2 + b_pos_value(index+1)^2 + c_pos_value(index+1)^2 + d_pos_value(index+1)^2);
a_pos_value(index+1) = a_pos_value(index+1)/normalization_factor;
b_pos_value(index+1) = b_pos_value(index+1)/normalization_factor;
c_pos_value(index+1) = c_pos_value(index+1)/normalization_factor;
d_pos_value(index+1) = d_pos_value(index+1)/normalization_factor;
alt_value(index+1) = alt_value(index+1) + state_correction_vector(3);
ve_value(index+1) = ve_value(index+1) + state_correction_vector(4);
vn_value(index+1) = vn_value(index+1) + state_correction_vector(5);
vu_value(index+1) = vu_value(index+1) + state_correction_vector(6);
b_value(index+1) = b_value(index+1) + state_correction_vector(7);
c_value(index+1) = c_value(index+1) + state_correction_vector(8);
d_value(index+1) = d_value(index+1) + state_correction_vector(9);
a_value(index+1) = a_value(index+1) - ([b_value(index) c_value(index) d_value(index)]*state_correction_vector(7:9))/a_value(index);
gyro_bias_x_value(index+1) = gyro_bias_x_value(index+1) + state_correction_vector(10);
gyro_bias_y_value(index+1) = gyro_bias_y_value(index+1) + state_correction_vector(11);
gyro_bias_z_value(index+1) = gyro_bias_z_value(index+1) + state_correction_vector(12);
acc_bias_x_value(index+1) = acc_bias_x_value(index+1) + state_correction_vector(13);
acc_bias_y_value(index+1) = acc_bias_y_value(index+1) + state_correction_vector(14);
acc_bias_z_value(index+1) = acc_bias_z_value(index+1) + state_correction_vector(15);
gyro_sf_x_value(index+1) = gyro_sf_x_value(index+1) + state_correction_vector(16);
gyro_sf_y_value(index+1) = gyro_sf_y_value(index+1) + state_correction_vector(17);
gyro_sf_z_value(index+1) = gyro_sf_z_value(index+1) + state_correction_vector(18);
acc_sf_x_value(index+1) = acc_sf_x_value(index+1) + state_correction_vector(19);
acc_sf_y_value(index+1) = acc_sf_y_value(index+1) + state_correction_vector(20);
acc_sf_z_value(index+1) = acc_sf_z_value(index+1) + state_correction_vector(21);
receiver_clk_bias_value(index+1) = receiver_clk_bias_value(index+1) + state_correction_vector(22);
receiver_clk_drift_value(index+1) = receiver_clk_drift_value(index+1) + state_correction_vector(23);

% Normalize the quaternions
normalization_factor = sqrt(a_value(index+1)^2 + b_value(index+1)^2 + c_value(index+1)^2 + d_value(index+1)^2);
a_value(index+1) = a_value(index+1)/normalization_factor;
b_value(index+1) = b_value(index+1)/normalization_factor;
c_value(index+1) = c_value(index+1)/normalization_factor;
d_value(index+1) = d_value(index+1)/normalization_factor;
normalization_factor = sqrt(a_pos_value(index+1)^2 + b_pos_value(index+1)^2 + c_pos_value(index+1)^2 + d_pos_value(index+1)^2);
a_pos_value(index+1) = a_pos_value(index+1)/normalization_factor;
b_pos_value(index+1) = b_pos_value(index+1)/normalization_factor;
c_pos_value(index+1) = c_pos_value(index+1)/normalization_factor;
d_pos_value(index+1) = d_pos_value(index+1)/normalization_factor;

[A, p, r] = quat2angle([a_value(index+1) b_value(index+1) c_value(index+1) d_value(index+1)],'ZYX');
Euler_pitch_value(index+1)     = p;
Euler_roll_value(index+1)      = r;
Euler_heading_value(index+1)   = A;

Rn_value(index+1)  = earth_a/sqrt(1-earth_e2*sin(lat_value(index+1)*D2R)*sin(lat_value(index+1)*D2R));
Rm_value(index+1)  = earth_a*(1-earth_e2)/((1-earth_e2*sin(lat_value(index+1)*D2R)*sin(lat_value(index+1)*D2R))^(1.5));
EP_value(index+1) = (lon_value(index+1)-lon_value(1))*D2R*(Rn_value(index+1)+alt_value(index+1))*cos(lat_value(index+1)*D2R);
NP_value(index+1) = (lat_value(index+1)-lat_value(1))*D2R*(Rm_value(index+1)+alt_value(index+1));