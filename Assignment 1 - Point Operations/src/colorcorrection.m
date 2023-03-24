im = imread("./media/white_balance_input.jpg");
im = (double(im)./255);
imwrite(uint8(255.*im), "./out/2.wb.jpg");

channelmean = mean(mean(im))
% 2.1 Pixel-based correction
imshow(im);
coords = int32(ginput(1));
px_color = im(coords(2), coords(1), 1:3);
gain = px_color./channelmean;
im_pxcorr = im.*gain;
imwrite(uint8(255.*im_pxcorr), "./out/2.wb_pxcorr.jpg");

% 2.2 Gray-world assumption
gain = 0.5./channelmean;
im_gwa = im.*gain;
imwrite(uint8(255.*im_gwa), "./out/2.wb_gwa.jpg");


imshow([im,im_pxcorr,im_gwa])