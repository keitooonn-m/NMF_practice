function [W_mat,H_mat,distance] = NMF_Eu_fast_me(X,W,H,rep)

distance = zeros(rep,1);

for i = 1:rep
    W = (W).*(X*(H'))./(sum(H,2)')/sum(W*H,"all");
    H = (H).*((W')*X)./( sum(W)' )/sum(W*H,"all");
    distance(i) = sum((X - W*H).^2,"all");
end

W_mat = W;
H_mat = H;

end