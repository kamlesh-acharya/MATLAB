a = imread('core.jpg');
imshow(a);
size(a);
b = imresize(a,.5);
imshow(b);



a = imread('core.jpg');
subplot(2,2,1);
title('Color');
imshow(a);
b = rgb2gray(a);
subplot(2,2,2);
title('Gray');
imshow(b);
c = im2bw(b,.8);
subplot(2,2,3);
title('B&W');
imshow(c);