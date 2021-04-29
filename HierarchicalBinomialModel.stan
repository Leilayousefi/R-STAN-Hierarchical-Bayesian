data {
int<lower=0> J; // number of studies
int<lower=0> x[J]; // number of successes (for study j) = p20 = The proporstion iof defects
int<lower=0> n[J]; // number of trials (modules) for study j 
}
/*The prior on each theta[j] is parameterized by a mean chance of success lambda and count kappa. 
Both theta[j] and lambda are constrained to fall between zero and one. 
The Pareto distribution requires a strictly positive lower bound, 
so kappa is constrained to be greater than or equal to a conservative bound of 0.1 to match 
the support of the Pareto hyperprior it receives in the model block.*/
parameters {
real<lower=0, upper=1> theta[J]; // probability of success for study #j
real<lower=0, upper=1> lambda; // prior mean probablilty of success
real<lower=0.1> kappa; // prior count (it measures the concentartion)
}
/*The transformed parameters block allows users to define transforms of parameters within
a model. Following the model in (Gelman et al. 2013), the example in Figure 3 uses the
transformed parameter block to define transformed parameters alpha and beta for the prior
success and failure counts to use in the beta prior for theta*/
transformed parameters {
real<lower=0> alpha = lambda * kappa; // prior success count
real<lower=0> beta = (1 - lambda) * kappa; // prior failure count
}
model {
lambda ~ uniform(0, 1); // hyperprior
kappa ~ pareto(0.1, 1.5); // hyperprior
theta ~ beta(alpha, beta); // prior
x ~ binomial(n, theta); // likelihood (It defines the random variable yi to be the number of successes among the ni modules in study i)
}
generated quantities {
real<lower=0,upper=1> avg = mean(theta); // avg success
int<lower=0, upper=1> above_avg[J]; // true if j is above avg
int<lower=1, upper=J> rnk[J]; // rank of j
int<lower=0, upper=1> highest[J]; // true if j is highest rank
for (j in 1:J) {
above_avg[j] = (theta[j] > avg);
rnk[j] = rank(theta, j) + 1;
highest[j] = (rnk[j] == 1);
}
}
