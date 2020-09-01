% Small infrared target detection using absolute average difference weighted by cumulative directional derivatives
clc;
clearvars;
close all;
%%
flag = 1;
for kk = 1
    fold = '.\data\';% 27 images
    try
        img = imread([fold, num2str(kk), '.jpg']);
    catch
        img = imread([fold, num2str(kk), '.bmp']);
    end
    img = img(:,:,1);
    img = double(img);
    % internal and external windows sizing
    bnhood = 19;
    tnhood3 = 3;
    tnhood5 = 5;
    tnhood7 = 7;
    tnhood9 = 9;
    Nb=bnhood*bnhood;
    N3=tnhood3*tnhood3;
    N5=tnhood5*tnhood5;
    N7=tnhood7*tnhood7;
    N9=tnhood9*tnhood9;
    Ndiff3=Nb-N3;
    Ndiff5=Nb-N5;
    Ndiff7=Nb-N7;
    Ndiff9=Nb-N9;
    mask31= zeros(5,5);
    mask32= zeros(5,5);
    mask33= zeros(5,5);
    mask34= zeros(5,5);
    
    mask31(2:3, 3)=1;
    mask31(1,3)=-2;
    
    mask32(3, 3:4)=1;
    mask32(3, 5)=-2;
    
    mask33(3:4, 3)=1;
    mask33(5, 3)=-2;
    
    mask34(3, 2:3)=1;
    mask34(3, 1)=-2;
    
    mask51= zeros(7,7);
    mask52= zeros(7,7);
    mask53= zeros(7,7);
    mask54= zeros(7,7);
    
    mask51(2:4, 4)=1;
    mask51(1, 4)=-3;
    
    mask52(4, 4:6)=1;
    mask52(4, 7)=-3;
    
    mask53(4:6, 4)=1;
    mask53(7, 4)=-3;
    
    mask54(4, 2:4)=1;
    mask54(4, 1)=-3;
    
    mask71= zeros(9,9);
    mask72= zeros(9,9);
    mask73= zeros(9,9);
    mask74= zeros(9,9);
    
    mask71(2:5, 5)=1;
    mask71(1, 5)=-4;
    
    mask72(5, 5:8) =1;
    mask72(5, 9) =-4;
    
    mask73(5:8, 5)=1;
    mask73(9,5)=-4;
    
    mask74(5, 2:5)=1;
    mask74(5, 1)=-4;
    
    mask91= zeros(11,11);
    mask92= zeros(11,11);
    mask93= zeros(11,11);
    mask94= zeros(11,11);
    
    mask91(2:6, 6)=1;
    mask91(1, 6)=-5;
    
    mask92(6, 6:10)=1;
    mask92(6, 11)=-5;
    
    mask93(6:10, 6)=1;
    mask93(11, 6)=-5;
    
    mask94(6, 2:6)=1;
    mask94(6, 1)=-5;
    
    % mean value calculation for internal window for all scales
    mu3 = imfilter(img, fspecial('average', tnhood3), 'replicate');
    mu5 = imfilter(img, fspecial('average', tnhood5), 'replicate');
    mu7 = imfilter(img, fspecial('average', tnhood7), 'replicate');
    mu9 = imfilter(img, fspecial('average', tnhood9), 'replicate');
    % mean value calculation for external window
    mub = imfilter(img, fspecial('average', bnhood), 'replicate');
    if flag
        figure, imshow(mu3, []); title('mu3');
        figure, imshow(mu5, []); title('mu5');
        figure, imshow(mu7, []); title('mu7');
        figure, imshow(mu9, []); title('mu9');
        figure, imshow(mub, []); title('mub');
    end
    %%  constructing ADM_prop and CDD in  3by3 scale
    mun3=N3*mu3;
    mub=Nb*mub;
    temp3=(mub-mun3)/Ndiff3;  % temp3?a1¨¤??¦Ì?¡À3?¡ã
    s3=mu3-temp3;
    outs3=s3;
    temp_thresh3 = outs3;
    temp_thresh3(temp_thresh3<0)=0;  % ?a¨¢??¦Ì¦Ì¨ª¡À3?¡ã¦Ì?¡¤?2?
    out3 = temp_thresh3.^2;
    if flag
        figure, imshow(outs3, []); title('outs3');
        figure, surf(outs3); title('outs3');
        bw = outs3 <0;
        figure, imshow(bw);
    end
    
    diff31 = imfilter(img, mask31, 'replicate');
    diff32 = imfilter(img, mask32, 'replicate');
    diff33 = imfilter(img, mask33, 'replicate');
    diff34 = imfilter(img, mask34, 'replicate');
    diff3 = min(cat( 3, diff31, diff32, diff33, diff34), [], 3);
    temp_threshd3 = diff3;
    temp_threshd3(temp_threshd3<0)=0;
    outf3=temp_threshd3.*out3;
    if flag
        figure; imshow(diff31, []); title('diff31');
        figure; imshow(diff32, []); title('diff32');
        figure; imshow(diff33, []); title('diff33');
        figure; imshow(diff34, []); title('diff34');
        figure; imshow(diff3, []); title('diff3');
        figure; imshow(temp_threshd3, []); title('temp\_threshd3');
        figure; imshow(outf3, []); title('outf3');
    end
    
    %%  constructing ADM_prop and CDD in  5by5 scale
    
    mun5=N5*mu5;
    temp5=(mub-mun5)/Ndiff5;
    s5=mu5-temp5;
    outs5=s5;
    temp_thresh5 = outs5;
    temp_thresh5(temp_thresh5<0)=0;
    out5 = temp_thresh5.^2;
    
    diff51 = imfilter(img, mask51, 'replicate');
    diff52 = imfilter(img, mask52, 'replicate');
    diff53 = imfilter(img, mask53, 'replicate');
    diff54 = imfilter(img, mask54, 'replicate');
    diff5 = min(cat( 3, diff51, diff52, diff53, diff54), [], 3);
    temp_threshd5 = diff5;
    temp_threshd5(temp_threshd5<0)=0;
    outf5=temp_threshd5.*out5;
    
    %% constructing ADM_prop and CDD in  7by7 scale
    
    mun7=N7*mu7;
    temp7=(mub-mun7)/Ndiff7;
    s7=mu7-temp7;
    outs7=s7;
    temp_thresh7 = outs7;
    temp_thresh7(temp_thresh7<0)=0;
    out7 = temp_thresh7.^2;
    
    diff71 = imfilter(img, mask71, 'replicate');
    diff72 = imfilter(img, mask72, 'replicate');
    diff73 = imfilter(img, mask73, 'replicate');
    diff74 = imfilter(img, mask74, 'replicate');
    diff7 = min(cat( 3, diff71, diff72, diff73, diff74), [], 3);
    temp_threshd7 = diff7;
    temp_threshd7(temp_threshd7<0)=0;
    outf7=temp_threshd7.*out7;
    
    %% constructing ADM_prop and CDD in  9by9 scale
    mun9=N9*mu9;
    temp9=(mub-mun9)/Ndiff9;
    s9=mu9-temp9;
    outs9=s9;
    temp_thresh9 = outs9;
    temp_thresh9(temp_thresh9<0) = 0;
    out9 = temp_thresh9.^2;
    
    diff91 = imfilter(img, mask91, 'replicate');
    diff92 = imfilter(img, mask92, 'replicate');
    diff93 = imfilter(img, mask93, 'replicate');
    diff94 = imfilter(img, mask94, 'replicate');
    
    diff9 = min(cat( 3, diff91, diff92, diff93, diff94), [], 3);
    temp_threshd9 = diff9;
    temp_threshd9(temp_threshd9<0)=0;
    outf9=temp_threshd9.*out9;
end
%% output response by maximum selection along scale dimension
out = max(cat(3, outf3, outf5, outf7, outf9), [], 3);
out1 =final_AAGD(img,[19,19,19,19],[3,5,7,9]);
figure, imshow(out, []);
figure, imshow(out1, []);