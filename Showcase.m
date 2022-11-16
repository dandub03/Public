% 3.1
% a)
Fs = 1000;                   % samples per second
dt = 1/Fs;                   % seconds per sample
N = 1000
i = (0:N-1)
Ts = 1/Fs
time = i * Ts
%%Sine wave:
Fc = 50;                     % frequency
A = 1;                       % amplitude
x = A*sin(2*pi*Fc*time) % sine wave 
sq = [ones(1,Fs/Fc/2), -1*ones(1,Fs/Fc/2)]; % single square wave period
xsquare = A*repmat(sq,1,N/length(sq)); % square wave
xrand = randn(N,1); % random signal with mean value 0 and standard deviation 1

% b)
% Sine signal plot
figure;
plot(time(1:100),x(1:100));
xlabel('time');
title('Sine signal');
zoom xon;
% Square signal plot
figure;
plot(time(1:100),xsquare(1:100));
xlabel('time');
title('Square signal');
zoom xon;
% Random signal plot
figure;
plot(time(1:100),xrand(1:100));
xlabel('time');
title('Square signal');
zoom xon;

% c)
% Sine signal
X_fft = Ts*fft(x,N);
y = (abs(X_fft).^2)/N/Ts;
X_psd = y(1:N/2);
X_psd_dB = 10*log10(X_psd);
freq = (0:N/2-1)*Fs/N;
figure;
plot(freq,X_psd_dB,'-*')
xlabel('Frequency');
ylabel('dB');
% Square signal
X_fft = Ts*fft(xsquare,N);
y = (abs(X_fft).^2)/N/Ts;
X_psd = y(1:N/2);
X_psd_dB = 10*log10(X_psd);
freq = (0:N/2-1)*Fs/N;
figure;
plot(freq,X_psd_dB,'-*');
xlabel('Frequency');
ylabel('dB');
% Random signal
X_fft = Ts*fft(xrand,N);
y = (abs(X_fft).^2)/N/Ts;
X_psd = y(1:N/2);
X_psd_dB = 10*log10(X_psd);
freq = (0:N/2-1)*Fs/N;
figure;
plot(freq,X_psd_dB,'-*');
xlabel('Frequency');
ylabel('dB');
% 3.2

% 3.3

% 3.4
