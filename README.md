# README #

### Scripts de test ###
Ejecutar éstos. Son:
* test_sim.m: compara todos los algoritmos en CTR por etapa y regret, con recompensas i.i.d.
* test_real_data.m: compara todos los algoritmos en CTR por etapa, con datos reales.
* test_real_data_rate.m: compara CTR de e-greedy y UCB dando distintos pesos a las nuevas muestras para las medias
* test_big_data.m: compara Thompson Sampling y UCB en procesado de recompensas en bucle. 

### Ejemplos de figuras ###
* Results.pptx 

### Implementaciones de MABs ###
* *_algo.m : Implementacion de los algoritmos para MABs
* {e_greedy, ucb}_rate_algo.m : versión que da más peso a las nuevas muestras en las medias
* {thompson_samp, ucb}_batch_algo: versión que procesa muestras en lotes

### Simuladores ###
* bandit_sim.m:  MABs con ramas i.i.d.
* data_bandit_sim.m: MABs con datos reales
* big_data_bandit_sim.m: MABs cuyas recompensas se leen en bloques

