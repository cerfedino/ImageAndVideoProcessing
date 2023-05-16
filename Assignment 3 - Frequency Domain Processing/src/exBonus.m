% read image
I = imread('cameraman.tif');
I = im2double(I);
% crop the image
I = I(50:82, 110:142);

% upscale the image by 2, the new pixels should be black
I_up = zeros(size(I,1)*2, size(I,2)*2);
I_up(1:2:end, 1:2:end) = I(1:end, 1:end);

I_down = I_up(1:2:end, 1:2:end);
I_down2 = I_up(2:2:end, 2:2:end);

kernel_nn = [1 1 0];
kernel_nn = kernel_nn' * kernel_nn;
% convolve the image with the kernel
I_conv_nn = conv2(I_up, kernel_nn, 'valid');


% use a linear interpolation kernel
kernel_l = [0.5 1 0.5];
kernel_l = kernel_l' * kernel_l;
% convolve the image with the kernel
I_conv_l = conv2(I_up, kernel_l, 'valid');


figure;
subplot(1,4,1);
imshow(I);
title('original');
subplot(1,4,2);
imshow(I_up);
title('upscaled by 2');
subplot(1,4,3);
imshow(I_conv_nn);
title('nearest neighbor');
subplot(1,4,4);
imshow(I_conv_l);
title('linear interpolation');

imwrite(I, 'out/8.cameraman_crop.png');
imwrite(I_up, 'out/8.cameraman_up.png');
imwrite(I_conv_nn, 'out/8.cameraman_nn.png');
imwrite(I_conv_l, 'out/8.cameraman_l.png');








% compute ratio between FFT of I_conv_nn and I_conv_l
I_conv_nn_fft = fftshift(fft2(I_conv_nn));
I_conv_l_fft = fftshift(fft2(I_conv_l));
figure;
hold on;
% plot(log(abs(fftshift(fft(I(16,:))))), 'g-', 'MarkerSize', 2);
I_conv_nn_log = log(abs(fftshift(fft(I_conv_nn(32,:)))))
I_conv_l_log = log(abs(fftshift(fft(I_conv_l(32,:)))))
plot(I_conv_nn_log, 'r-', 'MarkerSize', 2);
plot(I_conv_l_log, 'b-', 'MarkerSize', 2);
hold off;

figure;
hold on;
plot(I_conv_nn(32,:), 'r-', 'MarkerSize', 2);
plot(I_conv_l(32,:), 'b-', 'MarkerSize', 2);;
% % plot(I(32,:), 'g-', 'MarkerSize', 2);
hold off;

fourierPlots = [ (-size(I_conv_nn(32,:),2)/2:size(I_conv_nn(32,:),2)/2-1)' I_conv_nn_log' I_conv_l_log'   ];
matrix2tablebody(fourierPlots, "./out/8.fourier.dat", '%.5f', ["x", "y", "z"], ' ',sprintf('\n'))
intensitiesPlots = [ (1:size(I_conv_nn(32,:),2))' I_conv_nn(32,:)' I_conv_l(32,:)'   ];
matrix2tablebody(intensitiesPlots, "./out/8.intensities.dat", '%.5f', ["x", "y", "z"], ' ',sprintf('\n'))
