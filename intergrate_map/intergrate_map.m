
% lambert_conformal_conic (WGS84)
sst = ncread("sst_sample.nc", "/SST")


% GEOS (WGS84)
chl = ncread("chl_sample.nc","/geophysical_data/Chl")

chl_lat = ncread("chl_sample.nc", '/navigation_data/latitude');
chl_lon = ncread("chl_sample.nc", '/navigation_data/longitude');


%%

lat_tl = 45.728965;  % 좌상단 위도
lon_tl = 113.996418; % 좌상단 경도

lat_tr = 45.728965;  % 우상단 위도
lon_tr = 138.003582; % 우상단 경도

lat_bl = 29.312252;  % 좌하단 위도
lon_bl = 116.753260; % 좌하단 경도

lat_br = 29.312252;  % 우하단 위도
lon_br = 135.246740; % 우하단 경도

% 그리드 크기 정의 (900x900)
n = 900; 

% 위도 보간
lat_grid = linspace(lat_tl, lat_bl, n); % 상단에서 하단까지 위도 보간
lat_grid = repmat(lat_grid', 1, n);     % 위도 그리드 생성

% 각 행별 경도 보간
lon_grid = zeros(n, n);

for i = 1:n
    lon_grid(i, :) = linspace(lon_tl + (lon_bl - lon_tl) * ((i-1)/(n-1)), ...
                              lon_tr + (lon_br - lon_tr) * ((i-1)/(n-1)), n);
end

%%


% chl 위경도00
+



% 좌상단 : 39.2856292724609 / 121.996467590332
% 우상단 : 30.6938247680664 / 122.698341369629
% 좌하단 : 39.2462501525879 / 130.405380249023
% 우하단 : 30.6690597534180 / 130.157409667969

%% chl 좌상단 in sst grid

chl_lat_lt = 39.2856292724609;
chl_lon_lt = 121.996467590332;
[min_value_lt, y_lt, x_lt] = find_min_distance(lat_grid, lon_grid, chl_lat_lt, chl_lon_lt);
min_value_lt
x_lt
y_lt

% (286, 354)


%% chl 우상단 in sst grid

chl_lat_rt = 30.6938247680664;
chl_lon_rt = 122.698341369629;
[min_value_rt, y_rt, x_rt] = find_min_distance(lat_grid, lon_grid, chl_lat_rt, chl_lon_rt);
min_value_rt
x_rt
y_rt

% (294, 824)

%% chl 좌하단 in sst grid

chl_lat_lb = 39.2462501525879;
chl_lon_lb = 130.405380249023;
[min_value_lb, y_lb, x_lb] = find_min_distance(lat_grid, lon_grid, chl_lat_lb, chl_lon_lb);
min_value_lb
x_lb
y_lb

% (632, 356)

%% chl 우하단 in sst grid

chl_lat_rb = 30.6690597534180;
chl_lon_rb = 130.157409667969;
[min_value_rb, y_rb, x_rb] = find_min_distance(lat_grid, lon_grid, chl_lat_rb, chl_lon_rb);
min_value_rb
x_rb
y_rb

% (648, 826)

%%

function [min_value, y, x] = find_min_distance(lat_grid, lon_grid, target_lat, target_lon)
    % 차이 계산
    lat_diff = lat_grid - target_lat;
    lon_diff = lon_grid - target_lon;

    % 거리 계산
    distances = sqrt(lat_diff.^2 + lon_diff.^2);

    % 최소값과 그 인덱스 계산
    [min_value, linear_index] = min(distances(:)); 

    % 인덱스를 2차원으로 변환
    [y, x] = ind2sub(size(distances), linear_index);
end

%%