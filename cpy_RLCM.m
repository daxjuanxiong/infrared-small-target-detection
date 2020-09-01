% Infrared small target detection utilizing the multiscale relative local contrast measure
clc;
clearvars;
close all;
for kk = 1
    fold = '.\data\';% 27 images
    try
        img = imread([fold, num2str(kk), '.jpg']);
    catch
        img = imread([fold, num2str(kk), '.bmp']);
    end
    img = img(:,:,1);
    out= RLCM(img);
    figure, imshow(img);
    figure, imshow(out, []);
    figure, surf(out);
end