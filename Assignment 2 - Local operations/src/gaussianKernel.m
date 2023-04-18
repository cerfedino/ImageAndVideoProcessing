function res = gaussianKernel(sigma, angle)
    if sigma == 0
        res = 1;
        return;
    end
    if size(sigma) == 1
        sigma = [sigma, sigma];
    end
    angle = deg2rad(angle);
    kernelsize = 4*sigma+1;
    kernelsize = abs([cos(angle) sin(angle)]) .* kernelsize(1) + abs([sin(angle) cos(angle)]) .* kernelsize(2);
    % kernelsize = [abs(cos(angle))*kernelsize(1) + abs(sin(angle))*kernelsize(2), abs(sin(angle))*kernelsize(1) + abs(cos(angle))*kernelsize(2)];

    [X,Y] = meshgrid(1:kernelsize(2),1:kernelsize(1));
    X = X - kernelsize(2)/2; 
    Y = Y - kernelsize(1)/2;
    Xg = X * cos(angle) - Y * sin(angle);
    Yg = X * sin(angle) + Y * cos(angle);

    res = exp(-(Xg.^2/(2*sigma(2)^2) + Yg.^2/(2*sigma(1)^2)));
    res = res / sum(res(:));
end