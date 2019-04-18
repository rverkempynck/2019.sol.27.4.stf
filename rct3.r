
assyear <- 2019

library(rct3)
data <- as.data.frame(lapply(altin1, as.numeric))
data2 <- as.data.frame(lapply(altin2, as.numeric))
formula <- age1 ~  dfs0 + sns0 + sns1 + bts1
formula2 <- age2 ~  dfs0 + sns0 + sns1 + bts1

out1 <- rct3(formula, data, predictions = assyear-1, shrink = T, old = F)
out2 <- rct3(formula2, data2, predictions = assyear-2, shrink = T, old = F)

# see a short summary
out1
out2

# for a full summary do:
summary(out1)
summary(out2)

# the components are here:
out1$rct3
out2$rct3

out1$rct3.summary
out2$rct3.summary

# predicted recruitment
t(out1$rct3.summary["WAP"])
t(out2$rct3.summary["WAP"])
