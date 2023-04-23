im = im2double(imread("./media/delicate_arch.jpg"));

% Create gaussian blur filter with a gamma parameter of 1
sigma = 1;
gamma = 8;
size = 4*sigma + 1;
blur_f = fspecial('gaussian', size, sigma);
% Identity kernel - leaves the pixel untouched
identity_f = zeros(size);
identity_f(ceil(size/2), ceil(size/2)) = 1;
% Unsharp filter
unsharp_filter = identity_f + gamma.*(identity_f - blur_f);
im_sharp = imfilter(im, unsharp_filter);

imwrite(im2uint8(im), "./out/2.im.jpg");
figure(); imshow(im_sharp, []); title("Unsharp Masking");
imwrite(im2uint8(im_sharp), "./out/2.im_sharp.jpg");
matrix2tablebody(identity_f, "./out/2.identity_f.tex", '');
matrix2tablebody(blur_f, "./out/2.blur_f.tex", '%.2f');
matrix2tablebody(unsharp_filter, "./out/2.unsharp_filter.tex", '%.2f');
