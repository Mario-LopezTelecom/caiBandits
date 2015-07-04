% Test para recompensas Big Data 
clear all
close all
clc

% Parametros a configurar
horizon = 30000;
batch_size = 3000;
num_sims = 5;

ucb_batch = ucb_batch_algo;
thompson_samp_batch = thompson_samp_batch_algo;

disp('UCB');
ucb_batch_ctr_per_round = big_data_bandit_sim (ucb_batch, horizon, batch_size, num_sims);
disp('Thompson Sampling');
thompson_samp_batch_ctr_per_round = big_data_bandit_sim (thompson_samp_batch, horizon, batch_size, num_sims);


line_width = 2;
hold all;
title('CTR up to round n','FontSize',14);
plot(ucb_batch_ctr_per_round,'LineWidth',line_width);
plot(thompson_samp_batch_ctr_per_round,'LineWidth',line_width);
legend('UCB','Thompson Sampling','Location','SouthEast');
set(gca,'FontName','Arial')
set(gca,'FontSize',12)

x_batches = 0:batch_size:horizon;
x_lines = zeros(length(x_batches),2);
for i=1:length(x_batches)
    x_lines(i,:) = [x_batches(i) x_batches(i)];
end;
line(x_lines,ylim,'Color','k');
