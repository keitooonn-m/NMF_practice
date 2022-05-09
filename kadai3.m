clc;clear;

addpath("github_repo");
data_filename = "./input/piano+trumpet.wav";
teacher1_filename = "./scaleData/gpo_pf_scale.wav";
teacher2_filename = "./scaleData/gpo_tp_scale.wav";

windowshift = 5;
windowlength = 1500;
windowname = "Hann";
F = DGTtool('windowShift',windowshift,'windowLength',windowlength,'windowName',windowname);


data_vec = audioread(data_filename);
[teacher1_vec,fs] = audioread(teacher1_filename);
[teacher2_vec, ~] = audioread(teacher2_filename);

spectrogram = F(data_vec);
amplitude_spec = abs(spectrogram);
theta_spec = angle(spectrogram);

rep = 30;
K_const = 5;

%なんか知らんけど教師は絶対値とってみた
[output1,output2] = main(amplitude_spec,abs(teacher1_vec),abs(teacher2_vec),rep,K_const);

audiowrite(output1,fs);
audiowrite(output2,fs);

function [output1,output2] = main(data_vec,teacher1_vec,teacher2_vec,rep,K_const)

[tate,yoko] = size(data_vec);
D = data_vec;

W1 = repmat(teacher1_vec,1,K_const);
W2 = repmat(teacher2_vec,1,K_const);

G1 = rand(K_const,tate);
G2 = rand(K_const,tate);

distance = zeros(rep,1);

for i = 1:rep
    G1 = (G1) .* ((W1')*(D)) ./ ((W1') * (W1*G1 + W2*G2));
    G2 = (G2) .* ((W2')*(D)) ./ ((W2') * (W1*G1 + W2*G2));

    distance(rep) = sum((D-W1*G1-W2*G2).^2,"all");
end

output1 = W1*G1;
output2 = W2*G2;

end