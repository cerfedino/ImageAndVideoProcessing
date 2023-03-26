im = imread("./media/ferrari.JPG");
im = double(im)./255;
imwrite(uint8(255.*im), "./out/1.ferrari.jpg");


% 1.1 Map pixels to 0-1 range and linearize image back
im_lin = im.^2.2;
imwrite(uint8(255.*im_lin), "./out/1.ferrari_lin.jpg");


% 1.2 Increase brightness
im_bri = im.*2;
imwrite(uint8(255.*im_bri), "./out/1.ferrari_bri.jpg");


% 1.3 Enhance contrast using exponential function
im_con = im.^0.7;
imwrite(uint8(255.*im_con), "./out/1.ferrari_con.jpg");
figure()
imshow([im, im_lin,im_bri,im_con], []);