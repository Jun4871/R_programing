---
  title: "로지스틱 회귀분석"
author: "Ryukyungjun"
date: '2020 1 1 '
output: html_document
---
  
  ```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

<!-- # 제목 1 -->
  <!-- ## 제목 2 -->
  
  <!-- .. -->
  
  <!-- ##### 제목 5 -->
  
  ## 로지스틱 회귀분석 
  
  이번에는 로지스틱 회귀분석을
해보려 한다. 간단히 말하자면 데이터를 분류할 때 선형분류기를 사용하여 이진분류를 하는 것이 로지스틱 분석의 핵심이다. <br>
  선형분류기란 로지스틱 함수 즉, odds 함수를 사용하여 분류를 하는 것이다. 이는 후에 신경망 이론에도 매우 중요한 근간을 이루기 때문에 로지스틱 함수에 대한 자세한 이야기는 나중에 다루기로 하겠다. 

<br>
  
  ---
  
  ### 데이터 준비하기
  
  자 이제 iris 데이터로 로지스틱 회기를 통한 이진분류를 해보자. 


```{r message=FALSE}
# 필요한 패키지
library(tidyverse)
```

```{r}
df <- iris
# 데이터 설정
df <- df %>% 
  filter(Species != "versicolor") %>% 
  as.data.frame() 

unique(df$Species)

df$Species <- factor(df$Species)

```

### 데이터 파악 
이번에는 데이터를 파악해보자 각각 데이터의 자료형이 어떤지, 어떻게 분포되어 있는지 등을 볼 것이다.
```{r}
str(df)
summary(df)
sum(is.na(df))
plot(df)
```

간단히 자료의 데이터형과 통계수치, 결측치가 없는 것을 확인했고,그래프로 데이터를 파악해본 결과, Species를 분류하는데 있어서 유효한 데이터는 Peltal.Width, Petal.Length, Sepal.Width 로 확인 되었다.

### 트레이닝 테스트 셋 나누기

자 이제 versicolor 를 제외한 iris 데이터를 트레이닝 테스트 셋으로 나누자. 이 때 70:30으로 나눌 것이다.

```{r}
# test set
# 모델을 평가 하는데 필요
# train/test sampling
training_sampling <- sort(sample(1:nrow(df),nrow(df)*0.7))
test_sampling <- setdiff(1:nrow(df), training_sampling)

# nrow, ncol
# nrow = number of row
# ncol = number of column

## traing_set, test_set
training_set <- df[training_sampling,]
test_set <- df[test_sampling,]
```

### 로지스틱 회귀
이제 로지스틱 회귀를 하여 이진분류를 해보도록 하겠다. 로지스틱의 기본 함수는 **glm()**이고 기본 형식은 다음과 같다. <br>
  glm(종속변수 ~ 독립변수, data = df, family = "binomial") 

```{r}
# 모델생성
logit_m <- glm(Species ~ Petal.Length + Petal.Width + Sepal.Width, data = training_set, family = "binomial") 

# 모델확인 
logit_f <- fitted(logit_m)

logit_f < 0.5

df$Species %>% as.numeric()

ifelse(logit_f < 0.5, 1, 2)

# 정확도를 위한 데이터 생성
is_correct <- training_set$Species %>% as.numeric() == ifelse(logit_f < 0.5, 1, 2)

# 정확도
sum(is_correct) / length(is_correct)
```

정확도가 1이 나왔다. 이는 100% 잘 분류되었음을 나타낸다. 이제는 test set 에다가 모델을 적용시켜보자. predict() 함수를 쓰고 기본형은 다음과 같다. <br>
  predict(model, newdata, type="response")

```{r}
## test set의 모델적용
logit_p <- predict(logit_m, test_set, type = "response")
is_correct_p <- test_set$Species %>%  as.numeric() == ifelse(logit_p < 0.5, 1, 2)
sum(is_correct_p) / length(is_correct_p)
```
그러나 iris 데이터 자체가 매우 교과서적으로 나와있어서 역시  차후에 복잡한 데이터를 통해 다시 한 번 적용해볼 예정이다.
