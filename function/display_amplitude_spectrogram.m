function display_amplitude_spectrogram(spectrogram,fs,ylim)

amplitude_spectrogram = abs(spectrogram);

%---------------グラフの編集---------------
imagesc(20*log10(amplitude_spectrogram));
    title("Amplitude spectrogram");
    axis xy;
    xlabel("Time [s]");
    ylabel("Frequsency [Hz]");
    ylim([0,int16(fs*ylim/1024)]);
%----------------------------------------

end