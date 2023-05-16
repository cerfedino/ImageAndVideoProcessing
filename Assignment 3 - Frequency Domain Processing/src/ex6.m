% construct a 2D square image with size imsizeximsize
imsize = 1024;
img = zeros(imsize,imsize) + 0.8;
img(imsize/4:imsize/4*3, imsize/4:imsize/4*3)=0;

%% Gaussian filtering in spatial domain
sigma_s = 5;
[img_filtered, kernel_size_s, gaussian_filter_spatial ] = spatialGaussianFiltering(img, sigma_s);


%% Gaussian filtering in frequency domain
[ img2_filtered, img2_fft, gaussian_filter_frequency, img2_filtered_fft ] = frequencyGaussianFiltering(img, sigma_s);


%% BONUS: Benchmark
benchmark_sigmas = 1:60;
results = zeros(size(benchmark_sigmas,2),3);
for i = benchmark_sigmas
    fprintf("\rBenchmarking spatial sigma %i/%i:\t1. SPATIAL   domain",i,size(benchmark_sigmas,2));
    tic();
    spatialGaussianFiltering(img, i);
    time1 = toc();
    fprintf("\rBenchmarking spatial sigma %i/%i:\t1. FREQUENCY domain",i,size(benchmark_sigmas,2));
    tic();
    frequencyGaussianFiltering(img, i);
    time2 = toc();
    results(i,:) = [i time1 time2];
end

matrix2tablebody(results, "./out/6.benchmark.dat", '%.5f', ["x", "y", "z"], ' ',sprintf('\n'))

subplot(1,3,1);
imshow(img);
title('Original image');
subplot(1,3,2);
imshow(gaussian_filter_spatial, []);
title('Gaussian kernel in spatial domain');
subplot(1,3,3);
imshow(img_filtered);
title('Filtered image in spatial domain');

figure;
subplot(1,3,1);
imshow(log(abs(img2_fft)));
title('FFT of padded and shifted image');
subplot(1,3,2);
imshow(gaussian_filter_frequency);
title('Gaussian kernel for frequency domain');
subplot(1,3,3);
imshow(log(abs(img2_filtered)));
title('Filtered image in frequency domain');

imwrite(im2uint8(img), './out/6.img.png');
imwrite(mat2gray(gaussian_filter_spatial, [min(gaussian_filter_spatial(:)) max(gaussian_filter_spatial(:))]), './out/6.gaussian_filter_spatial.png');
imwrite(im2uint8(img_filtered), './out/6.img_filtered.png');
imwrite(im2uint8(log(abs(img2_fft))), './out/6.img2_fft.png');
imwrite(mat2gray(gaussian_filter_frequency, [min(gaussian_filter_frequency(:)) max(gaussian_filter_frequency(:))]), './out/6.gaussian_filter_frequency.png');
imwrite(im2uint8(img2_filtered), './out/6.img2_filtered.png');
imwrite(im2uint8(log(abs(img2_filtered_fft))), './out/6.img2_filtered_fft.png');


function [img_filtered, kernel_size_s, gaussian_filter_spatial] = spatialGaussianFiltering(img, sigma_s)
    kernel_size_s = 4*sigma_s+1;
    gaussian_filter_spatial = fspecial('gaussian', kernel_size_s, sigma_s);
    img_filtered = conv2(img,gaussian_filter_spatial,'same');
end


function [ img2_filtered, img2_fft, gaussian_filter_frequency, img2_filtered_fft ] = frequencyGaussianFiltering(img, sigma_s)
    %%% Convert to frequency domain
    img2_fft = fft2(img);
    % Shift lower frequencies to the center of fourier spectrum
    img2_fft = fftshift(img2_fft);

    % Computing gaussian filter
    sigma_f = (1/(2*pi*sigma_s));
    [X,Y]= meshgrid(-size(img,1)/2:size(img,1)/2-1,-size(img,2)/2:size(img,2)/2-1);
    D = sqrt(X.^2 + Y.^2);
    D = D/max(D(:));
    D = exp(-D.^2/2/sigma_f^2);
    D = D/max(D(:));
    gaussian_filter_frequency = D;

    % Perform gaussian filtering in frequency domain
    img2_filtered_fft = img2_fft .* gaussian_filter_frequency;
    % Bring image back to spatial domain
    img2_filtered = ifft2(ifftshift(img2_filtered_fft));
end