im = imread("./media/white_balance_input.jpg");
imwrite(im, "./out/2.wb.jpg");
im = im2double(im);

channelmean = mean(mean(im))

% 2.1 Pixel-based correction
figure(); imshow(im);
coords = int32(ginput(1));
px_color = im(coords(2), coords(1), 1:3);
gain = px_color./channelmean;
im_pxcorr = im.*gain;
imwrite(im2uint8(im_pxcorr), "./out/2.wb_pxcorr.jpg");

% 2.2 Gray-world assumption
gain = channelmean/mean(channelmean);
im_gwa = im./gain;
imwrite(im2uint8(im_gwa), "./out/2.wb_gwa.jpg");

figure(); imshow([im, im_pxcorr, im_gwa])