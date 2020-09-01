%  Infrared small target detection via line-based reconstruction and entropy-induced suppression
clearvars;
close all;
clc;
flag = 1;
wflag = 1;
channel = 1;
readimg;
for kk = 1
    fold = '.\data\';% 27 images
    try
        img = imread([fold, num2str(kk), '.jpg']);
    catch
        img = imread([fold, num2str(kk), '.bmp']);
    end
    img = img(:,:,1);
    img = double(img);
    img = ones(500, 500);
    img(:, 1:250) = 100;
    img(:, 251:end) = 180;
    img(100:104, 100:104) = 100 +100* fspecial('gaussian', [5, 5]);
    img = img(:,:,1);
    [ re, re1, re2] = lrfunc(img);
    bw = bwfunc(re);
    if flag
        figure; imshow(uint8(img));
        figure; mesh(img);
        figure; imshow(re, []);
        figure; imshow(re1, []);
        figure; imshow(re2, []);
    end
    if wflag
        refold = '.\'
        if ~exist(refold, 'dir')
            mkdir(refold);
        end
        imwrite(uint8(img), [refold, num2str(kk), '1.png']);
        imwrite(uint8( mat2gray(re) * 255), [refold, num2str(kk), '2.png']);
        imwrite(bw, [refold, num2str(kk), '3.png']);
    end
end
