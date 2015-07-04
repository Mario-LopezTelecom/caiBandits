classdef random_algo < handle
   % Random algorithm 
   properties
       num_arms; 
   end
   methods
       function initialize (this,num_arms)
           this.num_arms = num_arms;
       end;
       function chosen_arm = select_arm(this)
           % Que rama se elige en funcion de la historia
               chosen_arm = randi(this.num_arms,1);
       end       
       function update(this,chosen_arm,reward)
           %{ 
             Actualizar el estado interno del algoritmo en funcion de la
             recompensa
           %}
       end
   end
end