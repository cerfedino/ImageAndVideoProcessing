im = im2double(imread("./media/ferrari.JPG"));
imwrite(im2uint8(im), "./out/1.ferrari.jpg");

% 1.1 Map pixels to 0-1 range and linearize image back
im_lin = im.^2.2;
imwrite(im2uint8(im_lin), "./out/1.ferrari_lin.jpg");

% 1.2 Increase brightness
im_bri = im.*2;
imwrite(im2uint8(im_bri), "./out/1.ferrari_bri.jpg");

% 1.3 Enhance contrast using exponential function
im_con = im.^0.7;
imwrite(im2uint8(im_con), "./out/1.ferrari_con.jpg");
figure(); imshow([im, im_lin,im_bri,im_con], []);