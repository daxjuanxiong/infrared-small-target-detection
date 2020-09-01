% High-Boost-Based Multiscale Local Contrast Measure for Infrared Small Target Detection
clc;
clearvars;
close all;
flag = 0;
wflag = 1;
channel = 1;
readimg;
for kk = 23
    fold = 'C:\Users\a''su''s\Desktop\数据集\数据集\数据集3\';
    try
        img = imread([fold, num2str(kk), '.jpg']);
    catch
        img = imread([fold, num2str(kk), '.bmp']);
    end
    img = img(:,:,1);
    rhb = hbmlcmfunc(img);
end