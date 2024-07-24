% optical flow test with liu

clearvars;
vidReader = VideoReader('test.mp4', 'CurrentTime', 11);

lambda = 1; % 정규화 파라미터
tol = 1e-1; % 허용 오차
maxnum = 10; % 최대 반복 횟수

h = figure;
movegui(h);
hViewPanel = uipanel(h, 'Position', [0 0 1 1], 'Title', 'Plot of Optical Flow Vectors');
hPlot = axes(hViewPanel);

if hasFrame(vidReader)
    frameRGB1 = readFrame(vidReader);
    frameGray1 = im2gray(frameRGB1);
end

while hasFrame(vidReader)
    frameRGB2 = readFrame(vidReader);
    frameGray2 = im2gray(frameRGB2);
    
    [Ix, Iy] = imgradientxy(double(frameGray1));
    It = double(frameGray2) - double(frameGray1);

    [u, v] = horn_schunk_estimator(Ix, Iy, It, lambda, tol, maxnum);

    imshow(frameRGB2, 'Parent', hPlot);
    hold(hPlot, 'on');
    quiver(hPlot, u, v, 5, 'r');
    hold(hPlot, 'off');
    pause(1/vidReader.FrameRate);
    
    frameGray1 = frameGray2;
end
