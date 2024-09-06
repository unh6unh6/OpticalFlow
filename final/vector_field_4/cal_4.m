vel1 = load("C:\Users\민경윤\Desktop\여름연구\OpticalFlow\final\vector_field_3\velocity4.mat");
vel2 = load("C:\Users\민경윤\Desktop\여름연구\OpticalFlow\final\vector_field_3\velocity5.mat");

ux = (vel1.ux + vel2.ux) / 2;
uy = (vel1.uy + vel2.uy) / 2;


save('C:\Users\민경윤\Desktop\여름연구\OpticalFlow\final\vector_field_4\velocity4.mat', 'ux', 'uy');

figure();
gx=50; offset=1;
h = vis_flow (ux, uy, gx, offset, 5, 'm');
set(h, 'Color', 'red');
xlabel('x (pixels)');
ylabel('y (pixels)');
axis image;
set(gca,'YDir','reverse');
title('Refined Velocity Field');

saveas(gcf, 'C:\Users\민경윤\Desktop\여름연구\OpticalFlow\final\vector_field_4\velocity_field4.png');

fig = gcf;
frame = getframe(fig);
save("C:\Users\민경윤\Desktop\여름연구\OpticalFlow\final\vector_field_4\velocity_field4.mat", 'frame');