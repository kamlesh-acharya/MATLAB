a = imread('core.jpg');
subplot(4,4,1);
imshow(a);

b = rgb2gray(a);
subplot(4,4,2);
imshow(b);

c = imadd(b,100);
subplot(4,4,3);
imshow(c);

d = imsubtract(b,100);
subplot(4,4,4);
imshow(d);

subplot(4,4,5);
%imhist(a);
subplot(4,4,6);
imhist(b);
subplot(4,4,7);
imhist(c);
subplot(4,4,8);
imhist(d);

e = histeq(c);
subplot(4,4,11);
imshow(e);

f = histeq(d);
subplot(4,4,12);
imshow(f);

subplot(4,4,15);
imhist(e);
subplot(4,4,16);
imhist(f);