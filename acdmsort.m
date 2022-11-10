function [re1, re2, re3] = acdmsort(img)
img = double(img);
[c11, c12, c13, c14, c15, c16, c17, c18] = gradsub(img, 1, 1, 2); % radius 1
[c21, c22, c23, c24, c25, c26, c27, c28] = gradsub(img, 2, 2, 2); % radius 2
[c31, c32, c33, c34, c35, c36, c37, c38] = gradsub(img, 3, 3, 2); % radius 3
[c41, c42, c43, c44, c45, c46, c47, c48] = gradsub(img, 4, 4, 2); % radius 4
[d11, d21, d31] = ref(c11, c21, c31, c41);
[d12, d22, d32] = ref(c12, c22, c32, c42);
[d13, d23, d33] = ref(c13, c23, c33, c43);
[d14, d24, d34] = ref(c14, c24, c34, c44);
[d15, d25, d35] = ref(c15, c25, c35, c45);
[d16, d26, d36] = ref(c16, c26, c36, c46);
[d17, d27, d37] = ref(c17, c27, c37, c47);
[d18, d28, d38] = ref(c18, c28, c38, c48);
t1 = sort(cat(3, d11, d12, d13, d14, d15, d16, d17, d18), 3, 'ascend'); % ÉıĞò
re1 = sum(t1(:,:, 3:4), 3);
t2 = sort(cat(3, d21, d22, d23, d24, d25, d26, d27, d28), 3, 'ascend');
re2 = sum(t2(:,:, 3:4), 3);
t3 = sort(cat(3, d31, d32, d33, d34, d35, d36, d37, d38), 3, 'ascend');
re3 = sum(t3(:,:, 3:4), 3);
end
function [re1, re2, re3] = ref(c1, c2, c3, c4)
maxv = max(cat(3, c1, c2, c3, c4), [], 3);
minv = min(cat(3, c1, c2, c3, c4), [], 3);
re1 = maxv;
re2 = minv;
re3= (maxv - minv).^2;
end