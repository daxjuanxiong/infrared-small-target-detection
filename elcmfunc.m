% 2019 Gaussian Scale-Space Enhanced Local Contrast Measure for Small Infrared Target Detection
function ISM = elcmfunc(img)
img = double(img);
%% gss
d3 =3;
s3 = d3/2/sqrt(2);
o3 = fspecial('gaussian', floor(2*s3 +1), s3);
d5 = 5;
s5 = d5/2/sqrt(2);
o5 = fspecial('gaussian', floor(2*s5 +1), s5);
d7 = 7;
s7 = d7/2/sqrt(2);
o7 = fspecial('gaussian', floor(2*s7 +1), s7);
g3 = imfilter(img, o3, 'replicate');
g5 = imfilter(img, o5, 'replicate');
g7 = imfilter(img, o7, 'replicate');
%% elcm
ELCM3 = subfunc(g3, d3);
ELCM5 = subfunc(g5, d5);
ELCM7 = subfunc(g7, d7);
tt = cat(3, ELCM3, ELCM5, ELCM7);
ISM = max(tt, [], 3);
end
function ELCM = subfunc(img, s)
op = zeros(s*3);
len = floor(s/2);
op1 = op; op1(len+1, len+1) = 1;
op2 = op; op2(len+1, s + len+1) = 1;
op3 = op; op3(len+1, 2*s + len+1) = 1;
op4 = op; op4(s + len+1, len+1) = 1;
op5 = op; op5(s + len+1, 2*s + len+1) = 1;
op6 = op; op6(2*s + len+1, len+1) = 1;
op7 = op; op7(2*s + len+1, s + len+1) = 1;
op8 = op; op8(2*s + len+1, 2*s + len+1) = 1;
G0 = img;
G1 = imfilter(img, op1, 'replicate');
G2 = imfilter(img, op2, 'replicate');
G3 = imfilter(img, op3, 'replicate');
G4 = imfilter(img, op4, 'replicate');
G5 = imfilter(img, op5, 'replicate');
G6 = imfilter(img, op6, 'replicate');
G7 = imfilter(img, op7, 'replicate');
G8 = imfilter(img, op8, 'replicate');
ind = G0 >G1 & G0 >G2 &G0 >G3 &G0 >G4 &...
    G0 >G5 & G0 >G6 &G0 >G7 &G0 >G8;
d1 = (G0 - G1).^2; r1 = G0./G1;
d2 = (G0 - G2).^2; r2 = G0./G2;
d3 = (G0 - G3).^2; r3 = G0./G3;
d4 = (G0 - G4).^2; r4 = G0./G4;
d5 = (G0 - G5).^2; r5 = G0./G5;
d6 = (G0 - G6).^2; r6 = G0./G6;
d7 = (G0 - G7).^2; r7 = G0./G7;
d8 = (G0 - G8).^2; r8 = G0./G8;
dr1 = d1.*r1;
dr2 = d2.*r2;
dr3 = d3.*r3;
dr4 = d4.*r4;
dr5 = d5.*r5;
dr6 = d6.*r6;
dr7 = d7.*r7;
dr8 = d8.*r8;
drt = cat(3, dr1, dr2, dr3, dr4, dr5, dr6, dr7, dr8);
ELCM = min(drt, [], 3);
ELCM(~ind) = 0;
end


% d1 = (G0 - G1).^2; r1 = G0./G1;
% d2 = (G0 - G2).^2; r2 = G0./G2;
% d3 = (G0 - G3).^2; r3 = G0./G3;
% d4 = (G0 - G4).^2; r4 = G0./G4;
% d5 = (G0 - G5).^2; r5 = G0./G5;
% d6 = (G0 - G6).^2; r6 = G0./G6;
% d7 = (G0 - G7).^2; r7 = G0./G7;
% d8 = (G0 - G8).^2; r8 = G0./G8;
% dd1 = dt(y,x, :);
% dd1 = squeeze(dd1)
% rr1 = rt(y,x, :);
% rr1 = squeeze(rr1)
% t2 = drt(y,x,:)
% t2 = squeeze(t2)
% figure; hold on;
% plot(dd1, 'r-')
% plot( rr1, 'g-');
% plot(t2, 'b-');
% min(dd1)*min(rr1)
% min(t2)
% ELCM(y,x)
% ELCM1(y, x)