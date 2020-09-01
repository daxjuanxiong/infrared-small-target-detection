%  Infrared Small Target Detection Based on Local Intensity and Gradient Properties
function re = LIG(img)
% parameter set
k=0.2;
N=11;
%  set your image path here
img = img(:,:,1);
[r,c]=size(img);
img=double(img);
%%
op11 = ones(N, N);
op11(6, 6) = 0;
op11 = op11 / sum(op11(:));
m11 = imfilter(img, op11, 'symmetric');
Imap = img - m11;
Imap(Imap<0) = 0;
%%
grad1=zeros(r,c);%
grad2=zeros(r,c);
grad3=zeros(r,c);
grad4=zeros(r,c);
Gmap=zeros(r,c);
op1 = [ 0,0,1;
           0,-1,0;
           0,0, 0];
op2 =  [ 0,0,0;
             0,-1,0;
             0,0, 1];
op3 = [ 0,0,0;
            0,-1,0;
            1,0, 0];
op4 =  [1, 0, 0;
             0,-1,0;
             0,0, 0];
% We took four directions to simplify the calculation
G1=imfilter(img, op1, 'replicate');
G2=imfilter(img, op2, 'replicate');
G3=imfilter(img, op3, 'replicate');
G4=imfilter(img, op4, 'replicate');

Mapscale=(N-1)/2;
Scale=Mapscale+1;
for i=Scale:r-Scale
    for j=Scale:c-Scale
        %--------------------------------------
        C1=G1(i:i+Mapscale,j-Mapscale:j);
        [x0,v0]=find(C1(:)>0);
        grad1(i,j)=sum(C1(x0).^2)/(length(x0)+0.001);
        %--------------------------------------
        C2=G2(i-Mapscale:i,j-Mapscale:j);
        [x1,v1]=find(C2(:)>0);
        grad2(i,j)=sum(C2(x1).^2)/(length(x1)+0.001);
        %--------------------------------------
        C3=G3(i-Mapscale:i,j:j+Mapscale);
        [x2,v2]=find(C3(:)>0);
        grad3(i,j)=sum(C3(x2).^2)/(length(x2)+0.001);
        %--------------------------------------
        C4=G4(i:i+Mapscale,j:j+Mapscale);
        [x3,v3]=find(C4(:)>0);
        grad4(i,j)=sum(C4(x3).^2)/(length(x3)+0.001);
        
        dnmax=max([grad1(i,j),grad2(i,j),grad3(i,j),grad4(i,j)]);
        dnmin=min([grad1(i,j),grad2(i,j),grad3(i,j),grad4(i,j)]);
        if((dnmin/dnmax)<k)
            Gmap(i,j)=0;
        else
            Gmap(i,j)=sum([grad1(i,j),grad2(i,j),grad3(i,j),grad4(i,j)]);
        end
    end
end
re = Gmap.*Imap;
% figure; imshow(uint8(img));
% figure; imshow(Imap, []);
% figure; imshow(G1, []);
% figure; imshow(G2, []);
% figure; imshow(G3, []);
% figure; imshow(G4, []);
% figure; imshow(Gmap, []);
end
