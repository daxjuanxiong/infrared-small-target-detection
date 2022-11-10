% 2014 Small target detection based on accumulated center-surround difference measure
% 效果一般
function re = acdmfunc(img)
img = double(img);
M = 5; % 2.5
N = 9; % 4.5
[c21, c22, c23, c24, c25, c26, c27, c28] = gradsub(img, 3, 3, 1); % 半径为3
[c31, c32, c33, c34, c35, c36, c37, c38] = gradsub(img, 4, 4, 1); % 半径为4
%% 融合
d1 = fusefunc(c21, c31, 2);
d3 = fusefunc(c23, c33, 2);
d6 = fusefunc(c26, c36, 2);
d8 = fusefunc(c28, c38, 2);

d2 = fusefunc(c22, c32, 1);
d4 = fusefunc(c24, c34, 1);
d5 = fusefunc(c25, c35, 1);
d7=  fusefunc(c27, c37, 1);
re = min(cat(3, d1, d2, d3, d4, d5, d6, d7, d8), [], 3);
end
function re = fusefunc(c21, c31, cc)
c = 500;
switch cc
    case 1
        w2 = 1 - exp(-c*norm([3, 0] - [0, 0], 2)^2);
        w3 = 1 - exp(-c*norm([4, 0] - [0, 0], 2)^2);
    case 2
        w2 = 1 - exp(-c*norm([3, 3] - [0, 0], 2)^2);
        w3 = 1 - exp(-c*norm([4, 4] - [0, 0], 2)^2);
end
re  = c21.*w2 + c31.*w3;
end
