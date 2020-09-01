% 2016 Multiscale patch-based contrast measure for small infrared target detection
clearvars;
close all;
clc;
flag = 1;
wflag = 0;
channel = 1;
readimg;
for kk = 1
    fold = 'C:\Users\a''su''s\Desktop\数据集\数据集\数据集3\';
    try
        img = imread([fold, num2str(kk), '.jpg']);
    catch
        img = imread([fold, num2str(kk), '.bmp']);
    end
img = double(img);
re = MPCM_fun(img, 1);
bw = bwfunc(re);
if flag
    figure; imshow(re, []);
    figure; surf(re);
    xlabel('x');
    ylabel('y');
    figure; imshow(bw);
end
if wflag
    refold = 'C:\Users\a''su''s\Desktop\rempcm\';
    imwrite(uint8(img), [refold, num2str(kk), '1.png']);
    imwrite(uint8( mat2gray(re) * 255), [refold, num2str(kk), '2.png']);
    imwrite(bw, [refold, num2str(kk), '3.png']);
end
end

