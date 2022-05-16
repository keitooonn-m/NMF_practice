function func_examine(input,K_const)

RANK_input = rank(input);
[tate,yoko] = size(input);
RANK_max = min(tate,yoko);


if RANK_max == RANK_input
    fprintf("フルランク,素敵な行列です\n");
else
    fprintf("ランク落ち,やる気のない行列\n");
end

if RANK_input == K_const
    fprintf("完備,XはW,Hによって完全に再構成できる\n");
elseif RANK_input < K_const
    fprintf("過完備,XはW,Hによって完全に再構成できる\n");
elseif RANK_input > K_const
    fprintf("完備でない,低ランク近似が限界\n");
else
    fprintf("なんかやばい\n");
end

end