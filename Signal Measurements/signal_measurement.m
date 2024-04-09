clear
clc
%-----------------%%-----------------%%-----------------%%-----------------%
% Before the signal measurement operation, let's import and quickly
% preprocess the signal
earthquake = readmatrix("earthquakes.csv");
earthquake_values = earthquake(:,3);
fs = 1000; % Sampling frequency (Hz)
t = 0:1/fs:1; % Time vector (1 second duration)
% Design the Butterworth bandpass filter
fc = [1, 8]; % Cutoff frequencies (Hz) for bandpass filter
order = 4; % Filter order
[b, a] = butter(order, fc/(fs/2), 'bandpass'); % Design the filter coefficients
% Apply the filter to the signal
signal_bandpass = filter(b, a, earthquake_values);
%-----------------%%-----------------%%-----------------%%-----------------%
% Then let's start to signal measurement operations
[p,f,t] = pspectrum(signal_bandpass, fs, "spectrogram");
psum = sum(p);
plot(t, psum)
xlim([0, 8]);
xlabel('Time (s)');
ylabel('Frequency'); % Frequency (y) vs Time (x)
%-----------------%
pwr = db(psum,"power"); % Power Spectrum (dB) [y] vs Frequency [x]
figure
plot(t,pwr)
xlabel('Frequency (Hz)')
ylabel('dB')
%-----------------%%-----------------%%-----------------%%-----------------%
% Finding Local Extrema
%-----------------%
% Find local maxima
maxIndices = islocalmax(pwr,"MinProminence",10,"SamplePoints",t);
% Display results
figure
plot(t,pwr,"SeriesIndex",6,"DisplayName","Input data")
hold on
% Plot local maxima
scatter(t(maxIndices),pwr(maxIndices),"^","filled","SeriesIndex",2, ...
    "DisplayName","Local maxima")
title("Number of extrema: " + nnz(maxIndices))
hold off
legend
xlabel("t")
%-----------------%%-----------------%%-----------------%%-----------------%
quakeSec = t(maxIndices); % Where the earthquake dominantly exists
% Each element in quakeSec is the time, in seconds, that an earthquake occurred. 
% Let's visualize the earthquakes at this time
tvec = (0:numel(signal_bandpass)-1)/50;
figure
plot(tvec,signal_bandpass)
xline(quakeSec)
xlim([0, 8]);
xlabel("Time (seconds)")