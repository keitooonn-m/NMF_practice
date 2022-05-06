function [W_mat,H_mat,distance] = NMF_Eu_fast(X,W,H,rep)

distance = zeros(rep,1);

for p = 1:rep

    W_new = (W) .* (X*(H')) ./ (W*(H*(H')));
    H_new = (H) .* ((W')*X) ./ (((W')*W)*H);
    W = W_new;
    H = H_new;
    %distance(1)は一回目の更新後。更新前は記録されてないです。
    distance(p) = sum((X - W*H).^2,"all");
    %ここでまとめてW,Hを更新してもよいが、デルタ計算しなおして
    %別々に更新したほうがお得。
end
W*H

W_mat = W;
H_mat = H;

end