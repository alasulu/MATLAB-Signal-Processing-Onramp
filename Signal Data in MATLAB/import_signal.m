clear
clc

% The readmatrix function imports a numeric matrix from a file.
earthquake = readmatrix("earthquakes.csv");
earthquake_values = earthquake(:,3);
plot(earthquake_values)
% But it does not look so reliable, additionally we will create our seismic 
% wave signal manually

sampling_rate = 1000; % Sampling rate in Hz
duration = 5; % Duration of the signal in seconds
frequencies = [5, 10, 20, 50]; % Frequencies of the seismic waves in Hz
amplitudes = [1, 0.5, 0.2, 0.7]; % Amplitudes of the seismic waves
t = 0:1/sampling_rate:duration;
% Generate seismic wave signals
signal = zeros(size(t));
for i = 1:length(frequencies)
    signal = signal + amplitudes(i) * sin(2 * pi * frequencies(i) * t);
end

% Instead of storing your signal in a numeric variable and keeping track 
% of the time information separately, you can use a timetable. A timetable
% is a table where each sample has an associated time.
tbl = readtimetable("earthquakes.csv","SampleRate",50);
figure
plot(tbl,"impact_magnitude")
figure
plot(t,signal)

%% Rule:
%The sample rate determines the highest frequency that can be correctly
%represented in a sampled signal. So before you change the sample rate,
%you should look at the power spectrum to see where the frequencies are located.
%That is called Nyquist Theorem " fmax = fs/2 " 