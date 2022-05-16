function [W,H,distance] = NMF_Eu(X,W,H,rep,step)

distance = zeros(rep,1);

for i = 1:rep
    W_dif = - 2*X*(H') + 2*W*H*(H');
    H_dif = - 2*(W')*X + 2*(W')*W*H;
    
    step_W = 1/max(abs(W_dif),[],"all") * step;
    step_H = 1/max(abs(H_dif),[],"all") * step;

    W = W - step_W * W_dif;
    H = H - step_H * H_dif;

    distance(i) = sum((X - W*H).^2,"all");
end

end