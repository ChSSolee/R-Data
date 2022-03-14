install.packages("devtools")
library(devtools)
install_github("regbook/regbook")
library(MASS)
library(regbook)
install.packages("dplyr")
install.packages("tidyr")
install.packages("plyr")
library(dplyr)
library(tidyr)
library(plyr)
head(houseprice)

plot(price~tax, data = houseprice)
pairs(houseprice)
options(digits=3); cor(houseprice); options(digits=7)

# 예비모형
fit1 = lm(price~tax + ground + floor + year, data=houseprice)
summary(fit1)
# 결정계수 R^2 = 0.93, 분산분석표의 F에 대한 p값 < 0.0001
# p-value = 1.817e-12 < 유의수준 alpha이기 때문에, 모든 설명변수들이 0 이라는
# H0 : B1 = B2 = B3 = B4 = 0기각.
anova(fit1)
# 회귀계수 추정값의 유의성 : tax와 floor가 주택가격 결정의 중요한 요소
# Pr(>|t|) < 유의수준 alpha 이기 때문에, tax와 floor이 0 이라는 귀무가설을 기각.

# 편제곱합
drop1(fit1)

# 다중공선성
vif(fit1)
# 10보다 큰지 작은지 확인

# 독립성
install.packages("lmtest")
lmtest::dwtest(fit1)
# 더빈-왓슨 검정
# p-value = 0.3247 > alpha 이므로 Rho = 0 이라는 귀무가설 기각X, 독립성 만족

# 잔차분석과 영향력 관측치
par(mfrow=c(2,2))
plot(fit1)

# 최적모형 구축 : 간결함의 원칙
houseprice.rgs <- regsubsets(price ~ ., houseprice, nbest=6)
# 가능한 모형들에 대한 변수선택 기준값
summaryf(houseprice.rgs)

# 단계별 회귀
model0 <- lm(price ~ 1, houseprice)
step(model0, scope = ~ tax + ground + floor + year, direction = "both")

# 모형확인
fit2 <- lm(price~tax + floor, houseprice)
sum(resid(fit2)^2) ; deviance(fit2) # SSE = 95.2
sum((resid(fit2) / (1-hatvalues(fit2)))^2) # PRESS=144
# PRESS > SSE -> 예측의 정확도가 높지 않은것으로 판단
# R^2_prediction = 1 - 144.40 / 1330.58 = 0.8915
# 예측의 정확도가 어느정도 높다. 최종모형의 새로운 자료에 대한 적용 가능

# 부분 F 검정 : 두 모형을 비교
# Box-Cox 변환 : 정규성을 만족하지 않을시 적용

# 기초통계학 문제에 대한 회귀분석의 응용
# 통계학 교재 연습문제 7.4
score <- c(99,69,91,97,70,99,72,74,74,76,96,97,68,71,99,78,76,78,83,66)
t.test(score, mu = 80, alternative = "greater")
# t = (y_bar - mu0) / (s/sqrt(n)) = 0.6067
# p-value = 0.2756, 유의수준 보다 크므로 귀무가설 H0 : mu = 80 기각 못함
t.test(score, mu = 80) # default : alternative = "two.sided", 양측검정
# 95%신뢰구간 = mu = y_bar +- t_a/2(n-1)*s/sqrt(n)

fit1 = lm(score ~ 1)
summary(fit1)
# Y = B0 + e, B0_hat = Y_bar
# H0 : B0 = 0
(temp = (81.65 - 80) / 2.72) # test statistic for H0 : mu = 80
(2* (1-pt(temp,19))) # p- value 
1.65 / (12.16 / sqrt(20))


# 두 모집단의 평균 비교 
# 통계학 교재 연습문제 8.5
setwd(readClipboard())
getwd()
prob0805 <- read.table("prob0805.txt")
names(prob0805) <- c("resistance", "type")
head(prob0805)

t.test(resistance ~ type, data = prob0805, var.equal = TRUE) 
# var.equal = TRUE : 등분산 가정

fit2 = lm(resistance ~ factor(type), data = prob0805)
summary(fit2)
# 자동으로 등분산 가정

# 세 모집단 이상의 평균 비교 : 분산분석
# 통계학 교재 연습문제 9.2
fit3 <- aov(score ~ factor(grade), data = english1)
summary(fit3)

fit3.lm <- lm(score ~ factor(grade), data = english1)
summary(fit3.lm)

anova(fit3.lm)

english1 ; english1$grade <- factor(english1$grade, levels=c(4,1:3))
fit <- lm(score ~ grade, english1)
summary(fit)
# c(4, 1:3) : 범주 순서를 바꿈

# 7.2 회귀모형을 이용한 분산분석과 공분산분석
# 예제 7.3
library(regbook)
head(english1)
head(english1$score)
english1$grade
fit1 <- lm(score ~ grade, data = english1)
summary(fit1)
model.matrix(fit1)

grade2 <- factor(english1$grade, levels = c(1:4)) # 가변수화
grade2
fit2 <- lm(score ~ factor(grade), english1)
model.matrix(fit2) # 1학년 기준범주
summary(fit2) # Y_bar1 = 78.833 (1학년 평균)

english1$grade <- factor(english1$grade, levels=c(4,1:3))
# 4학년 기준 범주화
fit3 <- lm(score ~ grade, data = english1)
model.matrix(fit3)
summary(fit3) # Y_bar4 = 87.5 (4학년 평균)
vcov(fit3) # 공분산분석

fit4 <- lm(score ~ grade - 1, data = english1)
model.matrix(fit4)
summary(fit4)

# 공분산분석 
head(english2)
english2$method <- relevel(english2$method, ref = "C") # 기준범주를 C로 설정
english2$method
fit <- lm(postscore ~ method + prescore, english2)
summary(fit)

# 다항회귀분석
x <- 1:10
x2 <- x^2
cor(x, x2) # x와 x2간 상관관계가 높다
xm = x- mean(x)
xm2 = xm^2
cor(xm, xm2) # xm과 xm2간 상관관계 없음

# 예제 7.5
# 1차 모형
fit1 <- lm(rate ~ conc, enzyme)
summary(fit1)

# 2차 모형 
fit2 <- update(fit1, . ~ . + I(conc^2))
summary(fit2)

# 3차 모형
fit3 <- update(fit2, . ~ . + I(conc^3))
summary(fit3)

# 4차 모형
fit4 <- update(fit3, . ~ . + I(conc^4))
summary(fit4)
# 3차 다항식가지는 모든 회귀계수의 추정값이 유의
# 4차 다항식부터 4차항의 추정값이 유의X, 3차가 최종모형
# 매 단계 가장 높은 차수의 회귀계수에 대하여 검정

fit <- lm(rate ~ conc + I(conc^2) + I(conc^3), enzyme)
summary(fit)

# 직교 다항식
fit <- lm(rate ~ poly(conc, 3, raw = T), enzyme)
summary(fit)

# 반응표면분석
# 일차는 FO, 이차는 PQ, 이원교호작용 TWI, 모든항 SO
install.packages("rsm")
library(rsm)
yield.rsm <- rsm(yield ~ SO(time, temp), data = yield)
yield.rsm
summary(yield.rsm)
# 고유값이 하나는 양수, 하나는 음수 -> 안장점

yield.rsm$b ; yield.rsm$B
xs <- -(solve(yield.rsm$B)) %*% yield.rsm$b / 2 ; xs #정상점
xs(yield.rsm) # 정상점
nw <- data.frame(time=xs(yield.rsm)[1], temp=xs(yield.rsm)[2]); nw
nw <- data.frame(time=xs[1], temp=xs[2]) ; nw

predict(yield.rsm, newdata=nw) # 정상점에서의 반응변수 적합값

yieldcoded <- coded.data(yield, x1 ~ (time-12)/8, x2 ~ (temp-250)/30)
yieldcoded.rsm <- rsm(yield ~ SO(x1, x2), data = yieldcoded)
summary(yieldcoded.rsm)
# 표준화 후 반응 표면분석
# |2.708577| < |-6.983377| 이므로, 증가하는 방향의 경사가 더 큼

# 반응표면분석 결과 : 등고선 & 3차원 그림
contour(yieldcoded.rsm, ~ x1 + x2, image=T) # image 옵션 : 색을 추가
persp(yieldcoded.rsm, ~ x1 + x2, theta = 120, col = "lightcyan") # theta 옵션 : 각도조정

# 예제 8.1
library(regbook) ; head(elementheight)
fit.wls <- lm(meanheight ~ age, data=elementheight, weights =1/sdheight^2)
summary(fit.wls)
# 가중치 (weights)는 분산의 역수 

# 예제 8.2 
fit.ols <- lm(Y ~ X, restaurant)
plot(resid(fit.ols) ~ fitted(fit.ols)) # 깔때기 모양, 등분산성 가정 타당X

vcov(fit.ols) # OLSE의 분산-공분산행렬 추정량 계산
install.packages("sandwich")
HC0 <- sandwich::vcovHC(fit.ols, type="HC0") ; HC0
# vcov(fit.ols)와 비교
# B1의 분산은 비슷, B0의 분산은 상당한 차이 => 이분산성이 의심

install.packages("lmtest")
lmtest::coeftest(fit.ols, vcov=HC0)
lmtest::coeftest(fit.ols)

# Breusch-Pagan 검정
lmtest::bptest(fit.ols)
# 귀무가설 H0 : 등분산성 만족, p-value < 0.05
# 귀무가설 기각

# 예제 8.3
head(restaurant)
agg <- aggregate(Y ~ X, restaurant, sd) ; agg
# 수준별 Y의 표준편차 계산
plot(Y ~ X, agg)
(sdfit <- lm(Y ~ X + I(X^2), agg))
# shat = 2.7074 - 0.3222x + 0.0408x^2
s <- predict(sdfit, newdata=data.frame(X=restaurant$X))
(w <- 1/s^2) # 가중치 wi = 1 / shat^2

fit.wls <- lm(Y ~ X, restaurant, weights=w)
summary(fit.wls)
summary(fit.ols)
HC0 <- sandwich::vcovHC(fit.wls, type="HC0")
lmtest::coeftest(fit.wls, vcov=HC0)
# B0과 B1의 OLSE : 47.2159, 8.4879
# B0과 B1의 WLSE : 47.732, 8.43 
# 두 추정값이 비슷하다. why? (비편향성이 만족, 일반적 현상)
# 두 추정값이 비슷하게 나오면, 가중치가 적절하다는 증거

# e_i vs yhat_i
plot(resid(fit.wls) ~ fitted(fit.wls)) 
# 가중잔차 vs 가중예측값
plot(rstandard(fit.wls) ~ fitted(fit.wls))

# 예제 8.4
fit <- lm.ridge(y ~ x1 + x2 + x3 + x4, hald, lambda=seq(0,0.5,0.01))
plot(fit) # 0.2 ~ 0.3 구간부터 궤적이 안정화, lambda = 0.2~0.3 ,선택은 주관
lm(y ~ ., hald)

# GCV방법
select(fit) # lambda=0.32
lm.ridge(y ~ x1 + x2 + x3 + x4, hald, lambda=seq(0,0.4,0.1))
lm.ridge(y ~ x1 + x2 + x3 + x4, hald, lambda=0.25)

# 예제 8.5
head(hald)
cor(hald)
(R <- cor(hald[2:5])) 
eigen(R) #  상관계수행렬에 대한 고유값 분해

# 주성분 분석 
pr <- princomp(hald[2:5], cor=T)
summary(pr)
plot(pr, type="l") # Y축이 고유값

# 주성분 회귀
(hald.pc <- data.frame(pr$scores))
hald.pc$y <- hald$y # hald.pc에 y 추가
fit <- lm(y ~ ., hald.pc)
summary(fit) 
# 4개의 주성분 전부사용 = 완전 주성분 회귀, 차원 축소X
# 주성분 분석의 본래 목적은 차원을 축소하는 것 

# 예제 8.6
regbook::pcr(y ~ ., hald, ncomp=4)
regbook::pcr(y ~ ., hald, ncomp=3)

# 주성분회귀분석의 결과를 원래 설명변수들로 표현
fit.pcr <- regbook::pcr(y ~ ., hald, ncomp=3)
coef(fit.pcr)
# y_hat = 85.7432635 + 1.31189 x1 + 0.2694193 x2 - 0.1427654 x3 - 0.38 x4

# 예제 8.7
library(regbook)
head(stackloss)
plot(stackloss)

fit.ols <- lm(stack.loss ~ ., stackloss)
fit.ols
# OLSE로 적합된 회귀식 : Yhat = -39.920 + 0.716X1 + 1.295X2 - 0.152X3
plot(fit.ols, which=5)
# 표준화잔차 절대값이 2보다 큰 4,21이 특이점
# 17번째 관측치는 높은 지렛점

sapply(stackloss ,sd)
sapply(stackloss, mad)
# 반응변수 stack.loss의 표준편차와 MAD의 차이가 가장 큼 => 특이점의 가능성
# 설명변수 Air.Flow의 경우에도 큰 차이 => 높은 지렛점의 가능성

library(MASS)
fitM <- rlm(stack.loss ~., stackloss, method="M", psi=psi.bisquare)
# 가중치 함수를 Tukey 방식대로
summary(fitM)
# 적합된 로버스트 회귀식 : Yhat = -42.2853 + 0.9275X1 + 0.6507X2 - 0.1123X3
# OLSE의 결과와 차이가 있다

plot(fitM, which=7) 
# 잔차(세로축) 기준선 : -3, +3
# MCD거리(가로축) 기준선 : sqrt(pchisq(0.975,3)) = 3.057516
# 4, 21이 특이점
plot(fitM, which=8) 
# MCD거리(세로축) 기준선 : sqrt(pchisq(0.975,3)) = 3.057516
# 1,2,3,21이 높은 지렛점
# OLSE와 비교시, 특이점은 동일, 높은 지렛점은 상이함

# 예제 8.8
head(cygnus)
fit.ols <- lm(light ~ temp, cygnus)
summary(fit.ols)
# 단순 회귀 모형 : Yhat = 6.7935 - 0.4133X
plot(light ~ temp, cygnus) 
# 좌측 상단 4개 특이값들이 특이점이면서 높은 지렛점
plot(fit.ols, which=5)

fitMM <- rlm(light ~ temp, cygnus, method="MM")
summary(fitMM)
# 적합된 로버스트 회귀직선 : Yhat = -4.9702 + 2.2534X
plot(fit.ols)

plot(light ~ temp, cygnus)
abline(6.7935,-0.4133) ; abline(-4.9702, 2.2534)

# 비선형회귀모형
# 예제 9.1
library(regbook)
plot(y ~ x, growth1))
# 성장치(Y)의 최대값 (theta1) = 22
# 성장치 최대값의 반만큼 성장할 때 까지 걸리는 시간(X) (theta2) = 9

# 예제 9.2
growth1.nls <- nls(y ~ theta1*x/(theta2 + x),
                   data = growth1, 
                   start = list(theta1 = 22, theta2 = 9),
                   trace = TRUE)
summary(growth1.nls)
# s = 0.5185 = var(e), 4번의 반복
# theta1 = 28.137, theta2 = 12.5744

plot(y ~ x, growth1)
theta <- coef(growth1.nls)
curve(theta[1]*x / (theta[2] + x), add = T, col = 2)
points(growth1$x, fitted(growth1.nls), type="l", col="blue")

growth1.nls <- nls(y ~ SSmicmen(x, theta1, theta2), growth1, trace = TRUE)
# 초기값 생성

# 예제 9.3
deviance(growth1.nls) / df.residual(growth1.nls)
# 오차분산의 추정값 s^2

summary(growth1.nls)
# SE(theta1) = 0.728, SE(theta2) = 0.7631

coef(growth1.nls)[1] + qt(c(0.025, 0.975),16) * sqrt(vcov(growth1.nls)[1,1])
coef(growth1.nls)[2] + qt(c(0.025, 0.975),16) * sqrt(vcov(growth1.nls)[2,2])
regbook::waldint(growth1.nls)
# 95% 신뢰구간

r <- residuals(growth1.nls, type = "pearson")
# 표준화잔차
plot(fitted(growth1.nls), r, 
     xlab = "Fitted Values", 
     ylab = "Standardized Residuals") ;abline(h=0, lty=2)
# 표준화 잔차 vs 예측값
plot(growth1$x, r,
     xlab = "x", 
     ylab = "Standardized Residuals") ; abline(h=0, lty=2)
# 표준화 잔차 vs x
plot(r, ylab = "Standardized Residuals") ; abline(h=0, lty=2)

# 프로파일 t함수를 이용한 신뢰구간과 곡률분석
# 9.4
growth1.nls <- update(growth1.nls, trace = F)
confint(growth1.nls) # profile t 함수를 이용한 신뢰구간
regbook::waldint(growth1.nls) # 선형근사화를 이용한 신뢰구간(t분포)

par(mfrow=c(1,2))
plot(profile(growth1.nls), absVal=F, conf=0.95)

# 10.1
setwd(readClipboard())
beetle <- read.table("beetle.txt", header = T)
head(beetle)
plot(killed ~ conc, beetle)
with(beetle, lines(lowess(conc, killed), lty = 2, col=2))

fit1.beetle <- glm(killed ~ conc, family = binomial, data = beetle)
summary(fit1.beetle)     
qchisq(0.95, 479)

curve(exp(-60.717+34.270*x)/(1+exp(-60.717+34.27*x)),
      add=T, col=4)

beetle2 <- read.table("beetle2.txt", header = T)
head(beetle2)

fit2.beetle <- glm( cbind(nkilled, nalive = nbug-nkilled) ~conc,
                    family = binomial, data = beetle2)
summary(fit2.beetle)

(beetle2$rate <- beetle2$nkilled / beetle2$nbug)
plot(rate ~ conc, beetle2)
points(beetle2$conc, fitted(fit2.beetle), type="l", col=4)
curve(exp(-60.717+34.270*x)/(1+exp(-60.717+34.27*x)),
      add=T, col=2)

# 10.2
salary <- read.table("salary.txt", header = T)
head(salary)
plot(gender~salary, salary)
with(salary, lines(lowess(salary,gender),lty=2,col=2))

fit.sal <- glm(gender ~ salary, family = binomial, data= salary)
summary(fit.sal)               
qchisq(0.95,49)
curve(exp(3.097-0.0001879*x)/(1+exp(3.097-0.0001897*x)),
      add=T, col=4)

# 10.3
kgss <- read.csv("chastity.csv", header=T)
kgss$chastity = ifelse(kgss$chastity == 1, 0, 1)
# 1=동의, 0 = 비동의
head(kgss)
fit.kgss <- glm(chastity ~ factor(gender)+factor(politic)+educ+factor(age)+factor(marital)
                +factor(income)+factor(religion), family=binomial, data=kgss)
summary(fit.kgss)
(coeff = coef(fit.kgss)) # 추정 회귀계수
(OR = exp(coeff)) # 오즈비

# 11.8
beetle <- read.table("beetle.txt", header = T)
fit1.beetle <- glm(killed ~ conc, family = binomial, data = beetle)
summary(fit1.beetle)

(645.44 - 372.47) > qchisq(0.95, 1)
# 가설 B1 = 0 기각
 
predict(fit1.beetle, type = "link")
predict(fit1.beetle, type = "response")

beetle2 <- read.table("beetle2.txt", header = T)
head(beetle2)
fit2.beetle <- glm(cbind(nkilled, nalive = nbug-nkilled) ~ conc,
                   family = binomial, beetle2)
predict(fit2.beetle, type = "link") # 선형예측치 예측값
predict(fit2.beetle, type = "response") # 평균값

resid(fit2.beetle, type = "response") # 원시 잔차
resid(fit2.beetle, type = "pearson") # Pearson 잔차
resid(fit2.beetle, type = "deviance") # deviance 잔차

beetle2$nbug * predict(fit2.beetle, type = "response")
# 기대도수

# 11.9
kgss <- read.csv("chastity.csv", header=T)
kgss$chastity = ifelse(kgss$chastity == 1, 0, 1)
# 1=동의, 0 = 비동의
head(kgss)
fit.kgss <- glm(chastity ~ factor(gender)+factor(politic)+educ+factor(age)+factor(marital)
                +factor(income)+factor(religion), family=binomial, data=kgss)
fit2.kgss <- glm(chastity ~ factor(gender)+educ+factor(age)
                +factor(income)+factor(religion), family=binomial, data=kgss)
summary(fit.kgss) ; summary(fit2.kgss)

D1 = 1501.2 ; D2 = 1502.6
(D1-D2) > qchisq(0.95, 3)
# 귀무가설 기각 불가 -> fit2 선택

anova(fit.kgss, fit2.kgss, test="Chisq")

# 11.8 
beetle.probit <- glm(cbind(nkilled, nalive= nbug-nkilled) ~ conc,
                     family = binomial(link = "probit"), beetle2)
summary(beetle.probit)
beetle.logit <- glm(cbind(nkilled, nalive= nbug-nkilled) ~ conc,
                    family = binomial(link = "logit"), beetle2)
summary(beetle.logit)
beetle.cloglog <- glm(cbind(nkilled, nalive= nbug-nkilled) ~ conc,
                      family = binomial(link = "cloglog"), beetle2)
summary(beetle.cloglog)

qcauchy(0.95,6)

beetle2$nbug * predict(beetle.cloglog, type="response")
# cloglog 모형 기대도수

# plotting the fitted equations
conc2 = seq(1.6, 1.95, 0.01)
coef1 = coef(beetle.logit)
coef2 = coef(beetle.probit)
coef3 = coef(beetle.cloglog)
linpre1 = coef1[1] + coef1[2]*conc2
linpre2 = coef2[1] + coef2[2]*conc2
linpre3 = coef3[1] + coef3[2]*conc2
fitted1 = exp(linpre1) / ( 1 + exp(linpre1) )
fitted2 = pnorm(linpre2)
fitted3 = 1 - exp( -exp(linpre3) )

rate <- beetle2$nkilled / beetle2$nbug
plot(rate ~ beetle2$conc)
points(conc2, fitted1, type="l", lty=1, col=4)
points(conc2, fitted2, type="l", lty=2, col=6)
points(conc2, fitted3, type="l", lty=3, col=1)
legend(1.7, 0.9, c("logistic", "probit", "cloglog"), col = c(4, 6, 1), lty = c(1, 2, 3))

# 예제 12.1
setwd(readClipboard())
coronary <- read.table("coronary.txt", header = T)

fit1.coronary <- glm(death ~ smoke + age, family = poisson(link = "log"),
                     offset = log(personyears), data = coronary)
summary(fit1.coronary)

coronary = within(coronary, pdeath <- death / personyears * 100000)
plot(pdeath ~ age, coronary, type = "n")
text(pdeath ~ age, coronary, labels = smoke) 

fit2.coronary <- glm(death ~ smoke + age + I(age^2) + I(age*smoke),
                     family = poisson(link = "log"), offset=log(personyears), data = coronary)
summary(fit2.coronary)


# 12.2
edusoceco <- read.table("edusoceco.txt", header = T)
tbl <- xtabs(count ~ soceco + edu, data = edusoceco) # 3X3 분할표
chisq.test((tbl))

# 12.3
fit1.ese = glm(count ~ factor(soceco) + factor(edu), family = poisson, data = edusoceco)
summary(fit1.ese)

1 - pchisq(deviance(fit1.ese), fit1.ese$df.residual)

fit2.ese = glm(count ~ factor(soceco) + factor(edu) + factor(soceco):factor(edu),
               family = poisson, data = edusoceco)
summary(fit2.ese)

# 12.4
Freq <- c(22,2,10,16,54,115,19,33,73,11,17,28)
Tumour <- rep(c("허친슨", "표피성", "결절성", "기타"), each = 3)
Tumour = factor(Tumour) ; Tumour = relevel(Tumour, ref = "기타")

Site = rep(c("머리", "몸통", "손발"), 4)
Site = factor(Site) ; Site = relevel(Site, ref = "머리")

melanoma = data.frame(Tumour, Site, Freq)
melanoma
tbl = xtabs(Freq ~ Tumour + Site, data = melanoma)
tbl
chisq.test(tbl)

fit1.mel <- glm(Freq ~ Tumour + Site, family = poisson, data = melanoma)
summary(fit1.mel)

fit2.mel <- glm(Freq ~ Tumour * Site, family = poisson, data = melanoma)
summary(fit2.mel)

anova(fit1.mel, fit2.mel, test = "Chisq")

resid(fit1.mel, type = "pearson")

# 12.5
Freq <- c(25, 13, 6, 29)
Group <- rep(c("control", "vaccine"), each = 2)
HIA <- rep(c("low", "xhigh"), 2)
(vaccine <- data.frame(Group, HIA, Freq))
(tbl <- xtabs(Freq ~ Group + HIA, data = vaccine))
chisq.test(tbl)

vac.fit1 = glm(Freq ~ Group + HIA, family = poisson, data = vaccine)
summary(vac.fit1)

vac.fit2 = glm(Freq ~ Group*HIA, family = poisson, data = vaccine)
summary(vac.fit2)

anova(vac.fit1, vac.fit2, test = "Chisq")

# 12.6
Freq <- c(25, 13, 6, 29)
Group <- c("control", "vaccine")
HIAlow <- c(25, 6)
HIAhigh <- c(13, 29)
(vaccine2 <- data.frame(Group, HIAlow, HIAhigh))

vac.fit1 <- glm(cbind(HIAhigh, HIAlow) ~ Group, family = binomial(link = "logit"), data = vaccine2)
summary(vac.fit1)
