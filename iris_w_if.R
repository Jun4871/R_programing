iris
iris[,1]
iris [1,]

if (iris[,1] > 5) {
  print("맞습니다")
} else { 
  print("아닙니다")
}


if(2 > 5) {
  print("맞습니다.")
} else {
  print("아닙니다.")
}


for (i in iris[,1]) {
  if(i > 5) {
    print("맞습니다")
  } else {
    print("아닙니다")
  }
  
}

for (i in 1:100) {
  if((i %% 2) == 0) {
    print("짝수입니다.")  
  } else {
    print("홀수입니다.")
  } 
}