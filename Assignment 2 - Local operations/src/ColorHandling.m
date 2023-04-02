I = imread('your_image.png');
I_ycbcr = rgb2ycbcr(double(I)./255);   %this is a transformation that you will learn about in later lectures, dont worry about it now
I_gray = double(rgb2gray(I))./255;     %Just use this gray-scale image for any further processing

%%%%%%%% Processing %%%%%%%%%%%

J_ycbcr = cat(3,result,I_ycbcr(:,:,2),I_ycbcr(:,:,3)); %replace 'result' with your processed gray-scale output
J_rgb = ycbcr2rgb(J_ycbcr);           %this is a transformation that you will learn about in later lectures, dont worry about it now
imshow(J_rgb);   