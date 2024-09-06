window_size = 200;

filename = "gk2a_ami_le2_sst_ko020lc_202405122100.nc";
data1 = ncread(filename, '/SST');
data1 = rot90(data1);

filename2 = "gk2a_ami_le2_sst_ko020lc_202405122110.nc";
data2 = ncread(filename2, '/SST');
data2 = rot90(data2);

result = zeros(300*300,7);

result_index = 1;

start = 1;
step = 10;
for i = start:step:900 - window_size
    for j = start:step:900 - window_size
        minY = i;
        maxY = i + window_size-1;
        minX = j;
        maxX = j + window_size-1;

        data1_sub = data1(minX:maxX, minY:minY+window_size-1);
        data2_sub = data2(minX:maxX, minY:minY+window_size-1);

        data1_isValid = not(isnan(data1_sub));
        data2_isValid = not(isnan(data2_sub));

        data1_valid_size = size(find(data1_isValid));
        data2_valid_size = size(find(data2_isValid));
        data1_valid_percent = (data1_valid_size(1) / (window_size^2) ) * 100;
        data2_valid_percent = (data2_valid_size(1) / (window_size^2) ) * 100;

        intersect_valid = find(data1_isValid & data2_isValid);
        valid_percent = ( size(intersect_valid,1) / (window_size^2) ) * 100;

        deviation = mean([nanmax(data1_sub(:)) - nanmin(data1_sub(:)), nanmax(data2_sub(:)) - nanmin(data2_sub(:))]);

        result(result_index, 1) = minX;
        result(result_index, 2) = maxX;
        result(result_index, 3) = minY;
        result(result_index, 4) = maxY;
        result(result_index, 5) = valid_percent;
        result(result_index, 6) = data1_valid_percent(1);
        result(result_index, 7) = data2_valid_percent(1);
        result(result_index, 8) = deviation;

        result_index = result_index+1;

        %subplot(1,2,1);imagesc(data1_sub);axis equal;colorbar;
        %subplot(1,2,2);imagesc(data2_sub);axis equal;colorbar;
        %sgtitle([num2str(data1_valid_percent),'/',num2str(data2_valid_percent),'/',num2str(valid_percent)])
        %pause(0.01);

        %saveas(gcf,['./test/test',num2str(result_index),'.jpg']);
        %if(j == start+5)
        %    break;
        %end
    end
    %break;
end

%exists = any(result,2);
%result = sortrows(result(exists,:), 5, 'descend');

result_table = array2table(result, "VariableNames", ["minX","maxX","minY","maxY","valid_percent", "data1_valid_percent","data2_valid_percent", "deviation"]);
