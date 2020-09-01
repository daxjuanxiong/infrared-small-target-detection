function out = RLCM( img )
% Infrared Small Target Detection Utilizing the
% Multiscale Relative Local Contrast Measure
%   Detailed explanation goes here
img=double(img);
scale=3;
k1=[2,5,9];
k2=[4,9,16];
out_RLCM=zeros(size(img,1),size(img,2),scale);
for itter=1:scale


I0=zeros(size(img,1),size(img,2),k1(itter));
I11=zeros(size(img,1),size(img,2),k2(itter));
I12=zeros(size(img,1),size(img,2),k2(itter));
I13=zeros(size(img,1),size(img,2),k2(itter));
I14=zeros(size(img,1),size(img,2),k2(itter));
I15=zeros(size(img,1),size(img,2),k2(itter));
I16=zeros(size(img,1),size(img,2),k2(itter));
I17=zeros(size(img,1),size(img,2),k2(itter));
I18=zeros(size(img,1),size(img,2),k2(itter));


for i=1:k1(itter)
I0(:,:,i)=ordfilt2(img,82-i,ones(9));
end
I_mean_0=mean(I0,3);

m91=zeros(27);
m92=zeros(27);
m93=zeros(27);
m94=zeros(27);
m95=zeros(27);
m96=zeros(27);
m97=zeros(27);
m98=zeros(27);
m91(1:9,1:9)=1;
m92(1:9,10:18)=1;
m93(1:9,19:27)=1;
m94(10:18,19:27)=1;
m95(19:27,19:27)=1;
m96(19:27,10:18)=1;
m97(19:27,1:9)=1;
m98(10:18,1:9)=1;


for i=1:k2(itter)
I11(:,:,i)=ordfilt2(img,82-i,m91);
I12(:,:,i)=ordfilt2(img,82-i,m92);
I13(:,:,i)=ordfilt2(img,82-i,m93);
I14(:,:,i)=ordfilt2(img,82-i,m94);
I15(:,:,i)=ordfilt2(img,82-i,m95);
I16(:,:,i)=ordfilt2(img,82-i,m96);
I17(:,:,i)=ordfilt2(img,82-i,m97);
I18(:,:,i)=ordfilt2(img,82-i,m98);

end
I_mean_1=mean(I11,3);
I_mean_2=mean(I12,3);
I_mean_3=mean(I13,3);
I_mean_4=mean(I14,3);
I_mean_5=mean(I15,3);
I_mean_6=mean(I16,3);
I_mean_7=mean(I17,3);
I_mean_8=mean(I18,3);

temp=zeros(size(img,1),size(img,2),8);
temp(:,:,1)=I_mean_1;
temp(:,:,2)=I_mean_2;
temp(:,:,3)=I_mean_3;
temp(:,:,4)=I_mean_4;
temp(:,:,5)=I_mean_5;
temp(:,:,6)=I_mean_6;
temp(:,:,7)=I_mean_7;
temp(:,:,8)=I_mean_8;

I_mean_out=max(temp,[],3);

out_RLCM(:,:,itter)=((I_mean_0.^2)./I_mean_out)-I_mean_0;


end

out=max(out_RLCM,[],3);
tt=out>0;
out=double(tt).*out;

end

