
library(tidyverse) # Tidyverse 패키지
library(ggplot2) # 시각화 패키지 
library(plotly) # 반응형 시각화 패키지 
library(rpart) # 의사결정 나무
library(rpart.plot) # 의사결정 나무 시각화 
library(caret) # 데이터 처리 패키지
library(e1071) # 혼동행렬 패키지 
library(randomForest) # Random Forest 패키지
library(lubridate)
library(DT) # Data visualize
library(ggvis) # Data visualize


Population <- read.csv("Population_1912.csv")


# 1단계 탐색적 분석 /  1개월간의 기지국 신호정보를 기반으로 서울시 유동인구 정보를 확인할 수 있습니다.
str(Population) # 데이터 프레임 형식. 총 223,200개의 행과 7개의 열 존재.
                # 일자 : 정수형이니 날짜형으로 바꿔줘야함 -> 날짜형으로 변형시켜주는 함수 찾기 ->
                # 시간단위 : 1시간 단위로 측정하는 것 같고 이거는 데이터형이 무엇어야하지..? 팩터? 정수형? **겹치는 시간대는 병합해줘야할 듯 싶다.
                # 연령대 : 10세단위로 되어있는데 이것은 펙터화 시켜서 레벨을 구분시켜줘도 될 것 같다. -> 그룹화를 하기 위함
                # 성별 : 펙터형으로 남,여 형으로 레벨이 나눠져 있음. 건드릴 필요 없을 듯 하다.
                # 시 : 레벨이 하나인 걸로 보아 서울시만 있는 것을 확인할 수 있음
                # 군구: 약 25개 구에 대한 조사.
                # 유동인구수 : 우동인구수는 숫자형으로 놔두는게 맞지 않을까??

summary(Population) # 일자 : 2019년 12월 한달을 기준으로 조사한 자료임
                    # 시간 : 0시부터 23시까지 측정
                    # 연령대 : 최소 20대부터 최대 70대까지의 유동인구가 있었음
                    # 성별 : 남자가 111,600 , 여자가 111,600 ?? 유동인구수의 총 데이터는 억이 넘어가니 이건 뭔가 이상하다.
                    # 시 : 서울시에서 발생한 ?? 기준이 뭐지
                    # 군구 : 군구별로 숫자가 있는데 무슨 숫자지?
                    # 유동인구수 : 최소가 4570 이다.
rm(list=ls())
dim(Population)
head(Population,100) # 한시간 단위가 측정 단위인데 한시간에 3번 측정한 적도, 4번 측정한 적도 있고 불규칙적이다. 지역도 마찬가지다 시간에 균일하게 측정하지 않았으니 지역도 마찬가지다. 규칙이 필요하다.
sum(is.na(Population)) # 다행이 NA 값은 없다.

colnames(Population) <- c("date", "time","age", "sex", "city", "town","population")
Population$date <- ymd(Population$date) # 영문화 시킨상태에서 한글열이름을 적용하면 열이 추가됨



date_grouping <- Population %>%  ##?? 왜 데이터가 20개 밖에 안되는 거지?
  group_by(date, population, city) %>% 
  summarise() %>% head(20) %>% as.data.frame()

date_grouping <- Population %>%  ##?? 이건 왜 100개가 넘게 나오는 거지? 2019-12-01일 데이터는 77개이다.
  group_by(date, population) %>% 
  summarise(sum = sum(population)) %>% head(100) %>% as.data.frame() 

date_grouping <- Population %>% ## head 때문에 동일값이 반복해서 나오는 건가?
  group_by(date, population) %>% 
  summarise(sum = sum(population)) %>% head(200) %>% 
  as.data.frame()

date_grouping <- Population %>% ## 이건 왜 오류가 나는 거지?
  group_by(date, population) %>% 
  summarise(sum = sum(population) %>%  
  as.data.frame()

(date_grouping <- Population %>% 
  group_by(date) %>% 
  summarize() %>% as.data.frame())

(date_grouping <- Population %>% 
  group_by(town) %>% 
  summarise() %>% as.data.frame())

(date_grouping <- Population %>% 
  group_by(city) %>% 
  summarise() %>% as.data.frame())

(date_grouping <- Population %>% 
  group_by(sex) %>% 
  summarise() %>% as.data.frame())

(date_grouping <- Population %>% # 오름차순으로 유동인구 수를 나타냄
    group_by(population) %>% 
    summarise() %>% as.data.frame()) %>% head(10)

### 날짜와 유동인구 데이터
(date_grouping <- Population %>% # 1일 데이터는 77개인데 이렇게 나오는 이유가 뭘까?
    group_by(date, population) %>% 
    summarise() %>% as.data.frame())

(date_grouping <- Population %>% # 1일 데이터는 77개인데 이렇게 나오는 이유가 뭘까?
    group_by(date, population) %>% 
    summarise(sum = sum()) %>% as.data.frame())

date_grouping <- Population %>% 
    group_by(town, date) %>% 
    summarize() %>% as.data.frame()



Population$time
Population$age
Population$date

str(Population)
summary(Population)
