%% Load Data
clearvars;

scalar_sub = load("C:\Users\min\Desktop\여름연구\OpticalFlow\ground_truth\data\scalar1_with_sub_area.mat").sst;

%% Input Parameters

offset = 5; % (sub area length / 2)

flow_velocity = 0.5; %(meter / sec)
flow_direction_deg = 0; %(degree)

SPATIAL_RESOLUTION_RATIO = 2000; % 2000 meters : 1 pixel
TIME_RESOLUTION_RATIO = 600; % 600 seconds : 1 snapshot


%% Set Parameters

% Set u,v velocity
flow_direction_rad = deg2rad(flow_direction_deg);
u= flow_velocity * cos(flow_direction_rad); % meter/sec
v= flow_velocity * sin(flow_direction_rad); % meter/sec

% Set dt
dt = TIME_RESOLUTION_RATIO; % second

% Set displacement
dx=u*dt;
dy=v*dt;

% Set Data Size
[rows, cols] = size(scalar_sub);

[X, Y] = meshgrid(1:cols, 1:rows);

ORIGINAL_GRID_X = X * SPATIAL_RESOLUTION_RATIO;
ORIGINAL_GRID_Y = Y * SPATIAL_RESOLUTION_RATIO;

%% Calculate Vector Field

vector_size_x = cols - (offset * 2) ;
vector_size_y = rows - (offset * 2) ;

ux = u * ones(vector_size_x); % x 방향 속도장
uy = v * ones(vector_size_y); % y 방향 속도장

%% Save Vector Field

save('C:\Users\min\Desktop\여름연구\OpticalFlow\ground_truth\data\GT_vector_field.mat', 'ux', 'uy');

%% Calculate Scalar2

SHIFTED_GRID_X = ORIGINAL_GRID_X + dx;
SHIFTED_GRID_Y = ORIGINAL_GRID_Y + dy;

scalar_sub_interp = griddata(SHIFTED_GRID_X, SHIFTED_GRID_Y, scalar_sub, ORIGINAL_GRID_X, ORIGINAL_GRID_Y, 'v4');

% Remove Sub Area
scalar1 = scalar_sub(1+offset:cols-offset, 1+offset:rows-offset);
scalar2 = scalar_sub_interp(1+offset:cols-offset, 1+offset:rows-offset);

%% Save Scalar2

data1 = struct('sst', scalar2);
save("C:\Users\min\Desktop\여름연구\OpticalFlow\ground_truth\data\scalar2.mat",'-struct', 'data1');

%% Draw Original Scalar, Shifted Scalar and Vector Field

figure;
pcolor(scalar1);
grid on;

figure;
pcolor(scalar2);
grid on;


