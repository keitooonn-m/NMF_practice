clc;clear;

addpath("github_repo");
addpath("function");
addpath("input");
data_filename = "./input/hr+cl.wav";
teacher1_filename = "./scaleData/gpo_cl_scale.wav";
teacher2_filename = "./scaleData/gpo_hr_scale.wav";
rep = 512;
K_const = 32;

windowname = "Blackman";
F = DGTtool('windowName',windowname);

data_vec = audioread(data_filename);
[teacher1_vec,fs] = audioread(teacher1_filename);
[teacher2_vec, ~] = audioread(teacher2_filename);

Y = abs(F(data_vec));
data_theta_spec = angle(F(data_vec));

D1 = abs(F(teacher1_vec));
D2 = abs(F(teacher2_vec));

%基底ベクトルとる
[W1,~,~] =NMF_KL_auto(D1,rep,K_const);
[W2,~,~] =NMF_KL_auto(D2,rep,K_const);

%分解する
[G1,G2,distance] = NMF_KL_bunri(Y,W1,W2,rep);
plot(distance);

%位相追加
output1 = W1*G1  ./ (W1*G1 + W2*G2) .* F(data_vec);
output2 = W2*G2  ./ (W1*G1 + W2*G2) .* F(data_vec);

%逆STFT
result_data1 = F.pinv(output1);
result_data2 = F.pinv(output2);

%ファイル出力する
audiowrite("./output/kadai3_output1.wav",result_data1,fs);
audiowrite("./output/kadai3_output2.wav",result_data2,fs);

%SDR確認する
addpath("./bss_eval");
true_data1 = audioread("./scaleData/gpo_cl_scale.wav");
true_data2 = audioread("./scaleData/gpo_hr_scale.wav");
true_data = [true_data1,true_data2];

%なんか知らんけど0ぱってぃんぐしたデータのほうが短い
result_data = [result_data1,result_data2];
[length,~] = size(result_data);

bss_eval_sources(result_data(:,1)',true_data(1:length,1)')
bss_eval_sources(result_data(:,2)',true_data(1:length,2)')