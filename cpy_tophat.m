clearvars;
clc
close all;
%%
for kk = 1
    fold = '.\data\';% 27 images
    try
        img = imread([fold, num2str(kk), '.jpg']);
    catch
        img = imread([fold, num2str(kk), '.bmp']);
    end
    %% 检测图像中的暗目标
    shape = 'square';  % shape = 'disk
    radius =5;
    se=strel( shape , radius) ;
    imge = imerode(img, se);
    imgd = imdilate(imge, se);
    re = double(img) - double(imgd);% 突出图像中的暗目标
    if 0
        figure, imshow(img); title('img');
        figure, imshow(imge); title('erode');
        figure, imshow(imgd); title('imgd');
        figure, imshow(re, []); title('open');
    end
    %%
    
    b1 = imopen(img , se );
    b2=  imclose(img,se);
    b = (double(b1)+ double(b2) )/2;
    re1= double(img) - double(b1);
    re2= double(img) - double(b2);
    re3= double(img) - double(b);
    if 0
        figure; imshow(b1, []); title('b1');
        figure; imshow(b2, []); title('b2');
        figure; imshow(b, []); title('b');
        figure; imshow(re1,[]);
        figure; imshow(re2, []);
        figure; imshow(re3, []);
    end
end
