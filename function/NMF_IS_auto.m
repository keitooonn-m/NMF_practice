function [W,H,distance] = NMF_IS_auto(X,rep,K_const)

[tate,yoko] = size(X);
W = rand(tate,K_const);
H = rand(K_const,yoko);
distance = zeros(rep,1);

for i = 1:rep
    W = W.*(( ( ( X ./ ((W*H).^2) ) * (H') ) ./ ( ( ones(size(X)) ./ (W*H) ) * (H') ) ).^(1/2));
    H = H.*(( ( (W') * ( X ./ ((W*H).^2) ) ) ./ ( (W') * ( ones(size(X)) ./ (W*H) ) ) ).^(1/2));
    distance(i) = sum(X./(W*H)-log(X./(W*H))-1,"all");
    %この方法だけ後から代入の方がつよい
end

end