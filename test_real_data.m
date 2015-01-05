% Test para recompensas reales 
clear all
close all
clc

horizon = 10000;
num_sims = 15;

epsilon = 0.1;
e_greedy = e_greedy_algo(epsilon);
e_desc_greedy = e_desc_greedy_algo;
e_desc_log_greedy = e_desc_log_greedy_algo;
random_pick = random_algo;
thompson_samp = thompson_samp_algo;
ucb = ucb_algo;

disp('Random Pick');
random_pick_ctr_per_round = data_bandit_sim (random_pick, horizon, num_sims);
disp('e_greedy');
e_greedy_ctr_per_round = data_bandit_sim (e_greedy, horizon, num_sims);
disp('e_descending_greedy');
e_desc_greedy_ctr_per_round = data_bandit_sim (e_desc_greedy, horizon, num_sims);
disp('e_descending(log)_greedy');
e_desc_log_greedy_ctr_per_round = data_bandit_sim (e_desc_log_greedy, horizon, num_sims);
disp('Thompson Sampling');
thompson_samp_ctr_per_round = data_bandit_sim (thompson_samp, horizon, num_sims);
disp('UCB');
ucb_ctr_per_round = data_bandit_sim (ucb, horizon, num_sims);

line_width = 2;
hold all;
title('CTR up to round n','FontSize',14);
plot(random_pick_ctr_per_round,'LineWidth',line_width);
plot(e_greedy_ctr_per_round,'LineWidth',line_width);
plot(e_desc_greedy_ctr_per_round,'LineWidth',line_width);
plot(e_desc_log_greedy_ctr_per_round,'LineWidth',line_width);
plot(thompson_samp_ctr_per_round,'LineWidth',line_width);
plot(ucb_ctr_per_round,'LineWidth',line_width);
legend('Random Pick',strcat('\epsilon-greedy (\epsilon = ',num2str(epsilon),')'),...
       '\epsilon-descending-greedy (linear)','\epsilon-descending-greedy (log)',...
       'Thompson Sampling','UCB','Location','SouthEast');
set(gca,'FontName','Arial')
set(gca,'FontSize',12)
grid on;