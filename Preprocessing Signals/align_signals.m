clear
clc

% The alignsignals function aligns two signals by delaying the earlier signal.

% Because alignsignals works by delaying earlier signals, if you have more
% than two signals, you need to know which signal arrived last. In the example 
% above, the third signal arrived last. So you would delay the first two signals
% to align with the third signal.

% If the last signal isn't obvious from the time-domain plot, you can use the
% finddelay function to find which signal arrived last. If the delay is negative, 
% the first signal arrived after the second signal. If the delay is positive, 
% the first signal arrived before the second signal.

%% Adding delay firstly for incoming calculations.
fs = 500; % Sampling rate
earthquake = readmatrix("earthquakes.csv");
earthquake_values = earthquake(:,3);
% Define delay in seconds
delay1 = 0.25; % 0.25 seconds
delay2 = 0.50; % 0.50 seconds
% Convert delay to samples
delay_samples1 = round(delay1 * fs);
delay_samples2 = round(delay2 * fs);
% Apply delay manually
delayed_earthquake1 = [zeros(delay_samples1, 1); earthquake_values(1:end-delay_samples1)];
delayed_earthquake2 = [zeros(delay_samples2, 1); earthquake_values(1:end-delay_samples2)];
% Plot original and delayed earthquakes
t = ((0:length(earthquake_values)-1) / fs);

delay1 = finddelay(earthquake_values,delayed_earthquake1); % Earthquake values arrived 125 samples before earthquake 1
disp(delay1)
delay2 = finddelay(earthquake_values,delayed_earthquake2); % Earthquake values arrived 250 samples before earthquake 2
disp(delay2)
delay3 = finddelay(delayed_earthquake2,delayed_earthquake1); % Earthquake 2 arrived 125 samples after earthquake 1
disp(delay3)

%The order of inputs to the function doesn't matter because alignsignals will always pad the earlier signal.
[delayed_earthquake3,delayed_earthquak4] = alignsignals(delayed_earthquake1,delayed_earthquake2);
[earthquake_values2,delayed_earthquake5] = alignsignals(earthquake_values,delayed_earthquake1);

figure
plot(earthquake_values)
hold on
plot(delayed_earthquake1)
plot(delayed_earthquake2)
hold off
legend("Earthquake Values","Delayed Earthquake1","Delayed Earthquake2")
ylim([0 8])

figure
plot(earthquake_values2)
hold on
plot(delayed_earthquake3)
plot(delayed_earthquake5)
hold off
legend("Earthquake Values","Delayed Earthquake1","Delayed Earthquake2")
ylim([0 8])
title("Aligned Signals")