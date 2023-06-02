rng(42); % seed

img = im2double(imread("./media/queen.jpg"));

[img, img_clustered, edges, im_stylized] = filter(img);


% 6. Plot and store the results
imwrite(im2uint8(img), "./out/6.img.jpg");
imwrite(im2uint8(img_clustered), "./out/6.img_clustered.jpg");
imwrite(im2uint8(edges), "./out/6.img_clustered_edges.jpg");
imwrite(im2uint8(im_stylized), "./out/6.im_stylized.jpg");




function [img, img_clustered, edges, im_stylized] = filter(img)
    % 1. Cluster the image colors
    clusters = 16;
    [img_clustered, cluster_idx, cluster_center ] = clusterColors(img, clusters);

    % 2. Find edges using Canny algorithm
    edges = edge(rgb2gray(img), 'canny', 0.1);

    % 4. Use the edges as a mask to stylize the image
    im_stylized = img_clustered.*~edges;

    % 5. Saturate the colors in HSV space
    im_stylized = rgb2hsv(im_stylized);
    im_stylized(:, :, 2) = im_stylized(:, :, 2)*1.5;
    im_stylized = hsv2rgb(im_stylized);

    edges = gray2rgb(edges, img);
    imshow([img, img_clustered, edges, im_stylized], []);

    function [img_clustered, cluster_idx, cluster_center ] = clusterColors(img, n_clusters)
        % Cluster
        A = reshape(img, [], 3);
        [cluster_idx, cluster_center] = kmeans(A, n_clusters);     
        % Compute clustered image
        img_clustered = reshape(cluster_center(cluster_idx, :), size(img, 1), size(img, 2), 3);
    end
end