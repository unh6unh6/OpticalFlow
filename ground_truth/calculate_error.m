%% Calculate Error

% load data
GT_vector_field = load("data\GT_vector_field.mat");
OF_vector_field = load("data\OF_vector_field.mat");


%% 벡터 방향 오차

direction_GT = atan2(GT_vector_field.uy, GT_vector_field.ux);
direction_OF = atan2(OF_vector_field.uy, OF_vector_field.ux);

rad_direction_error = abs(direction_GT - direction_OF);

rad_direction_error = mod(rad_direction_error + pi, 2*pi) - pi;
rad_direction_error = abs(rad_direction_error);

deg_direction_error = rad2deg(rad_direction_error);

mean_rad_direction_error = mean(rad_direction_error, 'all')
mean_deg_direction_error = mean(deg_direction_error, 'all')


%% 벡터 크기 오차

velocity_GT = sqrt(GT_vector_field.ux.^2 + GT_vector_field.uy.^2);
velocity_OF = sqrt(OF_vector_field.ux.^2 + OF_vector_field.uy.^2);

velocity_error = abs(velocity_GT - velocity_OF);

mean_velocity_error = mean(velocity_error, 'all')




