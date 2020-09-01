% 2016 Multiscale patch-based contrast measure for small infrared target detection
function  out  = MPCM_fun( img)
% this function computes multiscale patch-based contrast measure (MPCM)
% the output image is acheieved using max selection through third dimension
img = double(img);
%% inputs:
% img: the input image
%% output
% out: output filtered image
%%
[row,col]=size(img);
mask3=ones(3);
mask5=ones(5);
mask7=ones(7);
l3=localmean(img,mask3);
l5=localmean(img,mask5);
l7=localmean(img,mask7);
%% scale 3x3
m31=zeros(9);
m32=zeros(9);
m33=zeros(9);
m34=zeros(9);
m35=zeros(9);
m36=zeros(9);
m37=zeros(9);
m38=zeros(9);
m31(1:3,1:3)=1;
m32(1:3,4:6)=1;
m33(1:3,7:9)=1;
m34(4:6,7:9)=1;
m35(7:9,7:9)=1;
m36(7:9,4:6)=1;
m37(7:9,1:3)=1;
m38(4:6,1:3)=1;
LCM3=zeros(row,col,8);
LCM3(:,:,1)=localmean(img,m31);
LCM3(:,:,2)=localmean(img,m32);
LCM3(:,:,3)=localmean(img,m33);
LCM3(:,:,4)=localmean(img,m34);
LCM3(:,:,5)=localmean(img,m35);
LCM3(:,:,6)=localmean(img,m36);
LCM3(:,:,7)=localmean(img,m37);
LCM3(:,:,8)=localmean(img,m38);
F31=l3-reshape(LCM3(:,:,1),row,col);
F32=l3-reshape(LCM3(:,:,2),row,col);
F33=l3-reshape(LCM3(:,:,3),row,col);
F34=l3-reshape(LCM3(:,:,4),row,col);
F35=l3-reshape(LCM3(:,:,5),row,col);
F36=l3-reshape(LCM3(:,:,6),row,col);
F37=l3-reshape(LCM3(:,:,7),row,col);
F38=l3-reshape(LCM3(:,:,8),row,col);

temp3=zeros(row,col,4);
    D31 = F31.*F35; D31(D31<0) = 0;
    temp3(:,:,1)=D31;
    D32 = F32.*F36; D32(D32<0) = 0;
    temp3(:,:,2)=D32;
    D33 = F33.*F37; D33(D33<0) = 0;
    temp3(:,:,3)=D33;
    D34 = F34.*F38; D34(D34<0) = 0;
    temp3(:,:,4)=D34;
out3=min(temp3,[],3);
%% scale 5x5
m51=zeros(15);
m52=zeros(15);
m53=zeros(15);
m54=zeros(15);
m55=zeros(15);
m56=zeros(15);
m57=zeros(15);
m58=zeros(15);
m51(1:5,1:5)=1;
m52(1:5,6:10)=1;
m53(1:5,11:15)=1;
m54(6:10,11:15)=1;
m55(11:15,11:15)=1;
m56(11:15,6:10)=1;
m57(11:15,1:5)=1;
m58(6:10,1:5)=1;
LCM5=zeros(row,col,8);
LCM5(:,:,1)=localmean(img,m51);
LCM5(:,:,2)=localmean(img,m52);
LCM5(:,:,3)=localmean(img,m53);
LCM5(:,:,4)=localmean(img,m54);
LCM5(:,:,5)=localmean(img,m55);
LCM5(:,:,6)=localmean(img,m56);
LCM5(:,:,7)=localmean(img,m57);
LCM5(:,:,8)=localmean(img,m58);
F51=l5-reshape(LCM5(:,:,1),row,col);
F52=l5-reshape(LCM5(:,:,2),row,col);
F53=l5-reshape(LCM5(:,:,3),row,col);
F54=l5-reshape(LCM5(:,:,4),row,col);
F55=l5-reshape(LCM5(:,:,5),row,col);
F56=l5-reshape(LCM5(:,:,6),row,col);
F57=l5-reshape(LCM5(:,:,7),row,col);
F58=l5-reshape(LCM5(:,:,8),row,col);
temp5=zeros(row,col,4);
    D51 = F51.*F55; D51(D51<0) = 0;
    temp5(:,:,1)=D51;
    D52 = F52.*F56; D52(D52<0) = 0;
    temp5(:,:,2)=D52;
    D53 = F53.*F57; D53(D53<0) = 0;
    temp5(:,:,3)=D53;
    D54 = F54.*F58; D54(D54<0) = 0;
    temp5(:,:,4)=D54;
out5=min(temp5,[],3);
%% scale 7x7
m71=zeros(21);
m72=zeros(21);
m73=zeros(21);
m74=zeros(21);
m75=zeros(21);
m76=zeros(21);
m77=zeros(21);
m78=zeros(21);
m71(1:7,1:7)=1;
m72(1:7,8:14)=1;
m73(1:7,15:21)=1;
m74(8:14,15:21)=1;
m75(15:21,15:21)=1;
m76(15:21,8:14)=1;
m77(15:21,1:7)=1;
m78(8:14,1:7)=1;
LCM7=zeros(row,col,8);
LCM7(:,:,1)=localmean(img,m71);
LCM7(:,:,2)=localmean(img,m72);
LCM7(:,:,3)=localmean(img,m73);
LCM7(:,:,4)=localmean(img,m74);
LCM7(:,:,5)=localmean(img,m75);
LCM7(:,:,6)=localmean(img,m76);
LCM7(:,:,7)=localmean(img,m77);
LCM7(:,:,8)=localmean(img,m78);
F71=l7-reshape(LCM7(:,:,1),row,col);
F72=l7-reshape(LCM7(:,:,2),row,col);
F73=l7-reshape(LCM7(:,:,3),row,col);
F74=l7-reshape(LCM7(:,:,4),row,col);
F75=l7-reshape(LCM7(:,:,5),row,col);
F76=l7-reshape(LCM7(:,:,6),row,col);
F77=l7-reshape(LCM7(:,:,7),row,col);
F78=l7-reshape(LCM7(:,:,8),row,col);
temp7=zeros(row,col,4);
    D71 = F71.*F75; D71(D71<0) = 0;
    temp7(:,:,1)=D71;
    D72 = F72.*F76; D72(D72<0) = 0;
    temp7(:,:,2)=D72;
    D73 = F73.*F77; D73(D73<0) = 0;
    temp7(:,:,3)=D73;
    D74 = F74.*F78; D74(D74<0) = 0;
    temp7(:,:,4)=D74;
out7=min(temp7,[],3);
%%
temp=zeros(row,col,3);
temp(:,:,1)=out3;
temp(:,:,2)=out5;
temp(:,:,3)=out7;
out=max(temp,[],3);
end