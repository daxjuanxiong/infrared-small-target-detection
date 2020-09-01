% Small infrared target detection using absolute average difference weighted by cumulative directional derivatives
clc;
clearvars;
close all;
wflag = 1;
for kk = 1
    fold = '.\data\';% 27 images
    try
        img = imread([fold, num2str(kk), '.jpg']);
    catch
        img = imread([fold, num2str(kk), '.bmp']);
    end
    img = img(:,:,1);
    re = admdfunc(img);
    bw = bwfunc(re);
    if wflag
        refold = '.\';
        if ~exist(refold, 'dir')
            mkdir(refold);
        end
        imwrite(uint8(img), [refold, num2str(kk), '1.png']);
        imwrite(uint8( mat2gray(re) * 255), [refold, num2str(kk), '2.png']);
        imwrite(bw, [refold, num2str(kk), '3.png']);
    end
end
