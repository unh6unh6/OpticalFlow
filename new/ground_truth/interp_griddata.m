%interp with griddata

scalar_sub = load("C:\Users\min\Desktop\여름연구\OpticalFlow\new\ground_truth\data\griddata\scalar1_with_sub_area.mat").sst;
offset = 5;

[rows, cols] = size(scalar_sub);
scalar1 = scalar_sub(1+offset:cols-offset, 1+offset:rows-offset);

X = 1:cols;
Y = 1:rows;

[X, Y] = meshgrid(1:cols, 1:rows);
X=X*2000;
Y=Y*2000;

% x방향으로 0.5m/s으로 가정
% 현재 1칸의 격자 2km/10min = 2000m/600sec = (10/3 m) / sec
% (10/3m) * 0.15 / sec = 0.5m/sec

u=0.5; % m/s
v=-0.5;
dt=10*60; % second

dx=u*dt;
dy=v*dt;

moveX = X + dx;
moveY = Y + dy;

scalar_sub_interp = griddata(moveX, moveY, scalar_sub, X, Y, 'v4');


scalar2 = scalar_sub_interp(1+offset:cols-offset, 1+offset:rows-offset);
data1 = struct('sst', scalar2);


save("C:\Users\min\Desktop\여름연구\OpticalFlow\new\ground_truth\data\griddata\scalar2.mat",'-struct', 'data1');