% Test para recompensas simuladas
clear all
close all
clc

mean_rewards = [0.08 0.1 0.3 0.4];
horizon = 10000;
num_sims = 15;

epsilon = 0.1;
random_pick = random_algo;
e_greedy = e_greedy_algo(epsilon);
e_desc_greedy = e_desc_greedy_algo;
e_desc_log_greedy = e_desc_log_greedy_algo;
thompson_samp = thompson_samp_algo;
ucb = ucb_algo;

disp('Random Pick');
[random_pick_ctr_per_round,random_pick_regret] = bandit_sim (random_pick, mean_rewards, horizon, num_sims);
disp('e_greedy');
[e_greedy_ctr_per_round,e_greedy_regret] = bandit_sim (e_greedy, mean_rewards, horizon, num_sims);
disp('e_descending_greedy');
[e_desc_greedy_ctr_per_round,e_desc_greedy_regret] = bandit_sim (e_desc_greedy, mean_rewards, horizon, num_sims);
disp('e_descending(log)_greedy');
[e_desc_log_greedy_ctr_per_round,e_desc_log_greedy_regret] = bandit_sim (e_desc_log_greedy, mean_rewards, horizon, num_sims);
disp('Thompson Sampling');
[thompson_samp_ctr_per_round,thompson_samp_regret] = bandit_sim (thompson_samp, mean_rewards, horizon, num_sims);
disp('UCB');
[ucb_ctr_per_round,ucb_regret] = bandit_sim (ucb, mean_rewards, horizon, num_sims);

line_width = 2;
subplot(2,1,1)
title('CTR up to round n','FontSize',14)
hold all;
plot(random_pick_ctr_per_round,'LineWidth',line_width);
plot(e_greedy_ctr_per_round,'LineWidth',line_width);
plot(e_desc_greedy_ctr_per_round,'LineWidth',line_width);
plot(e_desc_log_greedy_ctr_per_round,'LineWidth',line_width);
plot(thompson_samp_ctr_per_round,'LineWidth',line_width);
plot(ucb_ctr_per_round,'LineWidth',line_width);
min_reward = min(mean_rewards);
max_reward = max(mean_rewards);
h_min_line = line([1 horizon],[min_reward min_reward]);
h_max_line = line([1 horizon],[max_reward max_reward]);
set(h_min_line,'LineStyle','--','LineWidth',2,'Color','k');
set(h_max_line,'LineStyle','--','LineWidth',2,'Color','k');
text(horizon/3,min_reward+0.01,'Worst CTR');
text(horizon/3,max_reward+0.01,'Best CTR');
set(gca,'FontName','Arial')
set(gca,'FontSize',12)

subplot(2,1,2);
title('Regret','FontSize',14);
hold all;
plot(random_pick_regret,'LineWidth',line_width);
plot(e_greedy_regret,'LineWidth',line_width);
plot(e_desc_greedy_regret,'LineWidth',line_width);
plot(e_desc_log_greedy_regret,'LineWidth',line_width);
plot(thompson_samp_regret,'LineWidth',line_width);
plot(ucb_regret,'LineWidth',line_width);
legend('Random Pick',strcat('\epsilon-greedy (\epsilon = ',num2str(epsilon),')'),...
       '\epsilon-descending-greedy (linear)','\epsilon-descending-greedy (log)',...
       'Thompson Sampling','UCB','Location','NorthWest');
set(gca,'FontName','Arial')
set(gca,'FontSize',12)

