function out = final_AAGD( img,lmax,lmin )
% small infrared target deetction using multi-scale Absolute Average Gray Difference (AAGD) algorithm

% Example:
%          out=final_AAGD(img,[19,19,19,19],[3,5,7,9]);
%% 计算内外框的对比度
img=double(img);
out1=zeros(size(img,1),size(img,2),length(lmin));
for i=1:length(lmin)
    N=lmax(i)^2;
    N1=lmin(i)^2;
    N2=N-N1;
    mu_i=localmean(img,ones(lmin(i)));
    mu_e=localmean(img,ones(lmax(i)));
    mu_r=((N*mu_e)-(N1*mu_i))/N2;
    out1(:,:,i)=(mu_i-mu_r).^2;
end
out=max(out1,[],3);
end

