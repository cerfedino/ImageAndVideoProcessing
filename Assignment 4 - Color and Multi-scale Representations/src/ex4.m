% Load images
img_happy = im2double(imread('media/happy.jpg'));
img_sad = im2double(imread('media/sad.jpg'));

figure("Name", "Hybrid images for different sigma values");
sigma_max=5;
sigma_incr = 0.5;
% 4. Create multiple downsampled versions of hybrid image
for cutoff = sigma_incr:sigma_incr:sigma_max
    % 1. High pass filter on happy
    img_happy_filt = img_happy - imgaussfilt(img_happy, cutoff);
    % 2. Low pass filter on sad
    img_sad_filt = imgaussfilt(img_sad, cutoff);

    % 3. Compute hybrid image
    img_hybrid = img_happy_filt + img_sad_filt;
    subplot(1,sigma_max*2,cutoff*2);

    imshow(img_hybrid)
    imwrite(img_hybrid, sprintf('out/4.hybrid_sigma(%.1f).jpg', cutoff));
end


% Display images
figure("Name", sprintf('Hybrid images for sigma = %.1f', sigma_max));
subplot(1,3,1);
imshow(img_happy_filt); imwrite(img_happy_filt, sprintf('out/4.img_happy_filt_sigma(%.1f).jpg', sigma_max));
subplot(1,3,2);
imshow(img_sad_filt); imwrite(img_sad_filt, sprintf('out/4.img_sad_filt_sigma(%.1f).jpg', sigma_max));
subplot(1,3,3);
imshow(img_hybrid); imwrite(img_hybrid, sprintf('out/4.img_hybrid_sigma(%.1f).jpg', sigma_max));
