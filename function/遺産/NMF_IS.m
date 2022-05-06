function [W_mat,H_mat,distance] = NMF_IS(X,W,H,rep)


distance = zeros(rep,1);

for i = 1:rep
    W_new = W.*(( ( ( X ./ ((W*H).^2) ) * (H') ) ./ ( ( ones(size(X)) ./ (W*H) ) * (H') ) ).^(1/2));
    H_new = H.*(( ( (W') * ( X ./ ((W*H).^2) ) ) ./ ( (W') * ( ones(size(X)) ./ (W*H) ) ) ).^(1/2));
    W = W_new;
    H = H_new;
    distance(i) = sum(X./(W*H)-log(X./(W*H))-1,"all");
    %この方法だけ後から代入の方がつよい
end

W_mat = W;
H_mat = H;

end