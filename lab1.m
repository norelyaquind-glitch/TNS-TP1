%% B.1 - Read and plot audio
[x, Fs] = audioread('mono.wav');
t = (0:length(x)-1)' / Fs;
plot(t, x); grid on
xlabel('Time (s)'); ylabel('Amplitude'); title('Waveform of mono.wav')
Fs
size(x)
length(x)
whos x
sound(x, Fs)

%% B.2 - Metadata
duration = length(x) / Fs
[xs, Fs2] = audioread('stereo.wav');
size(xs)
xm = mean(xs, 2);
size(xm)
peak = max(abs(x))
sound(x(1:2*Fs), Fs)
x2 = x(1:2*Fs);
length(x2) / Fs

%% B.3 - Image
I = imread('peppers.png');
imshow(I)
class(I)
size(I)
figure
subplot(1,3,1)
imshow(I(:,:,1))
title('Red')
subplot(1,3,2)
imshow(I(:,:,2))
title('Green')
subplot(1,3,3)
imshow(I(:,:,3))
title('Blue')

G = rgb2gray(I);
figure
imshow(G)
title('Grayscale')

Gd = im2double(G);
mean(Gd(:))
min(Gd(:))
max(Gd(:))

%% B.4.a - Crop
crop = I(93:292, 157:356, :);
figure
imshow(crop)
title('Centre crop 200x200')
size(crop)

%% B.4.b - Downsampling by 2
I2 = I(1:2:end, 1:2:end, :);
size(I2)

figure
subplot(1,2,1)
imshow(I)
title('Original')

subplot(1,2,2)
imshow(I2)
title('Downsampled by 2')

I4 = I(1:4:end, 1:4:end, :);
size(I4)
figure
subplot(1,2,1); imshow(I);  title('Original')
subplot(1,2,2); imshow(I4); title('Downsampled by 4')