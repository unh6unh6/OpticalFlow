%% Draw vector field
GT_vector_field = load("data\GT_vector_field.mat");
OF_vector_field = load("data\OF_vector_field.mat");

[x_size, y_size] = size(GT_vector_field.ux);

[x, y] = meshgrid(1:x_size, 1:y_size);

%% GT벡터

figure;
quiver(x, y, GT_vector_field.ux, GT_vector_field.uy);
axis equal;
xlabel('X-axis');
ylabel('Y-axis');
title('Ground Truth Vector Field');
grid on;

%% OF벡터

figure;
quiver(x, y, OF_vector_field.ux, OF_vector_field.uy);
axis equal;
xlabel('X-axis');
ylabel('Y-axis');
title('Optical Flow Vector Field');
grid on;

%% GT벡터, OF벡터 같이

figure;
quiver(x, y, GT_vector_field.ux, GT_vector_field.uy);
axis equal;
xlabel('X-axis');
ylabel('Y-axis');
title('Ground Truth Vector Field');
grid on;

hold on;
quiver(x, y, OF_vector_field.ux, OF_vector_field.uy);
axis equal;
xlabel('X-axis');
ylabel('Y-axis');
title('Optical Flow Vector Field');
grid on;

%%
% 1. 속도와 방향에 따른 벡터의 정확도 정량화.. 벡터(방향, 크기)
% 2. m/s 단위로 변환하기.


