clc;clear;

filename = "03_03.txt"; %分解したいデータ
rep = 100;              %繰り返し回数
K_const = 2;            %分解の定数

%W,Hの初期値はmain.mで乱数に設定されている
kadai1_main(filename,rep,K_const);