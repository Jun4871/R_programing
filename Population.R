library(tidyverse)
library(fs)

# 폴더명 생성
year_18_food <- "year_18"

# 폴더에 있는 csv 파일 확인
year_18_food_csv <- fs::dir_ls(year_18_food)

# 첫번째 csv 파일 불러와 보기
readr::read_csv(year_18_food_csv[1])

# 이제 이 모든 csv 파일을 불러오자
year_18_food_data <- year_18_food_csv %>% 
  map_dfr(read_csv)

# 이를 data.frame 로 변경
year_18_food_data_frame <- as.data.frame(year_18_food_data)

# NA를 파악해보자
sum(is.na(year_18_food_data_frame))

# 컬럼명이 뭔가 다른 것이 있다.
# 시도, 시군구, 읍면동, 기준일 = 발신지_시도, 발신지_구, 발신지_동, 일자
str(year_18_food_data_frame)

# 먼저 확인해 보고 싶은 것이, 이 데이터들이 한쪽에 없으면 다른 한쪽에 무조건 있는가?

# 시도 데이터의 NA index와, 발신지_시도의 NA가 아닌 곳의 index를 확인해보자.
sum(
  which(is.na(year_18_food_data_frame$시도)) !=
    which(!is.na(year_18_food_data_frame$발신지_시도))
)


# 시군구 데이터의 NA index와, 발신지_구의 na가 아닌 곳의 index를 확인해보자.
sum(
  which(is.na(year_18_food_data_frame$시군구)) !=
    which(!is.na(year_18_food_data_frame$발신지_구)))

# 읍면동 데이터의 NA index와, 발신지_동의 na가 아닌 곳의 index를 확인해보자.
sum(
  which(is.na(year_18_food_data_frame$읍면동)) !=
    which(!is.na(year_18_food_data_frame$발신지_동)))
# 0이 나온것으로 보아 다행히 모두 서로 다른곳에 na가 위치해 있다.
# 이제 시도,시군구,읍면동의 na위치에 발신지_시도,발신지_구, 발신지_동의 data를 집어 넣어주자.

year_18_food_data_frame$시도[which(is.na(year_18_food_data_frame$시도))] <-
  year_18_food_data_frame$발신지_시도[which(!is.na(year_18_food_data_frame$발신지_시도))]

year_18_food_data_frame$시군구[which(is.na(year_18_food_data_frame$시군구))] <-
  year_18_food_data_frame$발신지_구[which(!is.na(year_18_food_data_frame$발신지_구))]

year_18_food_data_frame$읍면동[which(is.na(year_18_food_data_frame$읍면동))] <-
  year_18_food_data_frame$발신지_동[which(!is.na(year_18_food_data_frame$발신지_동))]

# 그리고 na를 살펴 보면.
sum(is.na(year_18_food_data_frame$시도))
sum(is.na(year_18_food_data_frame$시군구))
sum(is.na(year_18_food_data_frame$읍면동))

# 기준일, 일자도 같은 방법으로 진행 한다.
# 기준일
sum(which(is.na(year_18_food_data_frame$기준일))!=
      which(!is.na(year_18_food_data_frame$일자)))

year_18_food_data_frame$기준일[which(is.na(year_18_food_data_frame$기준일))] <-
  year_18_food_data_frame$일자[which(!is.na(year_18_food_data_frame$요일))]

sum(is.na(year_18_food_data_frame$기준일))

# 연령대
sum(which(is.na(year_18_food_data_frame$연령대)) != which(!is.na(year_18_food_data_frame$연령))) 
year_18_food_data_frame$연령대[which(is.na(year_18_food_data_frame$연령대))] <-
  year_18_food_data_frame$연령[which(!is.na(year_18_food_data_frame$연령))]

sum(is.na(year_18_food_data_frame$연령대))    

str(year_18_food_data_frame)

# 이제 필요 없는, 발신지_시도, 발신지_구, 발신지_동, 일자, 연령은 제거 하자.
year_18_food_data_frame <- year_18_food_data_frame[,1:9]

for (i in 1:9) {
  print(sum(is.na(year_18_food_data_frame[,i])))
}

# 과거에 피자는 업종에 데이터가 없어서 NA로 표시가 되어 있다.
year_18_food_data_frame$업종[which(is.na(year_18_food_data_frame$업종))] <- "피자집"

# 최종 NA 확인
sum(is.na(year_18_food_data_frame))

# 최종결과
#dim(year_18_food_data_frame)
#head(year_18_food_data_frame)


###
#rm(list=ls())

library(lubridate)
#year_18_food_data_frame <- year_18_food_data_frame %>% 
 # mutate(month = month(year_18_food_data_frame$기준일))

#year_18_food_data_frame$month <- as.factor(year_18_food_data_frame$month)

#head(year_18_food_data_frame)

#library(dplyr)
#library(ggplot2)

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
                    # 성별 : 남자가 111,600 , 여자가 111,600 명으로 똑같다..?? 유동인구수의 총 데이터는 억이 넘어가니 이건 뭔가 이상하다.
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
