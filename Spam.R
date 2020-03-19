# 분류 모델 평가하기


# 로지스틱 회귀 모델을 적용하여 스팸 모델 만들기
spamD <- read.table("spamD.tsv", header = TRUE, sep = "\t")

spamTrain <- subset(spamD, spamD$rgroup>=10)

spamTest <- subset(spamD, spamD$rgroup<10)

spamVars <- setdiff(colnames(spamD), list("rgroup", "spam"))

spamFormula <- as.formula(paste('spam == "spam"',
                                paste(spamVars, collapse = "+"), sep = "~"))

spamModel <- glm(spamFormula, family = binomial(link = 'logit'), data = spamTrain)

spamTrain$pred <- predict(spamModel, newdata = spamTrain, type = "response")
spamTest$pred <- predict(spamModel, newdata = spamTest, type = "response")

print(with(spamTest, table(y=spam, glmPred = pred> 0.5)))

# 스팸 분류기
sample <- spamTest[c(7,35,224,327), c("spam", "pred")]
print(sample)

# 혼동 행렬
cM <- table(truth = spamTest$spam, prediction = spamTest$pred>0.5)
print(cM)

# 수기로 데이터 입력하기 
t <- as.table(matrix(data = c(288-1, 17, 1, 13882-17), nrow = 2, ncol = 2))
rownames(t) <- rownames(cM)
colnames(t) <- colnames(cM)
print(t)

# 스코어링 모델 평가하기
d <- data.frame(y=(1:10)^2, x=1:10)
model <- lm(y~x, data = d)
d$prediction <- predict(model, newdata = d)
library(ggplot2)
ggplot(data = d) +
  geom_point(aes(x=x,y=y)) +
  geom_line(aes(x=x,y=prediction), color ="blue") +
  geom_segment(aes(x=x, y=prediction, yend=y, xend=x)) +
  scale_y_continuous('')

# 확률 모델 평가하기
# 이중 밀도 플롯 만들기
ggplot(data = spamTest) +
  geom_density(aes(x=pred, color=spam, linetype=spam))

# 수신자 조작 곡선 플롯 그리기
library("ROCR")
eval <- prediction(spamTest$pred, spamTest$spam)
plot(performance(eval, "tpr", "fpr"))
print(attributes(performance(eval, "auc"))$y.values[[1]])

# 로그 우도 계산하기
sum(ifelse(spamTest$spam == "spam",
           log(spamTest$pred),
           log(1-spamTest$pred)))

sum(ifelse(spamTest$spam == "spam",
           log(spamTest$pred),
           log(1-spamTest$pred)))/ dim(spamTest)[[1]]

# 넬 모델의 로그 우도 계산하기
pNull <- sum(ifelse(spamTest$spam == "spam", 1, 0))/ dim(spamTest)[[1]]
sum(ifelse(spamTest$spam == "spam", 1, 0)) * log(pNull) +
      sum(ifelse(spamTest$spam == "spam", 0, 1)) * log(1-pNull)

# 엔트로피와 조건부 엔트로피 값 계산하기
entropy <- function(x) {
  xpos <- x[x>0]
  scaled <- xpos/sum(xpos)
  sum(-scaled*log(scaled, 2))
}

print(entropy(table(spamTest$spam)))

conditionalEntrpy <- function(t) {
  (sum(t[,1])*entropy(t[,1]) + sum(t[,2]) * entropy(t[,2])) / sum(t)
}

print(conditionalEntrpy(cM))

# 평면 위의 랜덤 데이터를 클러스터링 하기
set.seed(32297)
d <- data.frame(x = runif(100), y= runif(100))
clus <- kmeans(d, centers = 5)
d$cluster <- clus$cluster

# 클러스터 플롯 생성하기
library(ggplot2)
library(grDevices)
h <- do.call(rbind, 
             lapply(unique(clus$cluster),
                    function(c) { f <- subset(d, cluster == c); f[chull(f),]}))

ggplot() +
  geom_text(data = d, aes(label = cluster, x=x, y=y,
                          color = cluster), size =3) +
  geom_polygon(data = h, aes(x=x, y=y, group = cluster, fill= as.factor(cluster)),
               alpha = 0.4,linetype = 0) +
  theme(legend.position = "none")

# 각각의 클러스터의 크기 계산하기
table(d$cluster)

# 클러스터 내의 거리 대 클러스터 간의 거리
# 클러스터 내의 모든 요소 쌍 간의 일반적 거리 계산하기
library(reshape2)
n <- dim(d)[[1]]
pairs <- data.frame(
  ca = as.vector(outer(1:n, 1:n, function(a,b) d[a,"cluster"])),
  cb = as.vector(outer(1:n, 1:n, function(a,b) d[b,"cluster"])),
  dist = as.vector(outer(1:n, 1:n, function(a,b)
    sqrt((d[a,"x"] -d[b,"x"])^2 + (d[a,"y"]-d[b,"y"])^2)))
)

dcast(pairs, ca~cb, value.var = "dist", mean)
