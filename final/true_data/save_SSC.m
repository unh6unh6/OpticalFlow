fileList = fopen('fileList.txt', 'r');

minX = 471;
maxX = 670;
minY = 611;
maxY = 810;

while ~feof(fileList)
    tline = fgetl(fileList);
    if tline == "00"
        continue;
    end
    disp(tline);
    ssc_direction = readImage(tline, "/direction");
    ssc_speed = readImage(tline, "/speed");


    % 영역 선택
    ssc_direction = ssc_direction(minX:maxX, minY:maxY);
    ssc_speed = ssc_speed(minX:maxX, minY:maxY);


    save_filename = tline(1:strfind(tline, ".nc")-1);
    save_filename = strcat(save_filename, '.mat'); % tif <-> mat

    savepath = "./value_data";
    if ~exist(savepath, 'dir')
            mkdir(savepath);
    end
    save(fullfile(savepath, save_filename), 'ssc_direction', 'ssc_speed');

end

function ssc_image = readImage(filename, variable)
    ssc_image = ncread(filename, variable);
    ssc_image = rot90(ssc_image);
end
