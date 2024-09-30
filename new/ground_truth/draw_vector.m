% draw vector field
gt_vector_field = load("data\GT_vector_field.mat");
calc_vector_field = load("data\calc_vector_field.mat");

[x1, y1] = size(gt_vector_field.ux);
size_of_scalar = x1;

[x, y] = meshgrid(1:size_of_scalar, 1:size_of_scalar);

figure;
quiver(x, y, gt_vector_field.ux, gt_vector_field.uy);
axis equal;
xlabel('X-axis');
ylabel('Y-axis');
title('Ground Truth Vector Field');
grid on;

figure;
quiver(x, y, calc_vector_field.ux, calc_vector_field.uy);
axis equal;
xlabel('X-axis');
ylabel('Y-axis');
title('Optical Flow Vector Field');
grid on;

%%

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