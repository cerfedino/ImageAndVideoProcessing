% construct a 2D square image with size imsizeximsize
imsize = 1024;
img = zeros(imsize,imsize) + 0.8;
img(imsize/4:imsize/4*3, imsize/4:imsize/4*3)=0;

%% Gaussian filtering in spatial domain
sigma_s = 5;
[img_gaussian_spatial, kernel_size_s, gaussian_filter_spatial ] = spatialGaussianFiltering(img, sigma_s);


%% Gaussian filtering in frequency domain
[ img2_filtered, img2_pad, img2_fft, gaussian_filter_frequency ] = frequencyGaussianFiltering(img, sigma_s);


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

matrix2tablebody(results, "./out/benchmark.dat", '%.5f', ["x", "y", "z"], ' ',sprintf('\n'))

subplot(1,3,1);
imshow(img);
title('Original image');
subplot(1,3,2);
imshow(gaussian_filter_spatial, []);
title('Gaussian kernel in spatial domain');
subplot(1,3,3);
imshow(img_gaussian_spatial);
title('Filtered image in spatial domain');

figure;
subplot(1,4,1);
imshow(img2_pad);
title('Original padded and shifted image');
subplot(1,4,2);
imshow(img2_fft);
title('FFT of padded and shifted image');
subplot(1,4,3);
imshow(gaussian_filter_frequency, []);
title('Gaussian kernel for frequency domain');
subplot(1,4,4);
imshow(img2_filtered);
title('Filtered image in frequency domain');



function [img_gaussian_spatial, kernel_size_s, gaussian_filter_spatial] = spatialGaussianFiltering(img, sigma_s)
    kernel_size_s = 4*sigma_s+1;
    gaussian_filter_spatial = fspecial('gaussian', kernel_size_s, sigma_s);
    img_gaussian_spatial = conv2(img,gaussian_filter_spatial,'same');
end


function [ img2_filtered, img2_pad, img2_fft, gaussian_filter_frequency ] = frequencyGaussianFiltering(img, sigma_s)
    % Convert image to frequency domain
    %%% Pad image to solve periodicity problem
    img2_pad = padarray(img,size(img),'post');
    %%% Shift imag
    img2_pad = img2_pad .* (-1).^((meshgrid(1:size(img2_pad,2), 1:size(img2_pad,1))) + meshgrid(1:size(img2_pad,1), 1:size(img2_pad,2)).');
    %%% Convert to frequency domain
    img2_fft = fft2(img2_pad);

    % Compute gaussian kernel for frequency domain
    sigma_f = (1/(2*pi*sigma_s));
    kernel_size_f = size(img2_pad);
    gaussian_filter_frequency = fspecial('gaussian', kernel_size_f, sigma_f);
    % gaussian_filter_frequency = fftshift(gaussian_filter_frequency);
    % gaussian_filter_frequency = gaussian_filter_frequency / sum(gaussian_filter_frequency(:));

    % Perform gaussian filtering in frequency domain
    img2_fft_filtered = img2_fft .* gaussian_filter_frequency;
    %%% Bring image back to spatial domain
    img2_filtered = ifft2(img2_fft_filtered);
    %%% Shift image back
    img2_filtered = img2_filtered .* (-1).^((meshgrid(1:size(img2_filtered,2), 1:size(img2_filtered,1))) + meshgrid(1:size(img2_filtered,1), 1:size(img2_filtered,2)).');
    %%% Crop image
    img2_filtered = img2_filtered(1:size(img,1),1:size(img,2));
end