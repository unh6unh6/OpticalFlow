% draw vector field
gt_vector_field = load("GT_vector_field.mat");
calc_vector_field = load("calc_vector_field.mat");


size_of_scalar = 20;

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