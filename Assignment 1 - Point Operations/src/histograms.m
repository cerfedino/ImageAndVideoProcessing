im = imread("./media/ferrari.JPG");

red_distribution = compute_distribution(im(:,:,1));
green_distribution = compute_distribution(im(:,:,2));
blue_distribution = compute_distribution(im(:,:,3));


figure()
hold on
plot(red_distribution, 'r')
plot(green_distribution, 'g')
plot(blue_distribution, 'b')
title("Color channel distribution of 'ferrari.JPG'")
hold off

% Save plot
saveas(gcf,'out/3.histogram.png')

function [distribution] = compute_distribution(channel)
    distribution = cell2mat(arrayfun(@(x) sum(sum(channel==x)), 0:255,'UniformOutput',false));
end