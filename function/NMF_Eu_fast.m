function [W,H,distance] = NMF_Eu_fast(X,W,H,rep)

distance = zeros(rep,1);

for i = 1:rep
    W = (W) .* (X*(H')) ./ (W*(H*(H')));
    H = (H) .* ((W')*X) ./ (((W')*W)*H);
    distance(i) = sum((X - W*H).^2,"all");
end

end