im = im2double(imread("./media/graz.png"));

% Motion blur filter
motionblur_filter = gaussianKernel([10, 1], -45);
im_motionblur = imfilter(im, motionblur_filter, 'symmetric');


blur_filter = gaussianKernel(10, 0);
im_blur = imfilter(im, blur_filter, 'symmetric');
figure(); imshow([im, im_motionblur], []); title("Anisotropic blur");
imwrite(im2uint8(im), "./out/5.im.jpg");
imwrite(im2uint8(motionblur_filter/(min(motionblur_filter(:))+max(motionblur_filter(:)))), "./out/5.motionblur_filter.jpg");
imwrite(im2uint8(im_motionblur), "./out/5.im_motionblur.jpg");
imwrite(im2uint8(blur_filter/(min(blur_filter(:))+max(blur_filter(:)))), "./out/5.blur_filter.jpg");
imwrite(im2uint8(im_blur), "./out/5.im_blur.jpg");