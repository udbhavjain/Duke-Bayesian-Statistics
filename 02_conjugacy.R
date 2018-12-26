library(statsr)

# load brfss 2013 dataset
data(brfss)

# run interactive distribution visualisation app
credible_interval_app()

# Bounds of a 95% credible interval for normal distribution with mean 10 and variance 5
qnorm(c(0.025, 0.975), mean = 10, sd = 2.236)
"(5.618, 14.382)"

# Bounds of a 90% credible interval for beta distribution with α=2 and β=5
qbeta(c(0.05, 0.95), shape1 = 2, shape2 = 5)
"(0.063, 0.582)"

# Bounds of a 99% credible interval for gamma distribution with α=4 and β=8
qgamma(c(0.005, 0.995), shape = 4, rate = 8)
"(0.084, 1.372)"


# sex distribution in data
table(brfss$sex)

# store total sample size and number of females
n <- length(brfss$sex)
x <- sum(brfss$sex == "Female")

" The number of males and females are expected to be equal, therefore prior alpha and beta values will be 1. "
" The hyperparameters will then be updated according to the observed data. 
  
  a = a + x
  b = b + n - x
"

# Beta distribution for a = 1 + 2586 and b = 1 + 2414
qbeta(c(0.025, 0.975), shape1 = 2587, shape2 = 2415)

" The 95% credible interval is (0.503, 0.531).  

  The probability that the true proportion of females lies in this interval is 0.95. 
"


# Beta distribution for a = 500 + 2586 and b = 500 + 2414
qbeta(c(0.025, 0.975), shape1 = 3086, shape2 = 2914)

" The 95% credible interval is (0.502, 0.527). "

# 99% credible interval for beta distribution for a = 5, b = 200
qbeta(c(0.005, 0.995), shape1 = 5, shape2 = 200)

" Interval is (0.005, 0.06). Center of distribution is approximately at 0.03. "

# 95% credible interval, for prior beta a = 5, b = 200
qbeta(c(0.025, 0.975), shape1 = 2591, shape2 = 2614)

" Interval is (0.484, 0.511). "


# distribution for exercise variable
table(brfss$exercise)

# 90% credible interval for % of people who exercise, based on uniform prior
qbeta(c(0.05, 0.95), shape1 = 3869, shape2 =1133)

" The interval is (0.764, 0.783). "


# posterior for gamma distribution with priors a=4 and b=1, and observed data x = {2,3,4,5,4}
qgamma(c(0.025, 0.975), shape = 22, rate = 6)

# distribution for fruit consumption per day
table(brfss$fruit_per_day)

sum(brfss$fruit_per_day)
nrow(brfss)

" As recommended intake is 5 servings per day, prior is a = 5, b = 1.
  After updating according to observed data, the hyperparameters for posterior are a = 5+8114, b = 1+5000 "

# 90% credible interval for the gamma distribution
qgamma(c(0.05, 0.95), shape = 8119, rate = 5001)

" Interval for average number of fruit servings consumed per day is (1.594, 1.653). "

" Based on this result, it can be said that Americans do not follow the government guidelines for fruit consumption. "


# distribution for vegetable consumption per day
table(brfss$vege_per_day)

sum(brfss$vege_per_day)
nrow(brfss)

" As recommended intake is 5 servings per day, prior is a = 5, b = 1.
  After updating according to observed data, the hyperparameters for posterior are a = 5+5429, b = 1+5000 "

# 90% credible interval for the gamma distribution
qgamma(c(0.05, 0.95), shape = 5434, rate = 5001)

" Interval for average number of vegetable servings consumed per day is (1.062, 1.111). "

" Based on this result, it can be said that Americans do not follow the government guidelines for vegetable consumption. "
