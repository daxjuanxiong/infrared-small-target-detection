function bw = bwfunc(re)
mm = 1;
m =mean2(re);
s = std2(re);
maxv = max(re(:));
switch mm
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
end