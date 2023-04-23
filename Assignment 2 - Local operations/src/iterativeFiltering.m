im = im2double(imread("./media/delicate_arch.jpg"));

% Edge preserving bilateral filtering
im_bilat = imbilatfilt(im, 0.12, 6);
im_bilat2 = im;
for i = 1:45
    im_bilat2 = imbilatfilt(im_bilat2, 0.012, 0.6);
end


imwrite(im2uint8(im), "./out/6.im.jpg");
imwrite(im2uint8(im_bilat), "./out/6.im_bilat.jpg");
imwrite(im2uint8(im_bilat2), "./out/6.im_bilat2.jpg");
imshow([im, im_bilat, im_bilat2], []);
