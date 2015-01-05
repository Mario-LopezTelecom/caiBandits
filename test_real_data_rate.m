% Test para recompensas reales (adaptacion)
%% e-greedy rate
clear all
close all
clc

horizon = 10000;
num_sims = 15;

epsilon = 0.1;
e_greedy = e_greedy_algo(epsilon);
rate1 = 1.5;
e_greedy_rate_15 = e_greedy_rate_algo(epsilon,rate1);
rate2 = 0.7;
e_greedy_rate_07 = e_greedy_rate_algo(epsilon,rate2);


disp('e_greedy');
e_greedy_ctr_per_round = data_bandit_sim (e_greedy, horizon, num_sims);
disp('e_greedy_rate_15');
e_greedy_rate_15_ctr_per_round = data_bandit_sim (e_greedy_rate_15, horizon, num_sims);
disp('e_greedy_rate_07');
e_greedy_rate_07_ctr_per_round = data_bandit_sim (e_greedy_rate_07, horizon, num_sims);

line_width = 2;
hold all;
title('CTR up to round n','FontSize',14);
plot(e_greedy_ctr_per_round,'LineWidth',line_width);
plot(e_greedy_rate_15_ctr_per_round,'LineWidth',line_width);
plot(e_greedy_rate_07_ctr_per_round,'LineWidth',line_width);
legend(strcat('\epsilon-greedy (\epsilon = ',num2str(epsilon),')'),...
       strcat('\epsilon-greedy (\epsilon = ',num2str(epsilon),' rate = ',num2str(rate1),')'),...
       strcat('\epsilon-greedy (\epsilon = ',num2str(epsilon),' rate = ',num2str(rate2),')'),...
       'Location','SouthEast');
set(gca,'FontName','Arial')
set(gca,'FontSize',12)
grid on;

%% UCB rate
clear all
close all
clc

horizon = 10000;
num_sims = 15;

ucb = ucb_algo;
rate1 = 1.5;
ucb_rate_15 = ucb_rate_algo(rate1);
rate2 = 0.7;
ucb_rate_07 = ucb_rate_algo(rate2);
rate3 = 0.5;
ucb_rate_05 = ucb_rate_algo(rate3);

disp('UCB');
ucb_ctr_per_round = data_bandit_sim (ucb, horizon, num_sims);
disp('UCB_rate_15');
ucb_rate_15_ctr_per_round = data_bandit_sim (ucb_rate_15, horizon, num_sims);
disp('UCB_rate_07');
ucb_rate_07_ctr_per_round = data_bandit_sim (ucb_rate_07, horizon, num_sims);
disp('UCB_rate_05');
ucb_rate_05_ctr_per_round = data_bandit_sim (ucb_rate_05, horizon, num_sims);

line_width = 2;
hold all;
title('CTR up to round n','FontSize',14);
plot(ucb_ctr_per_round,'LineWidth',line_width);
plot(ucb_rate_15_ctr_per_round,'LineWidth',line_width);
plot(ucb_rate_07_ctr_per_round,'LineWidth',line_width);
plot(ucb_rate_05_ctr_per_round,'LineWidth',line_width);
legend('UCB',...
       strcat('UCB (rate = ',num2str(rate1),')'),...
       strcat('UCB (rate = ',num2str(rate2),')'),...
       strcat('UCB (rate = ',num2str(rate3),')'),...
       'Location','SouthEast');
set(gca,'FontName','Arial')
set(gca,'FontSize',12)
grid on;