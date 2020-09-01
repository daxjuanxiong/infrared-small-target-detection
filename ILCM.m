%  A robust infrared small target detection algorithm based on human visual system
% 与LCM算法相比的不同之处
% 1 分块节省时间
% 2 使用平均值取代最大值
function out = ILCM( img)
img=double(img);
[row, col]=size(img);
bs=8;
step=bs/2;
r=mod(row-bs,step);
c=mod(col-bs,step);
padr=0;
if (r ~= 0)
    padr=step-r;
end
padc=0;
if (c ~= 0)
    padc=step-c;
end
imgpad=padarray(img,[padr padc],'replicate','post');
[rr,cc]=size(imgpad);
a=(rr - bs)/step+1;
b=(cc - bs)/step+1;
M=zeros(a,b);
Ln=zeros(a,b);
for i=1:a
    for j=1:b
        block=imgpad(step*(i-1)+1:step*(i-1)+bs,step*(j-1)+1:step*(j-1)+bs);
        Ln(i,j)=max(max(block));%最大值
        M(i,j)=mean2(block); %平均值
    end
end
Mi=imdilate(M,[1 1 1;1 0 1;1 1 1]);% 8个块的平均值的最大值 
out=Ln.*M./Mi;
end


