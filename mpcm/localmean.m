function mean=localmean(f,nhood)
% performing local averaging on 2D images
% inputs: f => input images
%	  nhood => the neighbourhood matrix
%		      e.g. ones(5)
% output: mean => local average matrix	
if nargin==1
    nhood=ones(3)/9;
else
    nhood=nhood/(sum(nhood(:)));
end
mean=imfilter(f,nhood,'symmetric');
end
