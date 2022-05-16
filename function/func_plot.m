function func_plot(data_vec,filename_vec)

[~,num_data] = size(data_vec);

%-----------------グラフの編集--------------------
f = figure();
f.Position(3:4) = [400*num_data 350];


for i = 1:num_data
    subplot(1,num_data,i);semilogy(data_vec(:,i));
    title(filename_vec(i),'Interpreter','none');
    xlabel("更新回数");
    ylabel("誤差");
end
%-----------------------------------------------

end