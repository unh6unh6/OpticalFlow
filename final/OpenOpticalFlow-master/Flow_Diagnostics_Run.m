%% This is the main program for extraction of velocity field from a pair of
%% flow visualization images
%% Copyrights by Tianshu Liu
%% Department of Mechanical and Aerospace Engineering,
%% Western Michigan University, Kalamazoo, MI, USA

clear all;
close all;
clc;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Read a pair of images
%% For 12, 14 and 14 bit images, they should be converted to 8 bit images
%% befor optical flow computation

%Im1=imread('White_oval_1.tif');
%Im2=imread('White_Oval_2.tif');

% Im1=imread('vortex_pair_particles_1.tif');
% Im2=imread('vortex_pair_particles_2.tif');


% Im1=imread('2D_vortices_1.tif');
% Im2=imread('2D_vortices_2.tif');

%{
Im1=imread('C:\Users\민경윤\Desktop\여름연구\OpticalFlow\final\image\gk2a_ami_le2_sst_ko020lc_202405122100.tif');
Im2=imread('C:\Users\민경윤\Desktop\여름연구\OpticalFlow\final\image\gk2a_ami_le2_sst_ko020lc_202405122110.tif');

Im1 = rgb2gray(Im1);
Im2 = rgb2gray(Im2);
%}


%Im1 = load("C:\Users\민경윤\Desktop\여름연구\OpticalFlow\final\value_data\gk2a_ami_le2_sst_ko020lc_202405122150.mat").sst_image;
%Im2 = load("C:\Users\민경윤\Desktop\여름연구\OpticalFlow\final\value_data\gk2a_ami_le2_sst_ko020lc_202405122200.mat").sst_image;



%{
Im1 = load("C:\Users\민경윤\Desktop\여름연구\OpticalFlow\new\data\2100.mat").sst;
Im2 = load("C:\Users\민경윤\Desktop\여름연구\OpticalFlow\new\data\2110.mat").sst;
%}

%% 고해상도 interpolation

%{
Im1 = load("C:\Users\민경윤\Desktop\여름연구\OpticalFlow\new\ground_truth\data\scalar1_interp.mat").sst;
Im2 = load("C:\Users\민경윤\Desktop\여름연구\OpticalFlow\new\ground_truth\data\GT_scalar2.mat").sst;
%}


%% griddata interpolation

Im1 = load("C:\Users\민경윤\Desktop\여름연구\OpticalFlow\new\ground_truth\data\griddata\scalar1.mat").sst;
Im2 = load("C:\Users\민경윤\Desktop\여름연구\OpticalFlow\new\ground_truth\data\griddata\scalar2.mat").sst;

%%
%Im1 = load("C:\Users\민경윤\Desktop\여름연구\OpticalFlow\new\test\1.mat").scalar1;
%Im2 = load("C:\Users\민경윤\Desktop\여름연구\OpticalFlow\new\test\2.mat").scalar2;
%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Set the Parameters for Optical Flow Computation

%% Set the lagrange multipleirs in optical computation 
lambda_1=20;  % the Horn_schunck estimator for initial field
lambda_2=2000; % the Liu-Shen estimator for refined estimation

%% Number of iterations in the coarse-to-fine iterative process from
%% initial estimation, "0" means no iteration
no_iteration=1; 

%% Initial coarse field estimation in the coarse-to-fine iterative process,
%% scale_im is a scale factor for down-sizing of images
scale_im=0.5; 


%% For Image Pre-Processing

%% For local illumination intensity adjustment, To bypass it, set size_average = 0
size_average=20; % in pixels

%% Gausian filter size for removing random noise in images
size_filter=4; % in pixels

%% Selete a region for processing (index_region = 1) otherwise processing for the
%% whole image (index_region = 0)
index_region=0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%% Selete a region of interest for dognostics
Im1=double(Im1);
Im2=double(Im2);

if (index_region == 1)
    imagesc(uint8(Im1));
    colormap(gray);
    axis image;

    xy=ginput(2);
    x1=floor(min(xy(:,1)));
    x2=floor(max(xy(:,1)));
    y1=floor(min(xy(:,2)));
    y2=floor(max(xy(:,2)));
    I1=double(Im1(y1:y2,x1:x2)); 
    I2=double(Im2(y1:y2,x1:x2));
elseif (index_region == 0)
    I1=Im1;
    I2=Im2;
end

I1_original=I1;
I2_original=I2;


%% correcting the global and local intensity change in images
[m1,n1]=size(I1);
window_shifting=[1;n1;1;m1]; % [x1,x2,y1,y2] deines a rectangular window for global correction
[I1,I2]=correction_illumination(I1,I2,window_shifting,size_average);


%% pre-processing for reducing random noise,
%% and downsampling images if displacements are large
[I1,I2] = pre_processing_a(I1,I2,scale_im,size_filter);

I_region1=I1;
I_region2=I2;


%% initial optical flow calculation for a coarse-grained velocity field
%% (ux0,uy0)
[ux0,uy0,vor,ux_horn,uy_horn,error1]=OpticalFlowPhysics_fun(I_region1,I_region2,lambda_1,lambda_2);
% ux is the velocity (pixels/unit time) in the image x-coordinate (from the left-up corner to right)
% uy is the velocity (pixels/unit time) in the image y-coordinate (from the left-up corner to bottom)


%% generate the shifted image from Im1 based on the initial coarse-grained velocity field (ux0, uy0),
%% and then calculate velocity difference for iterative correction
Im1=uint8(I1_original);
Im2=uint8(I2_original);

ux_corr=ux0;
uy_corr=uy0;

%% estimate the displacement vector and make correction in iterations

k=1;
while k<=no_iteration
    [Im1_shift,uxI,uyI]=shift_image_fun_refine_1(ux_corr,uy_corr,Im1,Im2);
    
    I1=double(Im1_shift);
    I2=double(Im2);
    
    size_filter_1=2;
    [I1,I2] = pre_processing_a(I1,I2,1,size_filter_1);
    
    % calculation of correction of the optical flow 
    [dux,duy,vor,dux_horn,duy_horn,error2]=OpticalFlowPhysics_fun(I1,I2,lambda_1,lambda_2);

    % refined optical flow
    ux_corr=uxI+dux;
    uy_corr=uyI+duy;
    
    
    k=k+1;
end

%% refined velocity field
ux=ux_corr;    %%%%%
uy=uy_corr;    %%%%%

%% show the images and processed results
%% plot the images, velocity vector, and streamlines in the initail and
%% refined estimations
%plots_set_1;

%% plot the fields of velocity magnitude, vorticity and the second invariant Q
%plots_set_2;


%save('C:\Users\민경윤\Desktop\여름연구\OpticalFlow\new\data\calc_vector_field.mat', 'ux', 'uy');
save('C:\Users\민경윤\Desktop\여름연구\OpticalFlow\new\ground_truth\data\calc_vector_field.mat', 'ux', 'uy');

%{
figure();
gx=50; offset=1;
h = vis_flow (ux, uy, gx, offset, 5, 'm');
set(h, 'Color', 'red');
xlabel('x (pixels)');
ylabel('y (pixels)');
axis image;
set(gca,'YDir','reverse');
title('Refined Velocity Field');

saveas(gcf, 'C:\Users\민경윤\Desktop\여름연구\OpticalFlow\final\vector_field_3\velocity_field5.png');

fig = gcf;
frame = getframe(fig);
save("C:\Users\민경윤\Desktop\여름연구\OpticalFlow\final\vector_field_3\velocity_field5.mat", 'frame');
%}








