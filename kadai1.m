clc;clear;

filename = "./input/03_03.txt"; %分解したいデータ
rep = 100;              %繰り返し回数
K_const = 2;            %分解の定数

%W,Hの初期値はmain.mで乱数に設定されている
kadai1_main(filename,rep,K_const);

%--------------------ここからmain関数--------------------------
function kadai1_main(filename,rep,K_const)

fprintf(filename);
input = importdata(filename);

distance = zeros(rep,3);

[tate,yoko] = size(input);

addpath("function");
func_examine(input,K_const);

W = rand(tate,K_const); %初期値W,0があるとまずい
H = rand(K_const,yoko); %初期値H,0があるとまずい
result_W = zeros(tate,K_const,3);
result_H = zeros(K_const,yoko,3);

[result_W(:,:,1),result_H(:,:,1),distance(:,1)] = NMF_Eu_fast(input,W,H,rep);
[result_W(:,:,2),result_H(:,:,2),distance(:,2)] = NMF_KL(input,W,H,rep);
[result_W(:,:,3),result_H(:,:,3),distance(:,3)] = NMF_IS(input,W,H,rep);

txt_display = ["Euの結果","KLの結果","ISの結果"];
for i = 1:3
    fprintf("\n" + txt_display(i) + "\n" + "Wの結果" + "\n");
    result_W(:,:,i)
    fprintf("\nHの結果\n");
    result_H(:,:,i)
    fprintf("\n積を取った結果\n");
    result_W(:,:,i)*result_H(:,:,i)
end

txt_plot = ["Euの誤差","KLの誤差","ISの誤差"];
func_plot(distance,txt_plot);

end