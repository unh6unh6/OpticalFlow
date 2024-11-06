window_size = 30;

filename = "C:\Users\min\Desktop\여름연구\OpticalFlow\ground_truth\nc_file\gk2a_ami_le2_sst_ko020lc_202405122110.nc";
data = ncread(filename, '/SST');
data = rot90(data);

result = zeros(300*300,5);

result_index = 1;

start = 1;
step = 10;
for i = start:step:900 - window_size
    for j = start:step:900 - window_size
        minY = i;
        maxY = i + window_size-1;
        minX = j;
        maxX = j + window_size-1;

        data_sub = data(minX:maxX, minY:minY+window_size-1);

        data_isValid = not(isnan(data_sub));

        data_valid_size = size(find(data_isValid));

        data_valid_percent = (data_valid_size(1) / (window_size^2) ) * 100;

        result(result_index, 1) = minX;
        result(result_index, 2) = maxX;
        result(result_index, 3) = minY;
        result(result_index, 4) = maxY;
        result(result_index, 5) = data_valid_percent(1);

        result_index = result_index+1;

    end
end


result_table = array2table(result, "VariableNames", ["minX","maxX","minY","maxY", "data_valid_percent"]);
