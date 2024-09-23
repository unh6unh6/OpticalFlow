% save sst sample

filename = "C:\Users\민경윤\Desktop\여름연구\OpticalFlow\new\nc_file\gk2a_ami_le2_sst_ko020lc_202405122110.nc";
sst = readImage(filename, "/SST");

%range
minX = 471;
maxX = 490;
minY = 611;
maxY = 630;

sst = sst(minX:maxX, minY:maxY);

save("C:\Users\민경윤\Desktop\여름연구\OpticalFlow\new\data\2110.mat", "sst");


%% function

function sst_image = readImage(filename, variable)
    sst_image = ncread(filename, variable);
    sst_image = rot90(sst_image);
end