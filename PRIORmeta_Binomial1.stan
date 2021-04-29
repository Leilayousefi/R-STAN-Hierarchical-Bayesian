data {
  int<lower=1> J; // number of studies
  vector[J] Y; // studies
  int<lower=0> X[J];// number of successes (for study j)
  int<lower=1> N[J];
  real alpha; //real<lower=0> beta; real<lower=0> sigma2;
  real<lower=0> sigma[J];
  real Prob[J]; // 
  vector<lower=0.2, upper=1>[J] P;
}
parameters {
//real<lower=0, upper=1> alpha;
real<lower=1> kappa;
real<lower=0, upper=1> theta[J]; // probability of success for study #j
}
model {
for (i in 1:J){
  // prior
theta ~ beta(alpha * kappa, (1 - alpha) * kappa);
P ~ binomial(N,theta);// Likelihood
kappa ~ pareto(1, 0.3);// hyper-priors
alpha ~ beta(5,5);
}
