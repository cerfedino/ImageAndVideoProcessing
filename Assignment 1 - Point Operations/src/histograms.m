im = imread("./media/ferrari.JPG");

% TODO: Am I allowed to use imhist() ?
red_distribution = imhist(im(:,:,1));
green_distribution = imhist(im(:,:,2));
blue_distribution = imhist(im(:,:,3));


figure()
hold on
plot(red_distribution, 'r')
plot(green_distribution, 'g')
plot(blue_distribution, 'b')
title("Color channel distribution of 'ferrari.JPG'")
hold off

% Save plot
saveas(gcf,'out/3.histogram.png')
