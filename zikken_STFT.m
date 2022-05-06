clc;clear;

addpath("github_repo");
addpath("songKitamura/GPO/melody1");
addpath("function");
F = DGTtool();
[data,fs] = audioread("gpo_hr.wav");

spectrogram = F(data);

%theta_spectrogram = angle(spectrogram);
display_amplitude_spectrogram(spectrogram,fs,1000);

F.plot(data,fs)