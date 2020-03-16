# 신용 데이터셋 적재하기
d <- read.table(paste("http://archive.ics.uci.edu/ml/",
                      "machine-learning-databases/statlog/german/german.data", sep=""),
                stringsAsFactors = FALSE, header = FALSE)

print(d[1:3],)
class(d)
d[1:3,]
summary(d)
# require(RCurl) HTTP로 데이터 로딩하기 
# GitHub에서 직접 로딩할 때의 어려움은 다음과 같다. 먼저 올바른 URL(GitHub 페이지 리디렉션을 방지하기 위해)을 찾고, 
# 둘째로 HTTPS 연결을 통해 데이터에 엑세스할 수 있는 라이브러리를 찾는 것이다.
# 좀 더 파고 들면 GitHub 원시 URL의 구조를 연구할 수 있다. 다음 예제와 같이 HTTPS 소스에서 데이터를 로드할 수 있다.

# require(RCurl) # 더 많은 연결 방법을 위해 RCurl 라이브러리를 사용한다.
# urlBase <-
# "https://raw.github.com/WinVector/zmPDSwR/master/"   # GubHub 저장소를 연결하기 위한 유효한 HTTPS URL을 구성한다.

# mkCon <- function(nm) {
# textConnection(getURL(paste(urlBase, nm, sep= "")))  # URL 경로를 넣어 HTTPS로 연결하도록 하는 함수를 작성한다.
# }

# cars <- read.table(mkCon("UCIcar/car.data.csvb"),    # HTTPS로 GitHub에서 자동차 데이터를 로딩한다. 
                   # sep = ",", header = TRUE, comment.char = "")

colnames(d) <- c( "Status.of.existing.checking.account",
               "Duration.in.month", "Credit.history", "Purpose", 
               "Credit.amount", "Savings account/bonds",
               "Present.employment.since",
               "Installment.rate.in.percentage.of.disposable.income",
               "Personal.status.and.sex", "Other.debtors/guarantors",
               "Present.residence.since", "Property", "Age.in.years",
               "Other.installment.plans", "Housing",
               "Number.of.existing.credits.at.this.bank", "Job",
               "Number.of.people.being.liable.to.provide.maintenance.for",
               "Telephone", "foreign.worker", "Good.Loan")

d$Good.Loan <- as.data.frame(ifelse(d$Good.Loan == 1, "GoodLoan", "BadLoan"))

print(d[1:3],)
str(d)
dim(d)
summary(d)
# 
# mapping <- list(
#   "A40" = "car(new)",
#   "A41" = "car(used",
#   "A42" = "furniture/equipment",
#   "A"
)

