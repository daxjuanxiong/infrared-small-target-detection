function bw = bwfunc(re, bflag)
bflag = 1;
flag = 0;
m =mean2(re);
s = std2(re);
maxv = max(re(:));
switch bflag
    case 1
        T = m + 0.5*(maxv - m);
    case 2
        ratio = 0.6;
        T = ratio * maxv;
    case 3
        ratio = 3;
        T = m+ ratio*s;
end
bw = re> T;
if flag
    figure; imshow(bw);
end
end