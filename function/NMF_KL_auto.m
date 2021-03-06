function [W,H,distance] = NMF_KL_auto(X,rep,K_const)

[tate,yoko] = size(X);
W = rand(tate,K_const);
H = rand(K_const,yoko);
distance = zeros(rep,1);

for i = 1:rep
    W = W.*( ((X./(W*H)) * (H') ) ./ ( ones(size(X))*(H') ) );
    H = H.*( ((W') * (X./(W*H)) ) ./ ( (W')*ones(size(X)) ) );
    %0成分があるとぶっ飛ぶので気をつけてください
    distance(i) = sum(X.*log(X./(W*H))-X+W*H,"all");
end

end