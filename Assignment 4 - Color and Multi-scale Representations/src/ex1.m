
% 1. Load image
img = im2double(imread('media/queen.jpg'));

% 2. Convert to XYZ
img_xyz = rgb2xyz(img);

n_clusters = 7;
[rgb_clustered, rgb_palette, rgb_layers] = clusterColors(img, n_clusters);
[xyz_clustered, xyz_palette, xyz_layers] = clusterColors(img_xyz, n_clusters);



% 5.1. Plot RGB results

imwrite(rgb_clustered, 'out/1.1.rgb_clustered.png');
figure('Name', 'RGB Clustered image');
imshow(rgb_clustered);
figure('Name', 'RGB Palette');
hold on;
for i = 1:n_clusters
    imwrite(rgb_palette{i}, sprintf('out/1.1.rgb_palette_%d.png', i));
    imwrite(rgb_layers{i}, sprintf('out/1.1.rgb_layer_%d.png', i));

    subplot(2, n_clusters, i);
    imshow(rgb_palette{i});
    subplot(2, n_clusters, i + n_clusters);
    imshow(rgb_layers{i});
end
hold off;


% 5.1. Plot XYZ results
xyz_clustered = xyz2rgb(xyz_clustered);
imwrite(xyz_clustered, 'out/1.1.xyz_clustered.png');
figure('Name', 'XYZ Clustered image');
imshow(xyz_clustered);
figure('Name', 'XYZ Palette');
hold on;
for i = 1:n_clusters
    xyz_color = xyz2rgb(xyz_palette{i});
    xyz_layer = xyz2rgb(xyz_layers{i});

    imwrite(xyz_color, sprintf('out/1.1.xyz_palette_%d.png', i));
    imwrite(xyz_layer, sprintf('out/1.1.xyz_layers%d.png', i));

    subplot(2, n_clusters, i);
    imshow(xyz_color);
    subplot(2, n_clusters, i + n_clusters);
    imshow(xyz_layer);
end
hold off;







function [img_xyz] = rgb2xyz(img_rgb)
    img_xyz = zeros(size(img_rgb));
    mat = [0.4124564 0.3575761 0.1804375;
           0.2126729 0.7151522 0.0721750;
           0.0193339 0.1191920 0.9503041];
    % TODO: bleah
    for i = 1:size(img_rgb, 1)
        for j = 1:size(img_rgb, 2)
            rgb = img_rgb(i, j, :);
            img_xyz(i, j, :) = mat * rgb(:);
        end
    end
end

function [img_rgb] = xyz2rgb(img_xyz)
    img_rgb = zeros(size(img_xyz));
    mat = inv([0.4124564 0.3575761 0.1804375;
           0.2126729 0.7151522 0.0721750;
           0.0193339 0.1191920 0.9503041]);
    % TODO: bleah
    for i = 1:size(img_xyz, 1)
        for j = 1:size(img_xyz, 2)
            xyz = img_xyz(i, j, :);
            img_rgb(i, j, :) = mat * xyz(:);
        end
    end
end


function [img_clustered, img_palette, img_layers] = clusterColors(img, n_clusters)
    % 1. Cluster
    A = reshape(img, [], 3);
    [cluster_idx, cluster_center] = kmeans(A, n_clusters);
    
    % Compute clustered image
    img_clustered = reshape(cluster_center(cluster_idx, :), size(img, 1), size(img, 2), 3);
    % Matrix of cluster indices for corresponding image pixel
    cluster_idx = reshape(cluster_idx, size(img, 1), size(img, 2), 1);
    
    % 2. Separate image into palette layers
    color_square = zeros(size(img));
    img_palette = {};
    img_layers = {};
    for i = 1:n_clusters
        % Create a squared image with a uniform color using function repmat
        color = cluster_center(i, :);
        color_square(:,:,1) = repmat(color(1), size(img, 1), size(img, 2));
        color_square(:,:,2) = repmat(color(2), size(img, 1), size(img, 2));
        color_square(:,:,3) = repmat(color(3), size(img, 1), size(img, 2));
        layer = color_square .* (cluster_idx == i);
        
        img_palette{i} = color_square;
        img_layers{i} = layer;    
    end
end