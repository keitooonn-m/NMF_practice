function display_power_spectrogram(spectrogram,ylim)

power_spectrogram = 20*log10(abs(spectrogram));

%---------------グラフの編集---------------
imagesc(power_spectrogram);
    title("title",'Interpreter','none');
    axis xy;
    xlabel("time [s]");
    ylabel("frequsency [Hz]",'Interpreter','none');
    ylim([0,ylim/1024]);
%----------------------------------------

end %end of call_STFT