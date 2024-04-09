clear
clc

% To generate a signal, you first choose the sample times for each point of
% the signal. You can choose sample times by specifying the following:
% - Sample rate fs in Hertz (Hz)
% - Start time in seconds
% - End time in seconds

earthquake = readmatrix("earthquakes.csv");
earthquake_values = earthquake(:,3);
plot(t, sig)

% It is common to add noise to generated signals. Noise makes the signals 
% more realistic and helps you to test if your signal processing techniques
% are robust to noisy data

noise = randn(size(sig))*0.1; % A noise vector of normally distributed random numbers 
% with same size sig
sigNoisy = sig+noise; % Obtaining Noisy Signal
figure
plot(t,sigNoisy)

% Other signal functions
sq = square(2*pi*f*t); % Square Signal Function
figure
plot(t,sq)
sqNoisy = sq+noise; % Obtaining Square Noisy Signal
figure
plot(t,sqNoisy)