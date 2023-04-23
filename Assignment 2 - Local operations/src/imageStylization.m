im = im2double(imread("./media/delicate_arch.jpg"));

% 1. Find edges using Canny algorithm
im_bilat = imbilatfilt(im, 0.9, 6);
edges = edge(rgb2gray(im_bilat), 'canny');

% 2. Dilate edges
edges = imdilate(edges, strel('disk', 2));

% 3. Use the edges as a mask to stylize the image
im_stylized = im_bilat.*~edges;

imwrite(im2uint8(im), "./out/6.1.im.jpg");
imwrite(im2uint8(im_bilat), "./out/6.1.im_bilat.jpg");
imwrite(im2uint8(gray2rgb(edges, im)), "./out/6.1.im_bilat_edges.jpg");
imwrite(im2uint8(im_stylized), "./out/6.1.im_stylized.jpg");
imshow([im, im_bilat, gray2rgb(edges, im), im_stylized], []);