rng(42); % seed

img = im2double(imread('media/queen.jpg'));

n_clusters = 32;

% 1.1 Find HSV quantized image and LUT with 32 colors
img_hsv = rgb2hsv(img);
[img_clustered_hsv, cluster_idx, cluster_color_hsv] = clusterColors(img_hsv, n_clusters);

% BONUS: Find CIELAB quantized image and LUT with 32 colors
img_lab = rgb2lab(img);
[img_clustered_lab, cluster_idx, cluster_color_lab] = clusterColors(img_lab, n_clusters);

%  1.2 Find HSV grayscale quantized image and LUT with 32 colors
cluster_color_gray = cluster_color_lab(:, 1) / 100; % Taking Luminance into account
img_clustered_gray = reshape(cluster_color_gray(cluster_idx, :), size(img, 1), size(img, 2), 1);


%  3. Store results
figure;
subplot(1, 4, 1);
imshow(img); title('Original')
subplot(1, 4, 2);
imshow(hsv2rgb(img_clustered_hsv)); title('HSV')
subplot(1, 4, 3);
imshow(img_clustered_gray); title('CIELAB - Luminance')
subplot(1, 4, 4);
imshow(lab2rgb(img_clustered_lab)); title('CIELAB')


imwrite(img, 'out/2.img.png')
imwrite(lab2rgb(img_clustered_lab), 'out/2.lab.png')
imwrite(img_clustered_gray, 'out/2.gray.png')
imwrite(hsv2rgb(img_clustered_hsv), 'out/2.hsv.png')

function [img_clustered, cluster_idx, cluster_color ] = clusterColors(img, n_clusters)
    % 1. Cluster
    A = reshape(img, [], 3);
    [cluster_idx, cluster_color] = kmeans(A, n_clusters);
    
    % Compute clustered image
    img_clustered = reshape(cluster_color(cluster_idx, :), size(img, 1), size(img, 2), 3);
end
