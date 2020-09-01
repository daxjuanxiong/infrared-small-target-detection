% 2016 Multiscale patch-based contrast measure for small infrared target detection
function  out  = MPCM_fun( img, ff)
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
% mask9=ones(9);
l3=localmean(img,mask3);
l5=localmean(img,mask5);
l7=localmean(img,mask7);
% l9=localmean(img,mask9);
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
if ff
    D31 = F31.*F35; D31(D31<0) = 0;
    temp3(:,:,1)=D31;
    D32 = F32.*F36; D32(D32<0) = 0;
    temp3(:,:,2)=D32;
    D33 = F33.*F37; D33(D33<0) = 0;
    temp3(:,:,3)=D33;
    D34 = F34.*F38; D34(D34<0) = 0;
    temp3(:,:,4)=D34;
else
    temp3(:,:,1)=F31.*F35;
    temp3(:,:,2)=F32.*F36;
    temp3(:,:,3)=F33.*F37;
    temp3(:,:,4)=F34.*F38;
end
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
if ff
    D51 = F51.*F55; D51(D51<0) = 0;
    temp5(:,:,1)=D51;
    D52 = F52.*F56; D52(D52<0) = 0;
    temp5(:,:,2)=D52;
    D53 = F53.*F57; D53(D53<0) = 0;
    temp5(:,:,3)=D53;
    D54 = F54.*F58; D54(D54<0) = 0;
    temp5(:,:,4)=D54;
else
    temp5(:,:,1)=F51.*F55;
    temp5(:,:,2)=F52.*F56;
    temp5(:,:,3)=F53.*F57;
    temp5(:,:,4)=F54.*F58;
end
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
if ff
    D71 = F71.*F75; D71(D71<0) = 0;
    temp7(:,:,1)=D71;
    D72 = F72.*F76; D72(D72<0) = 0;
    temp7(:,:,2)=D72;
    D73 = F73.*F77; D73(D73<0) = 0;
    temp7(:,:,3)=D73;
    D74 = F74.*F78; D74(D74<0) = 0;
    temp7(:,:,4)=D74;
else
    temp7(:,:,1)=F71.*F75;
    temp7(:,:,2)=F72.*F76;
    temp7(:,:,3)=F73.*F77;
    temp7(:,:,4)=F74.*F78;
end
out7=min(temp7,[],3);
%% scale 9x9
% m91=zeros(27);
% m92=zeros(27);
% m93=zeros(27);
% m94=zeros(27);
% m95=zeros(27);
% m96=zeros(27);
% m97=zeros(27);
% m98=zeros(27);
% m91(1:9,1:9)=1;
% m92(1:9,10:18)=1;
% m93(1:9,19:27)=1;
% m94(10:18,19:27)=1;
% m95(19:27,19:27)=1;
% m96(19:27,10:18)=1;
% m97(19:27,1:9)=1;
% m98(10:18,1:9)=1;
% LCM9=zeros(row,col,8);
% LCM9(:,:,1)=localmean(img,m91);
% LCM9(:,:,2)=localmean(img,m92);
% LCM9(:,:,3)=localmean(img,m93);
% LCM9(:,:,4)=localmean(img,m94);
% LCM9(:,:,5)=localmean(img,m95);
% LCM9(:,:,6)=localmean(img,m96);
% LCM9(:,:,7)=localmean(img,m97);
% LCM9(:,:,8)=localmean(img,m98);
% F91=l9-reshape(LCM9(:,:,1),row,col);
% F92=l9-reshape(LCM9(:,:,2),row,col);
% F93=l9-reshape(LCM9(:,:,3),row,col);
% F94=l9-reshape(LCM9(:,:,4),row,col);
% F95=l9-reshape(LCM9(:,:,5),row,col);
% F96=l9-reshape(LCM9(:,:,6),row,col);
% F97=l9-reshape(LCM9(:,:,7),row,col);
% F98=l9-reshape(LCM9(:,:,8),row,col);
% temp9=zeros(row,col,4);
% temp9(:,:,1)=F91.*F95;
% temp9(:,:,2)=F92.*F96;
% temp9(:,:,3)=F93.*F97;
% temp9(:,:,4)=F94.*F98;
% out9=min(temp9,[],3);
%%
temp=zeros(row,col,3);
temp(:,:,1)=out3;
temp(:,:,2)=out5;
temp(:,:,3)=out7;
% temp(:,:,4)=out9;
out=max(temp,[],3);
end
%% ÁíÒ»ÖÖÐ´·¨£º
%{
img = img(:,:,1);
%%% 3x3
t3 = fspecial('average',3);
f3=imfilter(double( img), t3, 'symmetric');
op3=zeros(9);
op3(5,5)=1;
op31=op3;
op31(2,2)=-1;
op32=op3;
op32(2,5)=-1;
op33=op3;
op33(2,8)=-1;
op34=op3;
op34(5,8)=-1;
op35=op3;
op35(8,8)=-1;
op36=op3;
op36(8,5)=-1;
op37=op3;
op37(8,2)=-1;
op38=op3;
op38(5,2)=-1;
c31 = imfilter(f3,op31, 'symmetric');
c35 = imfilter(f3,op35, 'symmetric');
c32 = imfilter(f3,op32, 'symmetric');
c36 = imfilter(f3,op36, 'symmetric');
c33 = imfilter(f3,op33, 'symmetric');
c37 = imfilter(f3,op37, 'symmetric');
c34 = imfilter(f3,op34, 'symmetric');
c38 = imfilter(f3,op38, 'symmetric');
d31=c31 .*c35;
d32=c32 .*c36;
d33=c33 .*c37;
d34=c34 .*c38;
    if ff
        d31(d31< 0) = 0;
        d32(d32< 0) = 0;
        d33(d33< 0) = 0;
        d34(d34< 0) = 0;
    end
d3 = cat(3, d31, d32, d33, d34);
out33 = min(d3, [], 3);
if flag
    figure; imshow(f3, []);
    figure; imshow(out33, []);
    figure; surf(out33 );
end
%%% 5x5
t5 = fspecial('average',5);
f5 =imfilter(double( img) , t5, 'symmetric');
op5=zeros(15);
op5(8,8)=1;
op51=op5;
op51(3,3)=-1;
op52=op5;
op52(3,8)=-1;
op53=op5;
op53(3,13)=-1;
op54=op5;
op54(8,13)=-1;
op55=op5;
op55(13,13)=-1;
op56=op5;
op56(13,8)=-1;
op57=op5;
op57(13,3)=-1;
op58=op5;
op58(8,3)=-1;
c51 = imfilter(f5,op51, 'symmetric');
c55 = imfilter(f5,op55, 'symmetric');
c52 = imfilter(f5,op52, 'symmetric');
c56 = imfilter(f5,op56, 'symmetric');
c53 = imfilter(f5,op53, 'symmetric');
c57 = imfilter(f5,op57, 'symmetric');
c54 = imfilter(f5,op54, 'symmetric');
c58 = imfilter(f5,op58, 'symmetric');
d51=c51 .*c55;
d52=c52 .*c56;
d53=c53 .*c57;
d54=c54 .*c58;
if ff
    d51(d51< 0) = 0;
    d52(d52< 0) = 0;
    d53(d53< 0) = 0;
    d54(d54< 0) = 0;
end
d5 = cat(3, d51, d52, d53, d54);
out55 = min(d5, [], 3);
if flag
    figure; imshow(f5, []);
    figure; imshow(out55, []);
    figure; surf(out55 );
end
%%%  7x7
t7 = fspecial('average', 7);
f7 = imfilter(double( img) , t7, 'symmetric');
op7=zeros(21);
op7(11,11)=1;
op71=op7;
op71(4,4)=-1;
op72=op7;
op72(4,11)=-1;
op73=op7;
op73(4,18)=-1;
op74=op7;
op74(11,18)=-1;
op75=op7;
op75(18,18)=-1;
op76=op7;
op76(18,11)=-1;
op77=op7;
op77(18,4)=-1;
op78=op7;
op78(11,4)=-1;
c71 = imfilter(f7,op71, 'symmetric');
c75 = imfilter(f7,op75, 'symmetric');
c72 = imfilter(f7,op72, 'symmetric');
c76 = imfilter(f7,op76, 'symmetric');
c73 = imfilter(f7,op73, 'symmetric');
c77 = imfilter(f7,op77, 'symmetric');
c74 = imfilter(f7,op74, 'symmetric');
c78 = imfilter(f7,op78, 'symmetric');
d71=c71 .*c75;
d72=c72 .*c76;
d73=c73 .*c77;
d74=c74 .*c78;
if ff
    d71(d71< 0) = 0;
    d72(d72< 0) = 0;
    d73(d73< 0) = 0;
    d74(d74< 0) = 0;
end
d7 = cat(3, d71, d72, d73, d74);
out77 = min(d7, [], 3);
if flag
    figure; imshow(f7, []);
    figure; imshow(out77, []);
    figure; surf(out77 );
end
c = cat(3, out33, out55, out77);
re = max(c, [], 3);
%}

