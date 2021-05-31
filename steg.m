%Read and display original image
A=imread('fruits.png');
figure,imshow(A);title('Original Image')
%Read the image you want to hide and cahnge it to grayscale
B=imread('peppers.png');
B=rgb2gray(B);
figure,imshow(B);title('Image to hide')
%Extract most significant bits 
b8 = bitget(B,8); % or use bitand (similar results) b8 = bitand(B,128);
b7 = bitget(B,7);
b6 = bitget(B,6);
%Replace most signifcant bits with the least in each RGB plane to perform the encryption
encimg = A;
encimg(:,:,1) = bitset(encimg(:,:,1),1,b8); % R channel least significant replaced with b8
encimg(:,:,2) = bitset(encimg(:,:,2),1,b7); % G channel least significant replaced with b7
encimg(:,:,3) = bitset(encimg(:,:,3),1,b6); % B channel least significant replaced with b6

%Display encrypted image
figure, imshow(encimg);title('New Encrypted Image')

%save new encrypted image
% imwrite(encimg,'Encrypted.bmp') % .bmp to preserve all data

%%Code to extrac the hidden image
%define a new matrix with equal size to our image
j=zeros(512,512);

%Decrypt hidden image from each layer and combine the 3 layers together to obtain image
decimg=bitget(encimg(:,:,1),1);%extracting least significant bit in encrypted image R plane i.e, our first layer from hidden image
j=bitset(j,8,decimg); %setting most significant bit from our least significant taken from encrypted image  
decimg=bitget(encimg(:,:,2),1);%extracting least significant bit in encrypted image G plane
j=bitset(j,7,decimg);
decimg=bitget(encimg(:,:,3),1);%extracting least significant bit in encrypted image B plane
j=bitset(j,6,decimg);
j=uint8(j);
%display hidden image
figure,imshow(j);title('Hidden Image')

% to see the difference between the extracted hidden image and the original hidden image 
difference = B - j ; 
figure, imshow(difference) , title('hidden image difference')