function [G1,G2,distance] = NMF_KL_bunri(Y,W1,W2,rep)

[tate,yoko] = size(Y);
[~,K_const] = size(W1);

G1 = rand(K_const,yoko);
G2 = rand(K_const,yoko);
E = ones(tate,yoko);

distance = zeros(rep,1);

for i = 1:rep
    G1 = (G1) .* ( (W1') * ( Y ./ (W1*G1 + W2*G2) ) ) ./ ((W1') * E);
    G2 = (G2) .* ( (W2') * ( Y ./ (W1*G1 + W2*G2) ) ) ./ ((W2') * E);
    distance(i) = sum(Y .* log(Y./ (W1*G1 + W2*G2)) - Y + W1*G1 + W2*G2 , "all" );
end

end