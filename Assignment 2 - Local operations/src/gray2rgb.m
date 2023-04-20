function rgb = gray2rgb(gray, im)
    I_ycbcr = rgb2ycbcr(double(im)./255);
    J_ycbcr = cat(3,gray,I_ycbcr(:,:,2),I_ycbcr(:,:,3));
    rgb = ycbcr2rgb(J_ycbcr);
end