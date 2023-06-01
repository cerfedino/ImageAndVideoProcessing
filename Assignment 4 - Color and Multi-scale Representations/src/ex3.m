% Load images
img_happy = im2double(imread('media/happy.jpg'));
img_sad = im2double(imread('media/sad.jpg'));


% 1. Compute Gaussian and Laplacian pyramids
layers = 4;
[happy_gaussian_pyramid, happy_laplacian_pyramid] = compute_pyramids(img_happy, layers);
[sad_gaussian_pyramid, sad_laplacian_pyramid] = compute_pyramids(img_sad, layers);

% 2. Reconstruct original image from Laplacian pyramid
happy_reconstructed = reconstruct_from_laplacian(happy_laplacian_pyramid);
sad_reconstructed = reconstruct_from_laplacian(sad_laplacian_pyramid);





layers = layers + 1;
% 3. Plot and save results
figure("Name","Pyramid layers for happy.jpg");
for i = 1:layers
    subplot(2,layers,i);
    imshow(happy_gaussian_pyramid{i});
    title(['Gaussian Pyramid Layer ',num2str(i)]);
    subplot(2,layers,i+layers);
    imshow(happy_laplacian_pyramid{i});
    title(['Laplacian Pyramid Layer ',num2str(i)]);

    imwrite(happy_gaussian_pyramid{i},['out/3.happy_gaussian_pyramid_',num2str(i),'.png']);
    imwrite(happy_laplacian_pyramid{i} .* 0.7 + 0.5,['out/3.happy_laplacian_pyramid_',num2str(i),'.png']);
end
figure("Name","Pyramid layers for sad.jpg");
for i = 1:layers
    subplot(2,layers,i);
    imshow(sad_gaussian_pyramid{i});
    title(['Gaussian Pyramid Layer ',num2str(i)]);
    subplot(2,layers,i+layers);
    imshow(sad_laplacian_pyramid{i});
    title(['Laplacian Pyramid Layer ',num2str(i)]);

    imwrite(sad_gaussian_pyramid{i},['out/3.sad_gaussian_pyramid_',num2str(i),'.png']);
    imwrite(sad_laplacian_pyramid{i}.* 0.7 + 0.5,['out/3.sad_laplacian_pyramid_',num2str(i),'.png']);
end

imwrite(happy_reconstructed,'out/3.happy_reconstructed.png');
imwrite(sad_reconstructed,'out/3.sad_reconstructed.png');

figure("Name","Reconstructed images");
subplot(1,2,1);
imshow(happy_reconstructed);
subplot(1,2,2);
imshow(sad_reconstructed);



function [gaussian_pyramid, laplacian_pyramid] = compute_pyramids(img, layers)
    layers = layers+1;
    gaussian_pyramid = cell(1,layers);
    gaussian_pyramid{1} = img;

    % compute gaussian pyramid
    for i = 2:layers
        prev_img = gaussian_pyramid{i-1};
        new_img = imgaussfilt(prev_img,1);
        new_img = imresize(new_img,0.5,'nearest');
        gaussian_pyramid{i} = new_img;
    end

    % compute laplatian pyramid
    laplacian_pyramid = cell(1,layers);
    for i = 1:layers-1
        prev_img = gaussian_pyramid{i};
        next_img = gaussian_pyramid{i+1};
        laplacian_pyramid{i} = prev_img - imresize(next_img,[size(prev_img,1),size(prev_img,2)],'nearest');
    end
    laplacian_pyramid{layers} = gaussian_pyramid{layers};
    
end


function [img] = reconstruct_from_laplacian(laplacian_pyramid)
    layers = size(laplacian_pyramid,2);
    img = laplacian_pyramid{layers};
    for i = layers-1:-1:1
        img = imresize(img,[size(laplacian_pyramid{i},1),size(laplacian_pyramid{i},2)],'nearest') ...
                + laplacian_pyramid{i};
    end
end
