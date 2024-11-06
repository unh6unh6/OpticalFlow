%% Read SST Data
clearvars;

filename = "C:\Users\min\Desktop\여름연구\OpticalFlow\ground_truth\nc_file\gk2a_ami_le2_sst_ko020lc_202405122110.nc";
sst = readImage(filename, "/SST");

figure;
hold on;
pcolor(sst);
clim("auto");
shading flat;
axis on;

%% Set Range

% data1 range
  %{
minX = 471;
maxX = 490;
minY = 611;
maxY = 630;
  %}

% data2 range
%  %{
minX = 461 + 5;
maxX = 490 - 5;
minY = 161 + 5;
maxY = 190 - 5;
%  %}		
%% Save Scalar1.mat

sst_fit_area = sst(minX:maxX, minY:maxY);
data1 = struct('sst', sst_fit_area);
save("C:\Users\min\Desktop\여름연구\OpticalFlow\ground_truth\data\scalar1.mat",'-struct', 'data1');

%% pcolor Scalar1.mat

figure;
hold on;
pcolor(sst_fit_area);
clim("auto");
shading flat;
axis on;

%% Save Scalar1 with sub area.mat

offset = 5;
sst_with_sub_area = sst(minX-offset:maxX+offset, minY-offset:maxY+offset);
data2 = struct('sst', sst_with_sub_area);
save("C:\Users\min\Desktop\여름연구\OpticalFlow\ground_truth\data\scalar1_with_sub_area.mat",'-struct', 'data2');


%% function

function sst_image = readImage(filename, variable)
    sst_image = ncread(filename, variable);
    sst_image = rot90(sst_image);
end