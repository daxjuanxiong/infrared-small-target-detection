%  Tiny and Dim Infrared Target Detection Based on Weighted Local Contrast
clearvars;
close all;
clc;
flag = 0;
wflag = 1;
channel = 1;
readimg;
for kk = 1:25
    fold = 'C:\Users\a''su''s\Desktop\数据集\数据集\数据集3\';
    try
        img = imread([fold, num2str(kk), '.jpg']);
    catch
        img = imread([fold, num2str(kk), '.bmp']);
    end
    img = img(:,:,1);
    re = amwlcmfunc(img);
    bw = bwfunc(re);
    if flag
        figure; imshow(re, []);
        figure; imshow(bw);
    end
    if wflag
        refold = 'C:/Users/a''su''s/Desktop/数据集/数据集/数据集3/awlcm/'
        if ~exist(refold, 'dir')
            mkdir(refold);
        end
        imwrite(uint8(img), [refold, num2str(kk), '1.png']);
        imwrite(uint8( mat2gray(re) * 255), [refold, num2str(kk), '2.png']);
        imwrite(bw, [refold, num2str(kk), '3.png']);
    end
end
