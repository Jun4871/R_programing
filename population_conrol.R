# 기본 세팅
Sys.setenv(RSTUDIO_PANDOC="/usr/lib/rstudio-server/bin/pandoc")

# 마크다운 렌더링 위한 라이브러리
library(rmarkdown)

# 외부 parameter
args=(commandArgs(TRUE))


month <- args[1]

# html_link <- paste0("report_",gsub("-","_",Sys.time()),".html")

# 파일 이름
html_link <- paste0("report_month",month,".html")

# 렌더링 함수
# render(
#   rmd 경로, 
#   html 파일 이름, 
#   html 경로, 
#   파라미터 지정(optional)
# )

render("/home/ryukyungjun/R_programing/population.Rmd",
        output_file = html_link,
        output_dir = "/home/ryukyungjun/R_programing/htmlfile",
       params = month
       )