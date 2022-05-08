clc;clear;

input_filename ="input/gpo_hr.wav";
output_filename = "output/kadai2_output.wav";
windowshift = 500;
windowlength = 1500;
windowname = "Hann";
K_const = 30;
rep = 100;

main(input_filename,output_filename,windowshift,windowlength,windowname,K_const,rep);

function main(input_filename,output_filename,windowshift,windowlength,windowname,K_const,rep)
addpath("github_repo");
addpath("function");


[data,fs] = audioread(input_filename);

%--------------スぺ区トログラムを得る-------------------
%wndowshift     一回の計算で配列いくつずらすか
%windowlength   配列何個分計算するか。一回のSTFTする時間の長さ
%fftnum         知らんから消した。
%window name    窓関数の名前、いろいろある
F = DGTtool('windowShift',windowshift,'windowLength',windowlength,'windowName',windowname);

spe = F(data);
amp_spe = abs(spe);     %振幅スペクトログラム
theta_spe = angle(spe); %位相スペクトログラム
%rank(amp_spe); K_constはランクの値に近い方がいい

%---------------振幅スペクトログラムを分解-------------------
[tate,yoko] = size(amp_spe);
W = rand(tate,K_const); %初期値W
H = rand(K_const,yoko); %初期値H
[W,H,~] = NMF_KL(amp_spe,W,H,rep);

%---------分解したデータからもとのデータを復元-----------
spe_rebuilded = (W*H).*exp(1i * theta_spe);

%---------------逆STFTしてファイル出力------------------
audiowrite(output_filename,F.pinv(spe_rebuilded),fs);

end