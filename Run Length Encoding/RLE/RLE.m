%% Matlab code for Image Compression Using Run Length Encoding
clc;
clear;
close all;
%% Set Quantization Parameter
quantizedvalue=200;
%% Read Input Image
[file path]=uigetfile({'*.bmp;*.jpg;*.png;*.tiff;';'*.*'},'Select an Image File');
fileinfo = dir(file);
InputImage=(imread(file));
SIZE = fileinfo.bytes;
Size = SIZE/1024;
disp(Size);
[row col p]=size(InputImage);
%% Wavelet Decomposition 
[LL LH HL HH]=dwt2(InputImage,'haar'); 
WaveletDecomposeImage=[LL,LH;HL,HH]; 
figure,imshow(WaveletDecomposeImage,[]);
QuantizedImage= WaveletDecomposeImage/quantizedvalue;
QuantizedImage= round(QuantizedImage);
ImageArray = zigzag(QuantizedImage);
%% Run Length Encoding
j=1;
a=length(ImageArray);
count=0;
for n=1:a
 b=ImageArray(n);
 if n==a
 count=count+1;
 c(j)=count;
 s(j)=ImageArray(n);
 elseif ImageArray(n)==ImageArray(n+1)
 count=count+1;
 elseif ImageArray(n)==b;
 count=count+1;
 c(j)=count;
 s(j)=ImageArray(n);
 j=j+1;
 count=0;
 end
end
InputBitcost=row*col*8;
InputBitcost=(InputBitcost);
c1=length(c);
s1=length(s);
OutputBitcost= (c1*8)+(s1*8);
OutputBitcost=(OutputBitcost);
%% Run Length Decoding 
g=length(s);
j=1;
l=1;
for i=1:g
 v(l)=s(j);
 if c(j)~=0
 w=l+c(j)-1;
 for p=l:w
 v(l)=s(j);
 l=l+1;
 end
 end
 j=j+1;
end
ReconstructedImageArray=v;
%% Inverse ZigZag
ReconstructedImage=invzigzag(ReconstructedImageArray,row,col);
%% Inverse Quantization
ReconstructedImage=ReconstructedImage*quantizedvalue;
%% Wavelet Reconstruction
sX = size(ReconstructedImage);
cA1 = ReconstructedImage(1:(sX(1)/2), 1:(sX(1)/2));
cH1 = ReconstructedImage(1:(sX(1)/2), (sX(1)/2 + 1):sX(1));
cV1 = ReconstructedImage((sX(1)/2 + 1):sX(1), 1:(sX(1)/2));
cD1 = ReconstructedImage((sX(1)/2 + 1):sX(1), (sX(1)/2 + 1):sX(1));
ReconstructedImage = idwt2(cA1,cH1,cV1,cD1,'haar');
%% Calculating PSNR and MSE
InputImage=double(InputImage);
ReconstructedImage=double(ReconstructedImage);
figure,imshow(ReconstructedImage,[]);
imwrite(ReconstructedImage,'CompressedImage.png');

fileinfo = dir('CompressedImage.png');
SIZE = fileinfo.bytes;
Size = SIZE/1024;
disp(Size);
n=size(InputImage);
M=n(1);
N=n(2);
MSE = sum(sum((InputImage-ReconstructedImage).^2))/(M*N);
PSNR = 10*log10(256*256/MSE);
fprintf('\nMSE: %7.2f ', MSE);
fprintf('\nPSNR: %9.7f dB', PSNR);
