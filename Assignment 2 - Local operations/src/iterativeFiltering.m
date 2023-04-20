im = im2double(imread("./media/delicate_arch.jpg"));

% Edge preserving bilateral filtering
im_bibilat = imbilatfilt(im, 0.12, 6);
im_bibilat2 = im;
for i = 1:45
    im_bibilat2 = imbilatfilt(im_bibilat2, 0.012, 0.6);
end


imwrite(im2uint8(im), "./out/6.im.jpg");
imwrite(im2uint8(im_bibilat), "./out/6.im_bibilat.jpg");
imwrite(im2uint8(im_bibilat2), "./out/6.im_bibilat2.jpg");
imshow([im, im_bibilat, im_bibilat2], []);
