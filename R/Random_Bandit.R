#Random_Bandit
#Parameters:
rounds <- 1e5

load("dataBandits")
#Contains click_vs_test_field_vals, and ctr
num_actions <- length(ctr)
num_rd_samples <- length(click_vs_test_field_vals[,1])
sample_ptrs <- rep(1,num_actions)
n <- 1
cum_reward <- rep(0,rounds)
reward_vs_n <- rep(0,rounds)
while (all(sample_ptrs<=num_rd_samples) & (n<=rounds) & (n<=num_rd_samples)){
  sel_action <- sample(1:num_actions,1)
  reward <- click_vs_test_field_vals[sample_ptrs[sel_action],sel_action]
  cum_reward[n+1] <- cum_reward[n] + reward
  reward_vs_n[n+1] <- cum_reward[n+1] / (n+1) 
  sample_ptrs[sel_action] <- sample_ptrs[sel_action] + 1
  n <- n + 1
}
#lines(cum_reward[1:n],type="l",col="red")
lines(reward_vs_n[1:n],type="l",col="black")
