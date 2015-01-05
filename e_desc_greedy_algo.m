classdef e_desc_greedy_algo < handle
   % Algoritmo epsilon descending greedy 
   properties
       clicks;
       trials;
   end
   methods
       function initialize (this,num_arms)
           % Resetea el estado interno del bandit
           this.clicks = zeros(1,num_arms);
           this.trials = zeros(1,num_arms);
       end;
       function chosen_arm = select_arm(this)
           % Que rama se elige en funcion de la historia
           ind_untested_arm = find(this.trials==0);
           if(~isempty(ind_untested_arm))
                chosen_arm = ind_untested_arm(1);
           else
                n = sum(this.trials);
                epsilon = 1/n; 
                if (rand < epsilon)
                    chosen_arm = randi(length(this.trials),1);
                else
                    ctr = this.clicks ./ this.trials;
                    [~,chosen_arm] = max(ctr);
                end
           end
       end
       
       function update(this,chosen_arm,reward)
           %{ 
             Actualizar el estado interno del algoritmo en funcion de la
             recompensa
           %}
           this.clicks(chosen_arm) = this.clicks(chosen_arm) + reward;
           this.trials(chosen_arm) = this.trials(chosen_arm) + 1;
       end
   end
end