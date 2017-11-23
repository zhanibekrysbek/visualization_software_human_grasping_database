function I = pseudoColorDepthImage(img)
%   PSEUDOCOLORDEPTHIMAGE converts uint16 depth image to pseudo color.
%       I = PSEUDOCOLORDEPTHIMAGE(img) returns pseudo-colored depth image I for
%       raw depth image img using jet color map.
%

% read input as double
img2 = double(img); 
% set saturation to 2048 for each pixel in img
img2(img2 > 2048) = 2048; 
% rescale
img2 = img2/8;
% convert to uint8
img2 = uint8(img2);
% assign color to indexed image img2
I = ind2rgb(img2,jet);

end
