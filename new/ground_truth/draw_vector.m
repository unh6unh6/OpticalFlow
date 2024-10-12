% draw vector field
gt_vector_field = load("data\GT_vector_field.mat");
calc_vector_field = load("data\calc_vector_field.mat");

[x1, y1] = size(gt_vector_field.ux);
size_of_scalar = 20;

[x, y] = meshgrid(1:size_of_scalar, 1:size_of_scalar);

%% GT벡터

figure;
quiver(x, y, gt_vector_field.ux, gt_vector_field.uy);
axis equal;
xlabel('X-axis');
ylabel('Y-axis');
title('Ground Truth Vector Field');
grid on;

%% OF벡터

figure;
quiver(x, y, calc_vector_field.ux, calc_vector_field.uy);
axis equal;
xlabel('X-axis');
ylabel('Y-axis');
title('Optical Flow Vector Field');
grid on;

%% GT벡터, OF벡터 같이

figure;
quiver(x, y, gt_vector_field.ux, gt_vector_field.uy);
axis equal;
xlabel('X-axis');
ylabel('Y-axis');
title('Ground Truth Vector Field');
grid on;

hold on;
quiver(x, y, calc_vector_field.ux, calc_vector_field.uy);
axis equal;
xlabel('X-axis');
ylabel('Y-axis');
title('Optical Flow Vector Field');
grid on;

%% scalar1, scalar2 interp

Im1_interp = load("C:\Users\민경윤\Desktop\여름연구\OpticalFlow\new\ground_truth\data\scalar1_interp.mat").sst;
Im2_interp = load("C:\Users\민경윤\Desktop\여름연구\OpticalFlow\new\ground_truth\data\GT_scalar2.mat").sst;

figure;
pcolor(Im1_interp);
clim("auto");
shading flat;
axis tight;
title('Scalar1');


figure;
pcolor(Im2_interp);
clim("auto");
shading flat;
axis tight;
title('Scalar2');


