%% A.1 - Creation and dimensions
v1 = 1:2:9
v2 = linspace(0,1,5)
v3 = 10:-1:1
L1 = length(v1)
S1 = size(v1)
v1c = v1'
w = [v1 v3]
W = [v1; v2]        % works (1x5 and 1x5)
% W = [v1; v3]      % error: 1x5 and 1x10 do not match

%% A.2 - Element-wise vs matrix
A = [1 2; 3 4]; B = [5 6; 7 8];
A*B, A.*B, A^2, A.^2, A/B, A./B

%% A.3 - Indexing
v = 10:-1:1;
v(2:2:end)
find(v>5), v(find(v>5)), v(v>5)
v(v>5) = 0
v = 10:-1:1; v(end-2:end)
v(end:-1:1)

%% A.4 - Aggregation
A = [2 7 4; 9 1 5; 3 8 6];
sum(A), sum(A,2), sum(A(:)), mean(A(:)), max(A), max(A(:)), min(A,[],2)
idx = find(A>5)
[r,c] = find(A>5)

%% A.5 - Linear system
A = [2 1 -1; -3 -1 2; -2 1 2]; b = [8; -11; -3];
x = A\b
res = A*x - b, norm(res)
pinv(A)*b
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

%% C.1 - Basic sinusoid
A = 2;
f0 = 5;
phi = pi/3;
Fs = 1000;
Ts = 1/Fs;
t = 0 : Ts : 1-Ts;            % exactly Fs samples for 1 second
x = A*cos(2*pi*f0*t + phi);

figure
plot(t, x, 'b', 'LineWidth', 1.5)
hold on
xlabel('Time (s)');
ylabel('Amplitude');
title('Sinusoidal Signal x(t)');
grid on

yline(A,  '--r', 'LineWidth', 1.2)
yline(-A, '--r', 'LineWidth', 1.2)

x0 = A*cos(phi);              % value at t = 0
plot(0, x0, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 8);

%% C.2 - Sum of harmonics: square-wave approximation
Fs = 2000;
t = 0:1/Fs:1;
f0 = 2;
K_values = [1, 3, 7, 21];

% a) and b) loop over odd k, 2x2 subplot grid
figure;
for i = 1:length(K_values)
    K = K_values(i);
    s = zeros(size(t));
    for k = 1:2:K
        s = s + (4/pi) * (1/k) * sin(2*pi*k*f0*t);
    end

    subplot(2, 2, i);
    plot(t, s, 'LineWidth', 1.2);
    grid on;
    xlabel('Time (s)');
    ylabel('Amplitude');
    title(['Approximation with K = ', num2str(K)]);
end

% c) Bonus: same computation without a loop (outer product)
K = 21;
k = (1:2:K)';                                   % column of odd harmonics
s = sum((4./(pi*k)) .* sin(2*pi*f0*(k*t)), 1);  % one row per harmonic, sum over rows

figure;
plot(t, s, 'LineWidth', 1.2);
grid on;
xlabel('Time (s)');
ylabel('Amplitude');
title('Square wave, K = 21, without a loop');

%% C.3 - Complex exponential
Fs = 200;
t = 0:1/Fs:1;
f0 = 3;
z = exp(1j*2*pi*f0*t);

% a) real and imaginary parts
figure;
subplot(2, 1, 1);
plot(t, real(z));
grid on;
xlabel('Time (s)');
ylabel('Re(z)');
title('Real Part');

subplot(2, 1, 2);
plot(t, imag(z));
grid on;
xlabel('Time (s)');
ylabel('Im(z)');
title('Imaginary Part');

% b) trajectory in the complex plane (a circle)
figure;
plot(real(z), imag(z), 'LineWidth', 1.5);
grid on;
axis equal;
xlabel('Re(z)');
ylabel('Im(z)');
title('Trajectory in the Complex Plane');

% c) |z| is constant (about 0 means constant, equal to 1)
spread = max(abs(z)) - min(abs(z))

% d) cosine rebuilt from two complex exponentials
xc = 0.5*(exp(1j*2*pi*f0*t) + exp(-1j*2*pi*f0*t));
err = max(abs(xc - cos(2*pi*f0*t)))             % about 0: same cosine

figure;
plot(t, real(xc), 'LineWidth', 1.2);
grid on;
xlabel('Time (s)');
ylabel('Amplitude');
title('Cosine from two complex exponentials');

%% C.4 - Elementary signals
n = -10:10;

% a) shifted Kronecker impulse delta[n-3]
n0 = 3;
delta = (n == n0);

figure;
subplot(3, 1, 1);
stem(n, delta, 'filled');
grid on;
xlabel('n'); ylabel('Amplitude');
title('Kronecker Impulse \delta[n - 3]');

% b) unit step u[n-2]
u = (n >= 2);

subplot(3, 1, 2);
stem(n, u, 'filled');
grid on;
xlabel('n'); ylabel('Amplitude');
title('Unit Step u[n - 2]');

% c) rectangular pulse of width N = 5 centred at n = 0
N = 5;
rect = (abs(n) <= (N-1)/2);

subplot(3, 1, 3);
stem(n, rect, 'filled');
grid on;
xlabel('n'); ylabel('Amplitude');
title('Rectangular Pulse rect_5[n]');

%% C.5 a) - DTMF function
% dtmf(digit, Fs, Td) is in its own file dtmf.m (same folder as lab1.m).
x = dtmf('5', 8000, 0.2);
size(x)

%% C.7 b) and c) - Normalise, play, waveform and spectrum (digit 5)
Fs = 8000;
Td = 0.2;
x = dtmf('5', Fs, Td);
x = 0.9 * x / max(abs(x));     % maximum absolute value = 0.9
sound(x, Fs);

figure;
subplot(2, 1, 1);
plot((0:length(x)-1)/Fs, x);
grid on;
xlabel('Time (s)');
ylabel('Amplitude');
title('DTMF Waveform (Digit 5)');

subplot(2, 1, 2);
X_fft = abs(fft(x));
f_axis = (0:length(X_fft)-1) * (Fs / length(X_fft));
plot(f_axis, X_fft);
grid on;
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
title('Magnitude Spectrum (FFT)');
xlim([0 2000]);                % two peaks: 770 Hz and 1336 Hz

%% C.5 d) - Synthesise a phone number
phoneNumber = '0123456789';    % <-- replace by your own number
Fs = 8000;
Td = 0.2;
pauseDuration = 0.08;
silence = zeros(1, round(Fs * pauseDuration));

x_total = [];
for i = 1:length(phoneNumber)
    digit = phoneNumber(i);
    x = dtmf(digit, Fs, Td);
    x = 0.9 * x / max(abs(x));
    x_total = [x_total, x, silence];
end

sound(x_total, Fs);
audiowrite('full_phone_number.wav', x_total, Fs);

% plot a part of the signal (the lab asks for it)
figure;
plot((0:length(x_total)-1)/Fs, x_total);
grid on;
xlabel('Time (s)');
ylabel('Amplitude');
title('DTMF signal of the phone number');
xlim([0 1]);
