% create a gaussian function
gauss = @(x,mu,sigma) exp(-(x-mu).^2./(2*sigma^2));

% plot the gaussian function
x = linspace(-50,50,1000);

% create a sinc function
sinc = @(x) sin(x)./x;
% plot(x,sinc(x),'k--','LineWidth',2);

% create a box function
box = @(x) (abs(x)<1);
% plot(x,box(x),'k-','LineWidth',2);

% plot the product of the two functions in fourier space
fftgauss = fftshift(fft(gauss(x,0,0.3)));
fftsinc = fftshift(fft(sinc(5*x)));
fftprod = fftshift(fft(gauss(x,0,0.3).*sinc(5*x)));

plot(x, abs(fftshift(fft(box(1*x).*gauss(x,0,0.5)))),'black-','LineWidth',2);
% set y axis limits
axis([-50 50 0 13]);
print('out/5.gw.pdf','-dpdf', '-fillpage');
plot(x, abs(fftshift(fft(gauss(x,0,0.5)))),'black-','LineWidth',2);
axis([-50 50 0 13]);
print('out/5.hw.pdf','-dpdf', '-fillpage');
