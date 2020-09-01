% Small infrared target detection using absolute average difference weighted by cumulative directional derivatives
clc;
clearvars;
close all;
cflag = 1;
flag = 0;
wflag = 0;
channel = 1;
readimg;
for kk = 23
    fold = 'C:\Users\a''su''s\Desktop\数据集\数据集\数据集3\';
    try
        img = imread([fold, num2str(kk), '.jpg']);
    catch
        img = imread([fold, num2str(kk), '.bmp']);
    end
    img = img(:, :, 1);
    re = admdfunc(img, 1);
    bw = bwfunc(re);
    if wflag
        refold = 'C:/Users/a''su''s/Desktop/数据集/数据集/数据集3/admd/';
        if ~exist(refold, 'dir')
            mkdir(refold);
        end
        imwrite(uint8(img), [refold, num2str(kk), '1.png']);
        imwrite(uint8( mat2gray(re) * 255), [refold, num2str(kk), '2.png']);
        imwrite(bw, [refold, num2str(kk), '3.png']);
    end
end
