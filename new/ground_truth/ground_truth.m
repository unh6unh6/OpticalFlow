%% load Scalar1
scalar1 = load("C:\Users\민경윤\Desktop\여름연구\OpticalFlow\new\ground_truth\data\scalar1_interp.mat").sst;
scalar1_with_sub_area = load("C:\Users\민경윤\Desktop\여름연구\OpticalFlow\new\ground_truth\data\scalar1_with_sub_area_interp.mat").sst;

%%  ground truth vector field (uniform flow)

% Set parameters
[x1, y1] = size(scalar1);
[x2, y2] = size(scalar1_with_sub_area);
offset = (x2 - x1)/2;
size_of_scalar = x1;

flow_velocity = 1; % step / pixel
flow_direction_deg = 0;

% Calculate Ux, Uy field
flow_direction_rad = deg2rad(flow_direction_deg);
ux = flow_velocity * cos(flow_direction_rad) * ones(size_of_scalar); % 모든 값이 flow_velocity인 ux
uy = flow_velocity * sin(flow_direction_rad) * ones(size_of_scalar); % 모든 값이 flow_velocity인 uy

save('C:\Users\민경윤\Desktop\여름연구\OpticalFlow\new\ground_truth\data\GT_vector_field.mat', 'ux', 'uy');


%% ground truth Scalar2

scalar2 = zeros(size_of_scalar);
is_visit = zeros(size_of_scalar);

for i = 1:size_of_scalar
    for j = 1:size_of_scalar

        prev_i = i + round(uy(i, j)) + offset;
        prev_j = j - round(ux(i, j)) + offset;

        scalar2(i, j) = scalar1_with_sub_area(prev_i, prev_j);
    %{

        new_i = round(i - uy(i, j));
        new_j = round(j + ux(i, j));

        if new_i >= 1 && new_i <= size_of_scalar && new_j >= 1 && new_j <= size_of_scalar
            scalar2(new_i, new_j) = scalar1(i, j);
            is_visit(new_i, new_j) = true;
        end
    %}

    end
end

%{
for i = 1:size_of_scalar
    for j = 1:size_of_scalar
        if ~is_visit(i,j)
            scalar2(i, j) = NaN;
        end
    end
end
%}


data = struct('sst', scalar2);
save('C:\Users\민경윤\Desktop\여름연구\OpticalFlow\new\ground_truth\data\GT_scalar2.mat', '-struct', 'data');