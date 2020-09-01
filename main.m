clc;
clearvars;
close all;
flag = 0;
flagw = 1;
mm = 1;
for mm = 1:19 % 19 detection algorithm
    for kk = 1
        fold = '.\data\';% 27 images
        try
            img = imread([fold, num2str(kk), '.jpg']);
        catch
            img = imread([fold, num2str(kk), '.bmp']);
        end
        img = img(:,:,1);
        img = double(img);
        switch mm
            case 1
                method =  'lcm';
            case 2
                method =  'ilcm';
            case 3
                method =  'rlcm';
            case 4
                method =  'hbmlcm';
            case 5
                method =  'tllcm';
            case 6
                method =  'mpcm';
            case 7
                method =  'aagd';
            case 8
                method =  'admd';
            case 9
                method = 'wldmfunc';
            case 10
                method =  'mgdwe';
            case 11
                method =  'dlcm';
            case 12
                method =  'dgrad';
            case 13
                method =  'amwlcm';
            case 14
                method =  'lef';
            case 15
                method =  'tophat';
            case 16
                method =  'lr';
            case 17
                method =  'maxmed';
            case 18
                method =  'maxmean';
            case  19
                method = 'lig';
        end
        switch method
            case 'lcm'
                re = MLCM_fun(img);
            case 'ilcm'
                re = ILCM(img);
            case 'rlcm'
                re = RLCM(img);
            case 'hbmlcm'
                re = hbmlcmfunc(img); % 不适合点目标
            case 'tllcm'
                re = tllcm(img);
            case 'mpcm'
                re = MPCM_fun(img);
            case 'aagd'
                re = aadcddfunc(img);
            case 'admd'
                re = admdfunc(img);
            case 'wldmfunc'
                re = wldmfunc(img);
            case 'mgdwe'
                re = mgdwe(img);
            case 'dlcm';
                re = dlcmfunc(img);
            case 'dgrad'
                re = dgradfunc(img);
            case 'amwlcm'
                re = amwlcmfunc(img);
            case 'lef';
                re = leffunc(img);
            case 'tophat'
                re = tophatfunc(img, ones(5));
            case 'lr'
                re = lrfunc(img);
            case 'maxmed'
                re = maxMean(img, 5);% 最大均值滤波
            case 'maxmean'
                re = maxMean(img, 5);% 最大均值滤波
            case  'lig'
                re = LIG(img);
        end
        bw = bwfunc(re);
        if flag
            figure; imshow(uint8(img)); title('original image');
            figure; imshow(re, []); title('result image');
            figure; imshow(bw) ; title('binary image');
        end
        if flagw
            refold = ['.\result\', method, '\'];
            if exist(refold,'dir') == 0
                mkdir(refold);
            end
            imwrite(uint8(img), [refold, num2str(kk), '1.png']);
            imwrite(uint8( mat2gray(re) * 255), [refold, num2str(kk), '2.png']);
            imwrite(bw, [refold, num2str(kk), '3.png']);
        end
    end
end
