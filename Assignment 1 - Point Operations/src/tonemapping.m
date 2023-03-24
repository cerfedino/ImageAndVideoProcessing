
im = imread("./media/ferrari.JPG");

imshow(im);
% max(im(:))

% 1.1 Map pixels to 0-1 range and linearize image back
im = (double(im)./255).^2.2;
imshow(im, []);
imwrite(im, "./out/ferrari_lin.JPG");


% 1.2 Increase brightness
im = im.*1.5;
imshow(im, []);
imwrite(im, "./out/ferrari_lin_bright.JPG");


% 1.3 Enhance contrast using exponential function
im = im.^0.5;
imshow(im, []);
imwrite(im, "./out/ferrari_lin_bright_contrast.JPG");

