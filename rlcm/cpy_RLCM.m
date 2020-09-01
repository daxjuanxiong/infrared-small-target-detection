% Infrared small target detection utilizing the multiscale relative local contrast measure
clc;
clearvars;
close all;
channel = 1;
readimg;
img = img(:,:,1);
out= RLCM(img);
figure, imshow(img);
figure, imshow(out, []);
figure, surf(out);