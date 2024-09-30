%interpolation

scalar = load("C:\Users\민경윤\Desktop\여름연구\OpticalFlow\new\ground_truth\data\scalar1").sst;
scalar_interp = make_interp_data(scalar);
scalar_sub = load("C:\Users\민경윤\Desktop\여름연구\OpticalFlow\new\ground_truth\data\scalar1_with_sub_area.mat").sst;
scalar_sub_interp = make_interp_data(scalar_sub);

data1 = struct('sst', scalar_interp);
save("C:\Users\민경윤\Desktop\여름연구\OpticalFlow\new\ground_truth\data\scalar1_interp.mat",'-struct', 'data1');

data2 = struct('sst', scalar_sub_interp);
save("C:\Users\민경윤\Desktop\여름연구\OpticalFlow\new\ground_truth\data\scalar1_with_sub_area_interp.mat",'-struct', 'data2');


function scalar_interp = make_interp_data(scalar)
    [rows, cols] = size(scalar);

    X = 1:cols;
    Y = 1:rows;

    [Xq, Yq] = meshgrid(1:0.1:cols, 1:0.1:rows);

    scalar_interp = interp2(X, Y, scalar, Xq, Yq, 'cubic');

    figure;
    pcolor(scalar);
    clim("auto");
    shading flat;
    axis tight;

    figure;
    pcolor(scalar_interp);
    clim("auto");
    shading flat;
    axis tight;
end