data1 = load("C:\Users\민경윤\Desktop\여름연구\OpticalFlow\final\value_data\gk2a_ami_le2_sst_ko020lc_202405122150.mat");
data2 = load("C:\Users\민경윤\Desktop\여름연구\OpticalFlow\final\value_data\gk2a_ami_le2_sst_ko020lc_202405122200.mat");

sst_image = (data1.sst_image + data2.sst_image) / 2;
save('C:\Users\민경윤\Desktop\여름연구\OpticalFlow\final\vector_field_3\mean_data\2155.mat', 'sst_image');

%%

