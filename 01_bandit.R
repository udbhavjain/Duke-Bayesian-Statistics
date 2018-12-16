library(statsr)
library(dplyr)

# calculate posterior probabilities for a case where machine 1 wins
# default prior probabilities are 0.5, 0.5
bandit_posterior(data = data.frame(machine = 1, outcome = "W"))

# posterior probabilities after machine 1 wins and then loses
bandit_posterior(data = data.frame(machine = c(1,1), outcome = c("W","L")))

# chaining calls to use calculated posterior as new prior
data1 <- data.frame(machine = c(1), outcome = c("W"))
data2 <- data.frame(machine = c(1), outcome = c("L"))

bandit_posterior(data1) %>% 
  bandit_posterior(data2, prior = .)

# posterior probabilities of being “good” after playing Machine 1 twice and winning both times
# and then playing Machine 2 three times with 2 wins then 1 loss.
bandit_posterior(data = data.frame(machine = c(1,1,2,2,2), outcome = c("W","W","W","W","L")))

" P(M1 is good| data) = 0.571
  P(M2 is good| data) = 0.428 "

# posterior probabilities with the machine order reversed
bandit_posterior(data = data.frame(machine = c(2,2,2,1,1), outcome = c("W","W","L","W","W")))

" P(M1 is good| data) = 0.571
  P(M2 is good| data) = 0.428 "

# calculation through chaining
bandit_posterior(data = data.frame(machine = c(1,1), outcome = c("W","W"))) %>%
  bandit_posterior(data = data.frame(machine = c(2,2,2), outcome = c("W","W","L")), prior = .)
  
" Probabilities are the same. "

# calculate posterior probability using random data
mc <- sample(x = c(1,2), replace = TRUE, prob = c(0.5,0.5), size = 50)
wl <- sample(x = c("W","L"), replace = TRUE, prob = c(0.5,0.5), size = 50)

bandit_posterior(data = data.frame(machine = mc, outcome = wl))


# chained posterior probability using random data

# generate data
play_data <- data.frame(machine = numeric(),
                        outcome = character(), stringsAsFactors = FALSE)[1:50,]

row.names(play_data) <- NULL

for(i in 0:4)
{
  mc <- sample(x = c(1,2), replace = TRUE, prob = c(0.5,0.5), size = 10)
  wl <- sample(x = c("W","L"), replace = TRUE, prob = c(0.5,0.5), size = 10)
  
  play_data[((i*10)+1):((i+1)*10),1] = mc[1:10]
  play_data[((i*10)+1):((i+1)*10),2] = wl[1:10]
  
}

# calculate posterior probability after every 10 rolls
prior_p <- c(0.5,0.5)  

for(i in 0:4)
{
  print("Data: ")
  print(play_data[((i*10)+1):((i+1)*10),])
  prior_p <- bandit_posterior(data = play_data[((i*10)+1):((i+1)*10),], prior = prior_p) 
  print("Posterior probability: ")
  print(prior_p)
  print("-------------------------------------------------------------------------------")
}

# plot posterior probabilities
x11()
plot_bandit_posterior(play_data)

" A mirrored pattern is observed. This is because:

  P(M1 | data) and P(M2 | data) are complementary
  and
  Machine 1 and Machine 2 being “good” are mutually exclusive events.
"
