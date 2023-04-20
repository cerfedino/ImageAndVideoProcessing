im = im2double(imread("./media/delicate_arch.jpg"));

% Edge preserving bilateral filtering
im_bigbilat = imbilatfilt(im, 0.12, 6);
im_bigbilat2 = im;
for i = 1:45
    im_bigbilat2 = imbilatfilt(im_bigbilat2, 0.012, 0.6);
end


imwrite(im2uint8(im), "./out/6.im.jpg");
imwrite(im2uint8(im_bigbilat), "./out/6.im_bigbilat.jpg");
imwrite(im2uint8(im_bigbilat2), "./out/6.im_bigbilat2.jpg");
imshow([im, im_bigbilat, im_bigbilat2], []);
