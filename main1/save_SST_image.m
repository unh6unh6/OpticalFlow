
clc;
%clearvars;

fileList = fopen('fileList.txt', 'r');

minX = 521;
maxX = 550;
minY = 181;
maxY = 210;

while ~feof(fileList)
    tline = fgetl(fileList);
    if tline == "00"
        continue;
    end
    disp(tline);
    sst_image = readImage(tline, "/SST");

    % 영역 선택
    sst_image = sst_image(minX:maxX, minY:maxY);

    save_filename = tline(1:strfind(tline, ".nc")-1);
    save_filename = strcat(save_filename, '.png');

    savepath = "./image";
    if ~exist(savepath, 'dir')
            mkdir(savepath);
    end
    plotAndSaveSSTImage(sst_image, fullfile(savepath, save_filename))
end


%sst_image = ncread("gk2a_ami_le2_sst_ko020lc_202407200410.nc", "/SST");
function sst_image = readImage(filename, variable)
    sst_image = ncread(filename, variable);
    sst_image = rot90(sst_image);
end


%{
histogram(sst_image);

minVal = min(sst_image(:))
maxVal = max(sst_image(:))

diff = maxVal - minVal;

colorMin = minVal * 1;
colorMax = maxVal * 1;
%}


function plotAndSaveSSTImage(sst_image, outputFilename)
    figure;
    hold on;
    pcolor(sst_image);
    %clim([colorMin colorMax]); 
    clim("auto");
    shading flat;
    axis off;
    saveas(gcf, outputFilename);
end


