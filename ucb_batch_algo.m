classdef ucb_batch_algo < handle
   % epsilon_descending_greedy algorithm (log descending)
   properties
       clicks; 
       trials;
   end
   methods
       function initialize (this,num_arms)
           this.clicks = zeros(1,num_arms);
           this.trials = zeros(1,num_arms);
       end;
       function chosen_arm = select_arm(this)
           % Que rama se elige en funcion de la historia
           ind_untested_arm = find(this.trials==0);
           if(~isempty(ind_untested_arm))
               chosen_arm = ind_untested_arm(1);
           else
               ctr = this.clicks ./ this.trials;
               n = sum(this.trials);
               ucb = ctr + sqrt(2 .* log(n) ./ this.trials);
               [~,chosen_arm] = max(ucb);
           end
       end
       
       function update(this,chosen_arm_batch,reward_batch)
           %{ 
             Actualizar el estado interno del algoritmo en funcion de la
             recompensa
           %}
           num_arms = length(this.clicks);
           for i=1:num_arms
                ind_rewards = find(chosen_arm_batch == i);
                this.clicks(i) = this.clicks(i) + sum(reward_batch(ind_rewards));
                this.trials(i) = this.trials(i) + length(ind_rewards);
           end
       end
   end
end