clc;clear;

addpath("github_repo");
addpath("function");
addpath("input");
data_filename = "./input/hr+cl.wav";
teacher1_filename = "./scaleData/gpo_cl_scale.wav";
teacher2_filename = "./scaleData/gpo_hr_scale.wav";
rep = 512;
K_const = 32;

F = DGTtool(windowname = "Blackman");

data_vec = audioread(data_filename);
[teacher1_vec,fs] = audioread(teacher1_filename);
[teacher2_vec, ~] = audioread(teacher2_filename);


%教師音をSTFT、絶対値とって基底ベクトル作成する
[W1,~,~] =NMF_KL_auto(abs(F(teacher1_vec)),rep,K_const);
[W2,~,~] =NMF_KL_auto(abs(F(teacher2_vec)),rep,K_const);

%分解する
[G1,G2,distance] = NMF_KL_bunri(abs(F(data_vec)),W1,W2,rep);
plot(distance); %分解後の誤差関数減少の確認はこちら

%位相追加
output1 = W1*G1  ./ (W1*G1 + W2*G2) .* F(data_vec);
output2 = W2*G2  ./ (W1*G1 + W2*G2) .* F(data_vec);

%逆STFT
result_data1 = F.pinv(output1);
result_data2 = F.pinv(output2);

%ファイル出力する
audiowrite("./output/kadai3_output1.wav",result_data1,fs);
audiowrite("./output/kadai3_output2.wav",result_data2,fs);

%SDR確認するために真のデータ読み込み
addpath("./bss_eval");
true_data1 = audioread("./songKitamura/MGS/melody2/mgs_cl.wav");
true_data2 = audioread("./songKitamura/MGS/melody1/mgs_hr.wav");
true_data = [true_data1,true_data2];
result_data = [result_data1,result_data2];

%0パッティングした分だけ結果を短くしないといけない
bss_eval_sources(result_data(1:size(true_data,1),:)',true_data')