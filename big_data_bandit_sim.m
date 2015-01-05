function ctr_per_round = data_bandit_sim (algo, horizon, batch_size, num_sims)
% Sanity check
if (horizon*num_sims >= 180000) 
    error (['Pides demasiado: solo tienes 180000 muestras. '...
            'Reduce el horizonte y/o el numero de simulaciones.']);
end
ctr_per_sim_per_round = zeros(num_sims,horizon);
for it = 1:num_sims
    it
    ctr_data = csvread('ctr_data',((it-1)*horizon)+1,0,[(it-1)*horizon+1 0 (it-1)*horizon+horizon 3]);
    num_arms = length(ctr_data(1,:));
    sample_ptrs = ones(1,num_arms);
    algo.initialize(num_arms);
    n_batch = 1;
    reward_batch = zeros(1,batch_size);
    chosen_arm_batch = zeros(1,batch_size);
    for n = 1:horizon
        chosen_arm = algo.select_arm();
        chosen_arm_batch(n_batch) = chosen_arm;
        reward = ctr_data(sample_ptrs(chosen_arm),chosen_arm);
        reward_batch(n_batch) = reward;
        sample_ptrs(chosen_arm)=sample_ptrs(chosen_arm)+1;
        if (n == 1)
            ctr = 0;
        else
            ctr = ctr_per_sim_per_round(it,n-1);
        end;
        ctr_per_sim_per_round(it,n) = (n - 1) / n * ctr + (1 / n) * reward;
        n_batch = n_batch + 1;
        if (n_batch == batch_size+1)            
            algo.update(chosen_arm_batch, reward_batch);
            reward_batch = zeros(1,batch_size);
            chosen_arm_batch = zeros(1,batch_size);
            n_batch = 1;
        end;
    end;
end;
ctr_per_round = mean(ctr_per_sim_per_round,1);    
