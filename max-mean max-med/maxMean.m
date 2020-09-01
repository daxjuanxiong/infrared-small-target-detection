function re =maxMean(img,sz)
img = double(img);
cx = (sz + 1)/2;
cy = (sz + 1)/2;
op1 = zeros(sz);
op2 = zeros(sz);
op1(:, cx) = 1/sz;
op2(cy, :) = 1/sz;
op3 = diag( ones(1, sz)/sz);
op4 = fliplr( op3);
re1 = imfilter(img, op1, 'symmetric');
re2 = imfilter(img, op2, 'symmetric');
re3 = imfilter(img, op3, 'symmetric');
re4 = imfilter(img, op4, 'symmetric');
back = max( cat(3, re1, re2, re3, re4), [], 3);
re = img - back;
end