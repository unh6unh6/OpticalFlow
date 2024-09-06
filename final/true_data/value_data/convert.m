% 방향과 속도 데이터 불러오기
data = load("C:\Users\민경윤\Desktop\여름연구\OpticalFlow\final\true_data\value_data\gk2a_ami_le2_ssc_ko020lc_202405122200.mat");
direction = data.ssc_direction;
speed = data.ssc_speed;

% ux와 uy 계산
ux = speed .* cosd(direction); % x 성분
uy = speed .* sind(direction); % y 성분


save('C:\Users\민경윤\Desktop\여름연구\OpticalFlow\final\true_data\value_data\cal_data\velocity7.mat', 'ux', 'uy');

figure();
gx=50; offset=1;
h = vis_flow (ux, uy, gx, offset, 5, 'm');
set(h, 'Color', 'red');
xlabel('x (pixels)');
ylabel('y (pixels)');
axis image;
set(gca,'YDir','reverse');
title('Refined Velocity Field');

saveas(gcf, 'C:\Users\민경윤\Desktop\여름연구\OpticalFlow\final\true_data\value_data\cal_data\velocity_field7.png');

fig = gcf;
frame = getframe(fig);
save("C:\Users\민경윤\Desktop\여름연구\OpticalFlow\final\true_data\value_data\cal_data\velocity_field7.mat", 'frame');