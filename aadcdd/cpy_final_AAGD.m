% Small infrared target detection using absolute average difference weighted by cumulative directional derivatives
channel = 1;
readimg;
out=final_AAGD(img,[19,19,19,19],[3,5,7,9]);
figure, imshow(out, []);