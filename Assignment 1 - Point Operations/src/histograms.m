im = imread("./media/ferrari.JPG");


%% Exercise 3
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

%% Exercise 4.1 - Global histogram equalization
imhsv = rgb2hsv(im);
% Cumulative distribution function of the image histogram

[equalized_channel, original_brightness_distribution] = global_histogram_equalization(imhsv);

figure(); imshow(hsv2rgb(imhsv)); title("Original image")
saveas(gcf,'out/4.1.ferrari.png')
figure(); area(original_brightness_distribution); title("Original intensity histogram")
saveas(gcf,'out/4.1.ferrari_hist.png')

% Apply the transformation
imhsv(:,:,3) = equalized_channel;


[equalized_brightness_distribution, ~ ] = imhist(imhsv(:,:,3));
figure(); imshow(hsv2rgb(imhsv)); title("Equalized image (global)")
saveas(gcf,'out/4.1.ferrari_globalnorm.png')
figure(); area(equalized_brightness_distribution); title("Equalized intensity histogram (global)")
saveas(gcf,'out/41.ferrari_globalnorm_hist.png')

%% Exercise 4.2 - Local histogram equalization

TILENO = 4; % Divides the image into nxn = n^2 tiles
imloceq = local_histogram_equalization(rgb2hsv(im), TILENO);

figure(); imshow(hsv2rgb(imloceq)); title(sprintf("Equalized image (local - %d x %d tiles)", TILENO, TILENO));
saveas(gcf,'out/4.2.ferrari_localnorm.png')


%% Exercise 4.3 BONUS - Locally adaptive histogram equalization

TILESIZE = 40; % Divides the image into nxn = n^2 tiles
imlocadapteq = locally_adaptive_histogram_equalization(rgb2hsv(im), TILESIZE);

[normalized_brightness_distribution, ~ ] = imhist(imlocadapteq(:,:,3));

figure(); imshow(hsv2rgb(imlocadapteq)); title(sprintf("Equalized image (locally adaptive - %dpx x %dpx tile size)", TILESIZE, TILESIZE));
saveas(gcf,'out/4.3.ferrari_locallyadaptivenorm.png')
figure(); area(normalized_brightness_distribution); title("Equalized intensity histogram (global)")
saveas(gcf,'out/41.ferrari_globalnorm_hist.png')



% TODO: Can I use the built in function for Exercise 4 ?
function [distribution] = compute_distribution(channel)
    distribution = cell2mat(arrayfun(@(x) sum(sum(channel==x)), 0:255,'UniformOutput',false));
end
function [equalized_channel, original_brightness_distribution] = global_histogram_equalization(imhsv)
    channel = imhsv(:,:,3);
    % Cumulative distribution function of the image histogram
    [original_brightness_distribution, ~ ] = imhist(channel);
    cdf = cumsum(original_brightness_distribution);
    cdf = cdf / cdf(end);
    % Apply the transformation
    equalized_channel = cdf(round(channel*255+1));
end

function [imhsv_equalized] = local_histogram_equalization(imhsv, TILENO)
    imhsv_equalized = imhsv;
    im_size = size(imhsv_equalized);
    tile_size = floor((im_size(1:2)/TILENO));
    for row = 0:TILENO-1
        for col = 0:TILENO-1
            imageUB = round(([row col].*tile_size)) + 1;
            imageLB = round(([row col].*tile_size) + tile_size);
            tile = imhsv_equalized(imageUB(1):imageLB(1),imageUB(2):imageLB(2),:);
            [equalized_tile, ~ ] = global_histogram_equalization(tile);
            imhsv_equalized(imageUB(1):imageLB(1),imageUB(2):imageLB(2),3) = equalized_tile;
        end
    end
end


function [imhsv_equalized] = locally_adaptive_histogram_equalization(imhsv, TILESIZE)
    imhsv_equalized = imhsv;
    im_size = size(imhsv_equalized);
    sprintf("");
    for y = 1:im_size(1)
        fprintf("\rProcessing row %d/%d", y, im_size(1))
        for x = 1:im_size(2)
            imageUB = round(max([[y x] - (TILESIZE/2); 1 1]));
            imageLB = round(min([[y x] + (TILESIZE/2); im_size(1:2)]));;
            tile = imhsv_equalized(imageUB(1):imageLB(1), imageUB(2):imageLB(2),:);
            [equalized_tile, ~ ] = global_histogram_equalization(tile);

            imhsv_equalized(y,x,3) = equalized_tile(y-imageUB(1)+1, x-imageUB(2)+1);
        end
    end
end