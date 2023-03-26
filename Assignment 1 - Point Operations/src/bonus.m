cleanplate = imread("./media/bonus/cleanplate.jpg");
a1 = imread("./media/bonus/a1.jpg");
a2 = imread("./media/bonus/a2.jpg");
a3 = imread("./media/bonus/a3.jpg");
a4 = imread("./media/bonus/a4.jpg");
a5 = imread("./media/bonus/a5.jpg");
a6 = imread("./media/bonus/a6.jpg");

hue_deviation = 0.00005;
saturation_deviation = 0.00005;
brightness_deviation = 0.06;

cleanplate_hsv = rgb2hsv(cleanplate);
cleanplate_mask = getDiffMask(cleanplate_hsv, cleanplate_hsv, hue_deviation, saturation_deviation, brightness_deviation);
a1_mask = getDiffMask(cleanplate_hsv, rgb2hsv(a1), hue_deviation, saturation_deviation, brightness_deviation);
a2_mask = getDiffMask(cleanplate_hsv, rgb2hsv(a2), hue_deviation, saturation_deviation, brightness_deviation);
a3_mask = getDiffMask(cleanplate_hsv, rgb2hsv(a3), hue_deviation, saturation_deviation, brightness_deviation);
a4_mask = getDiffMask(cleanplate_hsv, rgb2hsv(a4), hue_deviation, saturation_deviation, brightness_deviation);
a5_mask = getDiffMask(cleanplate_hsv, rgb2hsv(a5), hue_deviation, saturation_deviation, brightness_deviation);
a6_mask = getDiffMask(cleanplate_hsv, rgb2hsv(a6), hue_deviation, saturation_deviation, brightness_deviation);


white_bg = ones(size(cleanplate)).*255;

figure()
imshow([cleanplate, a1, a2, a3, a4, a5, a6;
    white_bg.*cleanplate_mask, white_bg.*a1_mask, white_bg.*a2_mask, white_bg.*a3_mask, white_bg.*a4_mask, white_bg.*a5_mask, white_bg.*a6_mask ])
title("Images and their masks")
saveas(gcf,'out/8.images_masks.png')


a1 = double(a1)./255;
a2 = double(a2)./255;
a3 = double(a3)./255;
a4 = double(a4)./255;
a5 = double(a5)./255;
a6 = double(a6)./255;
cleanplate = double(cleanplate)./255;

figure()
imshow([comp(a6,a6_mask, comp(a5, a5_mask, comp(a4, a4_mask, comp(a3, a3_mask, comp(a2, a2_mask, comp(a1, a1_mask, cleanplate))))))],[])
title("Comped image")
saveas(gcf,'out/8.im_comped.png')

function mask = getDiffMask(a_hsv, b_hsv, hue_deviation, saturation_deviation, brightness_deviation)
    diff = abs(a_hsv - b_hsv);
    mask = ((diff(:,:,1) >= hue_deviation) & (diff(:,:,2) >= saturation_deviation) & (diff(:,:,3) >= brightness_deviation));
end


function res = comp(a, mask, b)
    % Masks image 'a' on top of image 'b'
    res = a.*mask + b.*(~mask);
end