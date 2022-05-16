function [W_mat,H_mat,distance] = NMF_KL(X,W,H,rep)


distance = zeros(rep,1);

for i = 1:rep
    W_new = W.*( ((X./(W*H)) * (H') ) ./ ( ones(size(X))*(H') ) );
    W = W_new;
    H_new = H.*( ((W') * (X./(W*H)) ) ./ ( (W')*ones(size(X)) ) );
    H = H_new;
    %0成分があるとぶっ飛ぶので気をつけてください
    distance(i) = sum(X.*log(X./(W*H))-X+W*H,"all");
end

W_mat = W;
H_mat = H;

end