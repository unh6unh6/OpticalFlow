% save sst sample

filename = "C:\Users\min\Desktop\여름연구\OpticalFlow\ground_truth\nc_file\gk2a_ami_le2_sst_ko020lc_202405122110.nc";
sst = readImage(filename, "/SST");

%range
minX = 471;
maxX = 490;
minY = 611;
maxY = 630;

sst_fit_area = sst(minX:maxX, minY:maxY);
data1 = struct('sst', sst_fit_area);
save("C:\Users\min\Desktop\여름연구\OpticalFlow\ground_truth\data\scalar1.mat",'-struct', 'data1');


flow_velocity = 5;
sst_with_sub_area = sst(minX-flow_velocity:maxX+flow_velocity, minY-flow_velocity:maxY+flow_velocity);
data2 = struct('sst', sst_with_sub_area);
save("C:\Users\min\Desktop\여름연구\OpticalFlow\ground_truth\data\scalar1_with_sub_area.mat",'-struct', 'data2');


%% function

function sst_image = readImage(filename, variable)
    sst_image = ncread(filename, variable);
    sst_image = rot90(sst_image);
end