function [ctr_per_round,regret] = bandit_it (algo, mean_rewards, horizon, num_its)
ctr_per_it_per_round = zeros(num_its,horizon);
regret_per_it = zeros(num_its,horizon);
[~,best_arm] = max(mean_rewards);
chosen_arms = zeros(num_its,horizon);
round_regret = zeros(num_its,horizon);
for it = 1:num_its
    it
    algo.initialize(length(mean_rewards));
    for n = 1:horizon
        chosen_arm = algo.select_arm();
        chosen_arms(it,n) = chosen_arm;
        all_rewards = binornd(1,mean_rewards);
        reward = all_rewards(chosen_arm);
        round_regret = all_rewards(best_arm)-reward;
        round_regrets(it,n) = round_regret;
        if (n == 1)
            ctr = 0;
            regret = 0;
        else
            ctr = ctr_per_it_per_round(it,n-1);
            regret = regret_per_it(it,n-1);
        end;
        ctr_per_it_per_round(it,n) = (n - 1) / n * ctr + (1 / n) * reward;
        regret_per_it(it,n) = regret+round_regret;        
        algo.update(chosen_arm, reward);
    end;
end;
ctr_per_round = mean(ctr_per_it_per_round);
regret = mean(regret_per_it);        
