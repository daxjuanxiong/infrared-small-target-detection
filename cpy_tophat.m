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
    se = ones(5, 5);
    imge = imerode(img, se);
    imgd = imdilate(imge, se);
    re = double(img) - double(imgd);
    if 1
        figure, imshow(img); title('img');
        figure, imshow(imge); title('erode');
        figure, imshow(imgd); title('imgd');
        figure, imshow(re, []); title('open');
    end
    %%
    % shape = 'disk'; %
    shape = 'square';
    radius =5;
    se=strel( shape , radius ) ;
    b1 = imopen(img , se );
    b2=  imclose(img,se);
    b=(b1+b2)/2;
    figure; imshow(b1, []); title('b1');
    figure; imshow(b2, []); title('b2');
    figure; imshow(b, []); title('b');
    re1= img-b1;
    re2= img-b2;
    re3= img-b;
    figure; imshow(re1,[]);
    figure; imshow(re2, []);
    figure; imshow(re3, []);
end
