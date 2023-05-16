img = im2double(imread('media/san_domenico.png'));

% Bring the image in the frequency domain
fft_img = fftshift(fft2(img));

% Compute the mask
mask = circleMask(size(img), 14, [210, 280]);
mask = mask + circleMask(size(img), 14, [265, 285]);
mask = mask + circleMask(size(img), 14, [215, 355]);
mask = mask + circleMask(size(img), 14, [270, 360]);
mask = ~mask;

% Apply the mask
fft_masked = fft_img .* mask;

% Unshift and bring in the spatial domain
fft_res = ifftshift(fft_masked);
img_res = ifft2(fft_res);



% Plot the results
fft_masked = log(abs(fft_masked));
fft_img = log(abs(fft_img));
imwrite(im2uint8(img), './out/7.img.png');
imwrite(im2uint8(img_res), './out/7.res.png');
imwrite(mat2gray(fft_img, [min(fft_img(:)) max(fft_img(:))]), './out/7.img_fft.png');
imwrite(mat2gray(fft_img, [min(fft_img(:)) max(fft_img(:))]).*mask, './out/7.res_fft.png');
figure;
subplot(2,2,1);
imshow(img);
title('Original');
subplot(2,2,3);
imshow(fft_img, []);
title('Original FFT');
subplot(2,2,2);
imshow(img_res);
title('Processed image');
subplot(2,2,4);
imshow(fft_masked, []);
title("Masked FFT");


function mask = circleMask(imgsize, radius, position)
    [W,H] = meshgrid(1:imgsize(2),1:imgsize(1));
    mask = (((W-position(1)).^2 + (H-position(2)).^2) < radius^2);
end