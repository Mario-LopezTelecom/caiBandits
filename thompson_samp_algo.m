classdef thompson_samp_algo < handle
   % Thompson Sampling algorithm
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
           round = sum(this.trials)+1; 
           ind_untested_arm = find(this.trials==0);
           if(~isempty(ind_untested_arm))
               chosen_arm = ind_untested_arm(1);
           else
               [~,chosen_arm] = max(betarnd(1+this.clicks,...
                                            1+this.trials-this.clicks));
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