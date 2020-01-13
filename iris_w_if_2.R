iris

# if문과 for문을 통해서 irir 첫번재 컬럼이 평균보다 높으면
# '높다', 그렇지 않으면 "아니다"

for (i in 1:100) {
  if((i %% 2) == 0) {
    print("짝수입니다.")  
  } else {
    print("홀수입니다.")
  } 
}

for (i in iris[,1]) {
  if(mean(iris[,1]) < i) {
    print("높다")
  } else {
    print("아니다")
  }
}

plot(iris[,1])