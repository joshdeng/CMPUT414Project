function h = my_feature(I, B, b)
% I: input grayscale motion capture scene image
% B: mask image to indicate region of interest, i.e., where to compute histogram
% b: number of histogram bins
% h: b-dimensional histogram

B = I(B);
h = imhist(B,b);
h = h./sum(h);
% normalize h so that sum(h) = 1.
return