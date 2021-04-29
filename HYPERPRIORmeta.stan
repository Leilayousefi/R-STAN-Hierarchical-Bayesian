data {
  int<lower=1> J; // number of studies
  vector[J] Y; // studies
  vector[J] X;
  int<lower=1> N[J];
  real<lower=0> alpha; //alpha ~ uniform(0,20)
  real<lower=0> betta; //betta ~ uniform(0,20)\\betta: Uniform distribution\\ Hyperprior on alpha
  real Pi[J]; // 
real<lower=0> sigma[J]; // std err of effect
}

parameters {
real mu; // mean for studies
real<lower=0> theta; //study effect//
real<lower=0> P; // estimated outcome - Posterior//real tau = alpha/(alpha+betta); //expected posterior mean success rate
}
model{
for(i in 1:10){
theta ~ beta(alpha,betta);// Prior on theta; Beta//
P ~ binomial(N,theta);
//P[i] ~ binomial(theta[i], X[i]);
}
}
