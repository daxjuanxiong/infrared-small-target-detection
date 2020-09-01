function re =maxMed(img, sz)
img = double(img);
cx = (sz + 1)/2;
cy = (sz + 1)/2;
op1 = zeros(sz);
op2 = zeros(sz);
op1(:, cx) = 1;
op2(cy, :) = 1;
op3 = diag( ones(1, sz));
op4 = fliplr(op3);
re1 = ordfilt2(img, (sz +1)/2, op1, 'symmetric');
re2 = ordfilt2(img, (sz +1)/2, op2, 'symmetric');
re3 = ordfilt2(img, (sz +1)/2, op3, 'symmetric');
re4 = ordfilt2(img, (sz +1)/2, op4, 'symmetric');
back = max( cat(3, re1, re2, re3, re4), [], 3);
re = img - back;
end 