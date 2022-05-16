function [W_mat,H_mat,distance] = NMF_Eu(X,W,H,rep,step_W,step_H)

distance = zeros(rep,1);

for i = 1:rep
    work_W = (X*(H') - W*H*(H')).*W;
    work_H = ((W')*X - (W')*W*H).*H;
    W_new = W + step_W*work_W/max(work_W,[],"all");
    H_new = H + step_H*work_H/max(work_H,[],"all");
    W = W_new;
    H = H_new;
    distance(i) = sum((X - W*H).^2,"all");
end

W_mat = W;
H_mat = H;

end