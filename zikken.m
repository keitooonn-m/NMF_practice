clc;clear;

input = importdata("input\03_03_document.txt")

RANK_input = rank(input);
[tate,yoko] = size(input);
RANK_max = min(tate,yoko);

K_const = 2;

addpath("function");
examine(input,K_const);

rep = 300;
step = 0.1;

%W = importdata("example_W.txt")
%H = importdata("example_H.txt")
W = rand(tate,K_const);
H = rand(K_const,yoko);

%[W,H,distance] = NMF_Eu(input,W,H,rep,step,step);
%[W,H,distance] = NMF_Eu_me(input,W,H,100,0.1);
%[W,H,distance] = NMF_Eu_fast(input,W,H,rep);
%[W,H,distance] = NMF_Eu_fast_me(input,W,H,100);
%[W,H,distance] = NMF_KL(input,W,H,rep);
%[W,H,distance] = NMF_KL_me(input,W,H,rep);
%[W,H,distance] = NMF_IS(input,W,H,rep);
[W,H,distance] = NMF_IS_me(input,W,H,rep);

%Eu収束遅すぎ振動しすぎが気になる人
%for i = 1:20
%    [W,H,distance] = NMF_Eu_me(input,W,H,30,10^(-i));
%    %figure;
%    plot(distance);
%end

W*H
plot(distance);