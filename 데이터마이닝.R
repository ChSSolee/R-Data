# statistical learning

# Y = f(X) + error

# f(x) = statistical learning model, error = random error
# Y = responsible varibable (반응변수), X = explaning variable (설명변수)
# error = random error

# Yi = B0 + B1X1i + ... B3X3i + ei (i = 1,,,)
# 만약 데이터의 (1 ~ 300)가 훈련데이터(training data) 
# (301 ~ 400)이 검정데이터(testing data)라면 
# 데이터를 300까지만 사용하여 Beta hat을 추정
# testing data를 사용하여 추정값들을 평가 (MSE)

# MSE(Mean Square Error)
# Y hat의 정확성 = E(Y - Y_hat)^2 = [f(X) - f_hat(X)]^2 + var(error)
# = 축소가능오차(reducible error) + 축소불가능오차(irreducible error)
# 축소가능오차를 최소로하는 f를 추정하는 기법을 찾아야함.

# Y = f(X) + e  ->  Y_hat = f_hat(X)
# E(Y - Y_hat)^2 = E(f(X) + e - f_hat(X))^2 
# = E(f(X) - f_hat(X))^2 + E(e)^2 + 2* E(f_hat(x))*e
# = f(X) - f_hat(X)^2 + var(e)
# [ E(f_hat(x)) = f(x), var(e) = E(e^2) - (E(e))^2 ]

#  X1, X2,,, Xp의 함수로 Y가 어떻게 변하는가?
# X의 어떤 변수가 Y와 관련되어 있는가?, X와 Y의 상관관계는 무엇인가?(양? 음?)
# Y와 X의 각 원소의 상관관계는 선형모델로 충분히 요약 가능한가?

# 1) 선형 모델(linear model) (X1,,, Xp)
# p+1개의 parameter를 추정
# 최소제곱방법을 이용하여 Training data로 모델을 적합
# ex) 회귀(regression) : 양적반응변수
# 분류(classification) : 질적반응변수
# 라소(lasso)

# 2) 비선형 모델(non-linear model)
# 선형모델보다 더 parameter가 많고 유연
# 과적합 문제 존재 가능
# ex) 다항식회귀, 회귀스플라인, 일반화가법모델

# 3) 비모수적 방법(Nonprametric methods)
# 선형 모델과 비선형 모델은 모수적 방법
# 비모수적 방법은 함수 f의 형태를 명시적으로 가정안함
# ex) tree, bagging, random forest, boosting, support vector machine

# 4) 비지도 학습(Unsupervised learning)
# 모수적, 비모수적방법은 모두 지도학습
# 비지도 학습은 X는 관측하지만 연관된 출력변수 Y가 없을 떄 사용
# 예측할 반응 변수가 없으므로 뚜렷한 반응변수 없음.
# ex) 주성분 분석, 군집분석(clustering)

# flexible 한 모델은 적합이 잘됨, 그렇다면 왜 less flexible 모델을 사용?
# 해석이 쉽다, 과적합을 피하기 때문에 예측력도 더 좋을 수 있다.

# Assessment of Model Accuracy

# 모델 정확도(Model Accuracy)

# 1) 평균제곱오차 (Mean Squared Error - MSE)
# 반응변수가 양적변수인 회귀에서
# 관측치가 예측치와 얼만큼 가까운지를 수량화
# Training MSE : training data로 계산된 예측치와 관측치의 평균제곱오차
# Test MSE : testing data로 계산된 예측치와 관측치의 평균제곱오차
# 실제로 관심있는 통계학습방법은 test MSE가 가장 작은 모델
# 일반적인 경우, 선형관계, 비선형관계

# test MSE가 왜 U자 모양을 띄는가?
# 편향 분산 절충 (Bias Variance Trade Off)
# Test MSE (Y01 .... Y0n, X01 .... X0n)
# sum(y0i - f_hat(x0i))^2 / n = MSE
# E(y0 - f_hat(x0))^2 = E(f_hat(x0) - y0)^2
# = E(f_hat(x0) - E(f_hat(x0)) + E(f_hat(x0)) - y0)^2
# = (E(f_hat(x0) - E(f_hat(x0))^2 + E(f_hat(x0) - y0)^2 
# + 2E(f_hat(x0) - E(f_hat(x0)) * E(f_hat(x0) - y0)
# = (E(f_hat(x0) - E(f_hat(x0))^2 + E(f_hat(x0) - y0)^2 
# = var(f_hat(x0)) + bias^2(f_hat(x0))
# = 분산 + 편향의 제곱 (다양한 training data를 통해서 추정된 f_hat)
# 모델의 flexibility(유연성)가 커질수록 분산이 증가, 편향 감소
# 모델의 flexibility가 작을수록 분산이 감소, 편향 증가 

# 모델정확도 (Model Accuracy)
# 2) 오차율 (error rate - ER)
# 반응변수가 질적 변수인 분류 문제에서
# 관측 클래스가 예측 클래스와 얼마만큼 다른지 수량화
# Training ER : training data로 계산된 관측 클래스와 예측 클래스의 오차율
# Test ER : 
# ER_train = (1 / n_train) sum( I(Yi =! y_hati))

# 베이즈 분류기 (Bayes Classifier)
# 조건부 확률을 이용하여 예측 클래스를 결정, 실제 분포를 앎
# y_hati = 1 if P(Y=1 | X = x0) > 0.5 else 0
# Simulation data이므로 조건부 확률 계산 가능 -> Bayesian decision boundary 결정

# Bayes 오차율
# 1 - max(P(Y = j | X))
# 가능한 검정 오차율중 가장 낮은 값

# 전체 Bayes 오차율
# 1- E[max(P(Y=j|X))]
# Simulation의 Bayes 오차율 = 0.1304

# K-최근접이웃 (K - Nearest Neighbors = KNN)
# 주어진 X에 대한 Y의 조건부 분포를 추정하여 가장 높은 추정확률 가지는
# 클래스로 예측 클래스 결정
# Training data에서 x0에 가장 가까운 K개 점(N0로 표시)을 식별
# 클래스 j에 대한 조건부 확률
# EX) 파란색 6개, 오렌지색 6개, 검은색 X표시 예측, K=3 선택(영역 설정)
# => 영역안에 점 3(=K)개중 파란색 2, 오렌지색 1개면, X는 파란색 클래스
# K가 너무 늘어나는 것 = 선형에 가까워지며, 유연성이 떨어짐
# 따라서 실제 분포와 비슷할 정도로만 K값을 결정 

# R
# 스칼라 : 한개 값만 갖는 변수
# 벡터 : 여러개의 자료를 저장할 수 있는 1차원 선형 자료 구조
# 매트릭스 : 동일한 자료형을 갖는 2차원 배열 구조
# 어레이 : 동일한 자료형을 갖는 다차원 배열 구조
# 리스트 : 성격이 다른 자료 구조를 객체로
# 데이터 프레임 : R에서 가장 많이 사용되는 자료구조, 리스트와 벡터 혼합

# vector 객체 생성
x <- c(1,3,2,5) ; x[1]

x <- c(1,6,2) ; y <- c(1,4,3)
length(x) ; length(y)
x + y 

union(x,y) ; intersect(x,y) ; setdiff(x,y) ; setdiff(y,x)

# ls () 함수, 정의된 것들을 모두 삭제
rm(x,y)
rm(list=ls())
ls()

# matrix 객체 생성
x <- matrix(1:4, nrow=2, ncol=2, byrow = T)
x <- matrix(1:4,2,2)
sqrt(x) #
x^2
x%*%x

# Matrix 객제 indexing
A <- matrix(1:16,4,4) ; A ; A[3,3] ; A[2,3] ; A[2:3, 2:3]
A[c(2,4), c(2,4)]
A[,-c(1,2)] ; A[-c(1,3),] ; dim(A) ; ncol(A) ; nrow(A) 
colnames(A) = c('1','2','3','4') ; A

# Random sampling from Normal Distribution
x <- rnorm(50) # 50 random samples from N(0,1)
x ; mean(x) ; sd(x)

y <- x + rnorm(50,50,sd=0.1)
cor(x,y)

set.seed(3) # seed number 부여시 rnorm이 실행마다 변경되지 않음.
y <- rnorm(100)
mean(y) ; var(y) ; sd(y)

# 산점도 (Scatter plot)
x <- rnorm(1000)
y <- rnorm(1000)
plot(x,y)
plot(x,y, xlab="x-axis", ylab="y-axis", main = "X vs Y")

xy <- matrix(c(x,y), ncol=2)
xy
plot(xy, col=densCols(xy), xlab="x-axis", ylab="y-axis", main = "X vs Y",
     pch=20, cex=2)
dim(xy)

# 3차원 그래프
x = y = 1:5
f <- outer(x,y) #x%*%t(y)
f # 외적

contour(x,y,f)
image(x,y,f)
persp(x,y,f)

x = y = seq(-pi, pi, length=50)
myfunc = function(x,y) {cos(y)/(1+x^2)}
f = outer(x,y, myfunc)
fa = (f-t(f))/2

contour(x,y,fa)
image(x,y,fa)
persp(x,y,fa)
persp(x,y,fa, theta=20, phi=40) # theta 와 phi로 이미지 각도 조정

# 파일 읽고 쓰기
setwd(readClipboard())
getwd()
auto <- read.table("Auto.data", header = T, na.strings = '?')
head(auto)

dim(auto)
auto <- na.omit(auto)
dim(auto)
write.csv(auto, "Auto_remove_na.csv", row.names = F)

# Scatter plot, Box Plot
plot(auto$cylinders, auto$mpg)
attach(auto)
plot(cylinders, mpg)

mode(cylinders)
cylinders = as.factor(cylinders)
mode(cylinders)
class(cylinders)
plot(cylinders, mpg)

# Histogram
class(auto)
hist(mpg, col = "red", breaks = 15)
pairs(~mpg + displacement + horsepower + weight + acceleration, auto)
detach(auto)

# 단순선형회귀 (Simple Linear Regression)
# 하나의 설명변수 X에 기초하여 양적반응변수 Y를 예측하는 모형
# Y = B0 + B1X + e
# parameter(fixed) : B0 = intercept, B1 = slope
# random : e = error
# e = error의 특징
# mean(e) = 0(선형성), var(e) = sigma^2 (등분산성), 독립성

# training data를 사용하여 B0과 B1을 추정

# 계수 추정(Estimation of coefficients)
# 측정치에 가능한 가깝게 되도록 계수를 추정
# 가까움을 여러 방법으로 측정할 수 있지만, 최소제곱기준이 가장 일반적

# RSS : 잔차제곱합
# RSS = sum(e^2) = sum(yi - (B_hat0 + B_hat1*xi))^2
# Least squares method (최소제곱법) : RSS를 최소호 하는 B_hat0과 B_hat1을 찾음
# RSS를 각각에 대해서 편미분 (풀어보기)
# B_hat1 = sum[(xi - x_bar)*(yi-y_bar)] / sum(xi - x_bar)^2
# B_hat0 = y_bar - B_hat1*x_bar 

# 계수 추론(Inference for coefficients)
# mean(B_hat1) = B1 (비편향성) (풀어보기)
# var(B_hat1) : xi가 넓게 퍼져있을 때 작아짐
# mean(B_hat0) = B0 (비편향성)

# 가설 검정 (Hypothesis Test)
# 귀무가설 H0 : B1 = 0
# 대립가설 H1 : B1 =! 0
# t-tastic, (t = B_hat1 - 0) / SE(B_hat1)
# 귀무가설을 기각하기 위해서는 B_hat1이 0과 충분히 다르고
# SE(B_hat1)이 작아야함
# t통계량의 자유도는 n-2

# p-value : p = P(|t| >= t0)
# p-value가 작다는 것은 B_hat1가 0과 가까운데 우연히 0과 다르게
# 관측될 가능성이 작다는 뜻
# 5%보다 작으면 95% 신뢰수준에서 귀무가설 기각
# 95% 신뢰구간(CI) = [B_hat1 - 1.96*SE(B_hat1), B_hat1 + 1.96*SE(B_hat1)]

# 모델의 정확도 (Accuracy of Model)
# RSE (잔차표준오차) = sqrt( RSS / (n-2))

# R-square 통계량 : R^2 = (TSS - RSS / TSS),
# regression을 통해 설명할 수 있는 Y의 변동 비율

# ISLR 패키지 설치
install.packages("ISLR")
library(MASS)
library(ISLR)
head(Boston)

lm.fit <- lm(medv ~ lstat, data = Boston)
lm.fit
summary(lm.fit)
# 둘다 유의한 변수

names(lm.fit)
lm.fit$coefficients
coef(lm.fit)
confint(lm.fit) # 신뢰구간

predict(lm.fit, data.frame(lstat = c(5,10,15)), interval = 'confidence')
# 선형식의 lstat값을 5, 10, 15로 넣었을 때의 적합값과 신뢰구간
predict(lm.fit, data.frame(lstat = c(5,10,15)), interval = 'prediction')
# 선형식의 lstat값을 5, 10, 15로 넣었을 때의 적합값과 예측구간

attach(Boston)
plot(lstat, medv, pch=20)
abline(lm.fit, lwd=3, col = 'red')

par(mfrow=c(2,2))
plot(lm.fit)

# 다중선형회귀 (Multiple Linear Regression)
# 여러개의 설명변수 x에 기초하여 양적 반응변수 Y를 예측하는 모형
# Y = B0 + B1X1 + B2X2 + ... BpXp + e => Y = XB + e (행렬식)
# e = error, mean(e) = 0 (선형성), var(e) = sigma^2 (등분산성), 독립성
# Y = XB + e (행렬식), Y는 (n X 1), X 는 (n x q), B는 (q x 1), e는 (n x 1)
# Y_hat = B0_hat + B_hat1*X1 ... + B_hatp*Xp => Y_hat = X*B_hat
# X1 = x1, X2 = x2,.... Xp = xp

# Multiple regression 실습
library(MASS)
library(ISLR)
head(Boston)

lm.fit <- lm(medv ~ lstat, data=Boston)
summary(lm.fit)
plot(Boston$lstat, Boston$medv) # 반비례 관계

lm.fit1 <- lm(medv ~ age , data=Boston)
summary(lm.fit1)

lm.fit2 <- lm(medv ~ lstat + age, data=Boston)
summary(lm.fit2)

dim(Boston)
# n-p-1 = 506-2-1 = 503
# n-2 = 506-2 = 504

lm.fit3 <- lm(medv ~ ., data=Boston)
summary(lm.fit3) # n-p-1 = 506-13-1 = 492
# age는 유의하지 않다

lm.fit4 <- lm(medv ~. -age, data=Boston) # age 변수 제외
# (lm.fit4 <- update(lm.fit3, ~. -age))
summary(lm.fit4)

# 계수추정 (Estimation of coefficients)
# 최소제곱법 (Least squares methods)로 추정 가능
# RSS = sum(e^2) = sum(yi - y_hat)^2 = sum(yi - B_hat0 - B_hat1*xi1 - ... B_hatp*xip)^2
# RSS(행렬식) = (Y-Y_hat)^T * (Y-Y_hat) = (Y-XB_hat)^T * (Y-XB_hat)
# RSS(행렬식)을 전개 후 B_hat에 대하여 편미분한 값이 0
# (d/dB_hat) RSS = (d/dB_hat) (Y^T*T - Y^T*X*B_hat - B_hat^T*X^T*Y + B_hat^T*X^T*X*B_hat) = 0
# = -X^T*Y - X^TY + 2X^T*X*B_hat, X^T*X*B_hat = X^T*Y
# B_hat = (X^T*X)^-1 * X^T * Y
# A*B를 B에 대하여 편미분 = > A^T, B^T*A를 편미분 = > A
# B^T*A*B를 편미분 => A*B + A^T*B

# 계추추론 (Inference for coefficiets)
# E(B_hat) = B (비편향성), E(Y) = B
# Cov(B_hat) = Cov((X^T*X)^-1 * X^T * Y) = (X^T*X)^-1 * Cov(Y)*X*(X^T*X)^-1 = (X^T*X)^-1 * sigma^2
# Cov(B_hat) = (X^T*X)^-1 * sigma^2 => (X^T*X)^-1 * sigma_hat^2
# sigma_hat^2는 sigma^2의 추정치, sigma_hat^2 = RSS/(n-p-1)

# 가설검정
# H0 : B1 = ... Bp = 0 vs H1 : not H0
# F = ((TSS-RSS)/p) / (RSS/(n-p-1)) ~ F(p, n-p-1)이 1보다 크면 H0이 참

# H0 : Bp-q+1 = Bp = 0 vs H1 : not H0
# 설명변수 q개와 반응변수의 상관관계를 검정
# F = ((RSS_q - RSS)/q) / (RSS/(n-p-1)) ~ F(q, n-p-1)

# H0 : Bj = 0 vs H1 : not H0 (j=1....,p)
# 설명변수 1개와 반응변수의 상관관계를 검정
# F = ((RSS_1 - RSS)/q) / (RSS/(n-p-1)) ~ F(1, n-p-1)

# 모델의 정확도 (Accuracy of Model)
# RSE (잔차표준오차) = sqrt( RSS / (n-p-1))

# R-square 통계량 : R^2 = (TSS - RSS / TSS),
# regression을 통해 설명할 수 있는 Y의 변동 비율
# R^2 = cor(Y, Y_hat)^2

# 교호작용(interaction terms) = synergistic effects
# interaction term
library(MASS)
library(ISLR)

lm.fit <- lm(medv ~ lstat*age, data = Boston)
# (lm.fit <- lm(medv ~ lstat+age+lstat:age, data = Boston))
summary(lm.fit) # age는 유의하지 않지만, 교호작용항은 유의

# 질적 설명변수 (Qualitative Predictors)
# 범주형 (Ex : 성별, 인종, 혼인여부)
# 범주가 2개(Ex: 성별, 혼인여부)라면 "dummy variable" or "indicator variable"을 1개 생성
# xi를 1과 0 으로 표현 
# 예 : (x1=1 남성, x1=0 여성)
# Y = B0 + B1 + e (남성), Y = B0 + e (여성)

# 범주가 2개보다 많다면 dummy variable을 복수 생성
# 예: xi1 = 1(아시안) or 0(not 아시안), xi2 = 1(코카시안) or 0(not 코카시안)
# Y = B0 + B1 + e (아시안), 
# Y = B0 + B2 + e (코카시안), Y = B0 + e (흑인)

# 상호작용 효과 (Interaction Effects)
# 표준선형모델 Y = B0 + B1x1 + B2x2 + e
# x1이 한 단위 증가하면 Y는 x2와 상관없이 평균 B1 단위만큼 증가

# 상호작용 포함 모델
# Y = B0 + B1x1 + B2x2 + B3x1x2 + e 
# = B0 + (B1+B3x2)x1 + B2x2 + e
# X1의 Y에 대한 효과는 더이상 상수가 아니고 , x2에 따라 변함

# Interaction Effects with qualitative variable

# 비선형 (Non linearity)
# 선형성이 성립하지 않을때(일반 모형의 잔차plot이 U-shape) 
# 제곱항을 추가
# 예 : mpg = B0 + B1x1 + B2(x1)^2 + e

attach(Boston)

lm.fit2 <- lm(medv ~ lstat + lstat^2)
summary(lm.fit2) # 왜 lstat만 표시되는가?
# lstat^2이 설명변수로서 인정받지 못하기 때문

lm.fit2 <- lm(medv ~ lstat +I(lstat^2))
summary(lm.fit2) # 제곱항 까지 모두유의

lm.fit <- lm(medv ~ lstat) ; summary(lm.fit)
anova(lm.fit, lm.fit2) # anova test
# lm.fit2의 t통계량(11.63)의 제곱값이 F(=135.2)값과 비슷하다
# lm.fit2의 lstat^2항의 통계적 유의성을 검정

par(mfrow=c(2,2))
plot(lm.fit)
plot(lm.fit2) # 비교적 평평함, 제곱항이 유의하다.
par(mfrow=c)

# Polynomial regression
lm.fit3 <- lm(medv ~ lstat + I(lstat^2) + I(lstat^3))
# (lm.fit3 <- lm(medv ~ poly(lstat,3))
summary(lm.fit3)

# 오차항의 비독립성 (Dependence of Errors)
# 오차항 사이에 상관성(Correlation)이 있을 경우
# 추정 표준오차는 실제 표준 오차보다 과소추정됨. 왜?
# RSE = sqrt(RSS/(n-p-1))에서 p는 모델의 parameter value
# 오차에 상관성이 있게되면, 오차항간의 독립성 가정이성립안됨
# 따라서 p가 실제 입력되어야 할 값보다 더 커짐 => RSS는 감소
# t계량 값은 RSS가 감소됨에 따라 증가 => p-value는감소 => 판단의 오류발생

# 비등분산성 (Non-constant variance of Errors)
# 등분산 가정 : var(e) = sigma^2
# 잔차 그래프에서 깔대기 모양 => 등분산 가정 문제
# log변환 (log Y or log sqrt(Y)) 혹은
# 가중최소제곱법 사용 : RSS = sum( wi*(Yi-yhat_i)^2), wi=1/(sigma_i)^2

# 이상치 (Outliers)
# 잘못 기재, 오류로 판단되면 제외 (산점도를 보고 판단)
# MSE나 R^2에 영향을 줌으로 제거 필요

# 레버리지 높은 관측치 (High Leverage Points)
# 설명변수값에 대한 반응변수값의 수준이 다른 관측치
# X값이 유독 벗어난 것
# 이상치에 비해 영향이 더 큼
# leverage statistics = hi = (1/n) + (xi-xbar)^2 / sum(xi-xbar)^2
# hi > (P+1) / n이면 high leverage

# 공선성 (Colinearity)
# 두 개 이상의 설명변수들이 서로 밀접
# VIF를 계산 : VIF(Bhat_j) = 1 / [1-(R^2_i|j)]
# 여기서 R^2는 선형성이 있을 것으로 예상되는 설명변수들 간의
# 선형모형에 대한 R^2
# 따라서 두 설명변수간 공선성이 있다면
# [1-(R^2_i|j)]는 작아지고, VIF는 증가할 것 (5 or 10 초과시 문제)

# K-최근접 이웃 (K-Nearest Neighbors)
# f_hat(x0) = (1/K) * sum(yi)
# 주어진 K값과 예측점 x0에 대해 가장 가까운 K개의
# training observation N0을 찾아 연관된 반응변수의 평균을 구해
# f(x0)을 추정
# K가 커질수록 MSE가 작아짐. 하지만 회귀모형보다는 error가 큼

# Non-linear인 경우에는 KNN이 작아지면 회귀모형보다 MSE가 작아지는 구간이 존재
# Highly Non-linear인 경우 KNN이 회귀모형보다 MSE가 작음

# Curse of dimensionality (차원의 저주)
# 하지만 p(설명변수)가 많을 수록 KNN이 회귀모형보다 MSE가 커짐 
# 설명변수당 관측치 수가 작으면 모수적 방법이 더 나은 결과 제공

# 로지스틱 회귀 (Logistic Regression)
# 반응변수가 질적변수(범주형, 이산형)
# P(X) = Pr(Y=1 | X), 반응변수 P(X)의 범위가 0과 1사이
# P(X) = e^(B0+B1X) / 1+e^(B0+B1X) (logistic function)
# => P(Y=1|X) / P(Y=0|X) = P(X) / (1-P(X)) = e^(B0+B1X) 
# 실패확률 대비 성공의 비율(오즈)가 exponential의 형태
# => (B0+B1X) = log(P(X) / (1-P(X))) 로그오즈(로짓)

### B1은 무슨의미? 
### X가 한 단위증가함에 따라 B1만큼 로그오즈가 증가 (오즈는 e^B1만큼 증가)

# 가능도 함수 (Likelihood function)
# P(X)는 B0과 B1에 대한 가능도 함수
# 가능도 함수 p(X)가 최대가 되게하는 B0과 B1이 MLE이다.

# 다중 로지스틱 회귀 (Multiple Logistic Regreession)
# P(X) = e^(B0 + B1X1+...BPXP)
# 원리와 방식은 단순 로지스틱 회귀와 동일

# Compounding Effect 
# 설명변수들이 서로 연관되어 있고, 하나의 설명변수를 사용하여 얻은 결과와
# 여러 설명 변수를 사용하여 얻은 결과가 다를 경우
# Ex) 단순회귀로 검정했을 때는 유의, but 다중회귀에서는 유의X

# 베이즈 정리 (Bayes' Theorem)
# 조건부 정리 = P(B|A) = P(B n A) / P(A)
# P(B n A) = P(A) * P(B|A)
# Posterior(사후확률) = P_k(X) = Pr(Y=K|X=x)
# [P(Y=k) * P(X=k | Y=k)] / [sum(P(Y=l) * P(X=x|Y=l))]
# [pi_k * f_k(x)] / [sum(pi_l * f_l(x))]
# Prior(사전확률) pi_k= Pr(Y=k)  
# 사후확률을 사전확률의 곱으로 표현 

# 선형판별분석 LDA (설명변수개수 p=1)
# 설명변수는 1개지만, 그룹은 K개
# f_k(x) = (X=k | Y=k) (density function of X)
# 설명변수의 정규분포 가정, X ~ N(mu_k, sigma^2_k)
# K개 그룹의 분산은 모두 동일 (sigma^2 = sigma^2_1 = sigma^2_2.... sigma^2_k)
# P_k(x) = 베이즈 정리식에 따른 식, 베이즈 분류기(Bayes Classifier)
# 분모는 모든 클래스(K)에서 동일
# 결정함수 delta_k(X) = log P_k(X) = log pi_k + log f_k(x)
# = x*(mu_k / sigma^2) - (mu^2_k / 2*sigma^2) + log pi_k
# = p=1일 경우의 분류식, x에 대하여 1차선형식, why? 공통분산가정 

# 베이즈 결정경계 (Bayes decision boundary)
# if K=2, pi_1 = pi_2, 베이즈 분류식은 2x(mu_1 - mu_2) > (mu^2_1 - mu^2_2)인 경우
# 관측치를 class1에 할당, 그렇지 않으면 class2를 할당
# Bayes decison boundary is x = (mu_1 + mu_2) / 2
# 이론적인 가정하에 있는 경계
# LDA & QDA boundary는 관측값에 근거한 경계

# 실제의 경우 분산(sigma^2)과 평균(mu_1, ... mu_k), 사전확률(pi_1,... pi_K)에 대한 추정 필요 
# pihat_k = n_k / n, muhat_k = sum(xi)/n_k, sigma^2
# 추정치를 delta_k(X)식에 대입 => delta^hat_k(X)

# LDA (p > 1)
# multivariate normal distribution
# SIGMA = pxp Covariance matrix(공분산행렬), 모든 클래스 (K)에 동일
# delta_k(X) = x^T * SIGMA^-1 * mu_k - (1/2)*mu^T_k * SIGMA^-1 * mu_k + log(mu_k)

# 이차 선형판별분석 QDA (P > 1)
# multivariate normal distribution 가정
# 각 클래스의 공분산행렬이 다름 (공통분산가정X)
# delta_k(X) = (-1/2)*(x-mu_k)^T * (SIGMA_k)^-1 *(x-mu_k) - (1/2)*(log|SIGMA_k|)+log pi_k
# x의 이차식으로 표현이 되기에 Qudratic, 곡선으로 표현
# 공통 공분산행렬을 추정하기 위해서는 p(p+1)/2개의 parameter 추정해야함
# 하지만 각기 다른 공분산행렬을 추정하기 위해서는 k*p(p+1)의 parameter를 추정해야함

# 공분산행렬이 같을경우, LDA is better
# 공분산행렬이 다른경우, QDA is better

# 혼동행렬 (Confusion Matrix)
# Default data, n = 10000, LDA training error rate = 2.75%

cm <- matrix(c("TP", "FN", "FP", "TN"), 2,2)
colnames(cm) = c("True Yes", "True No") ; rownames(cm) = c("Predict Yes", "Predict No") ; cm
# P* = TP + FN, N* = FP + TN
# 정확도(Accuracy) = (TP + TN) / (TP + FP + FN + TN)
# 정밀도(Precision) = TP / (TP + FP), 재현율(Recall) = TP / (TP + FN)
# F1 score = 2 / [(1/정밀도) + (1/재현율)]
# TPR(민감도, Sensitivity) = TP / P*, TNR(특이도, Specificity) = TN / N*
# FPR(1종오류) = FP / N*, FNR(2종오류) = FN / P*

# 대부분의 문제에서 Positive를 맞추는 것에 관심(Negative를 맞추는 것은 큰 관심X)
# 민감도를 높이기 위해 Positive판정 기준을 낮춤 -> 특이도는 소폭 감소

# ROC커브 (세로축 : 민감도, 가로축 : 1 - 특이도(= 1종오류))
# ROC곡선 아래 면적 = AUC
# AUC가 클수록 좋은 분류기 
# AUC = 0.5는 랜덤, 0.7보다 크면 양호, 0.8보다 크면 좋음

# 분류기의 비교 : 로지스틱, LDA, QDA, KNN
# 로지스틱 : 가장 모수적 방법
# LDA, QDQ : 설명변수 x에 대한 분포 가정
# KNN : 비모수적 방법

# 로지스틱 vs LDA (K=2, p=1)
# p1(x), p2(x) (= 1-p1(x)) : 관측치 X가 클래스 1로 분류될지, 2로 분류될지의 확률
# 로지스틱 log(p1/ (1-p1)) = B0 + B1x, (p1 = P(Y=1 | X))
# LDA : log(p1(x) / (1-p1(x))) = log(p1(x) / p2(x)) = c0 + c1x (x에 대한 선형식)
# 따라서 로지스틱과 LDA모두 선형 결정경계를 만듦
# B0, B1은 MLE를 통해 추정, c0, c1은 정규분포에서 추정된 평균,분산으로 계산
# 각 클래스가 공통분산을 가지면(등분산성) LDA가 우수
# 설명변수가 가우시안 가정을 만족하지 않으면 로지스틱이 우수

# KNN vs 로지스틱 or LDA
# KNN은 비모수적방법
# 결정경계가 highly non-linear (복잡하거나(유연), 꼬물꼬물거림)하면 KNN이 우수
# KNN은 해석이 어렵다

# QDA vs 나머지
# 비모수적 방법(KNN)과 LDA/로지스틱 방법 사이 절충, why? QDA는 결정경계가 곡선형태
# QDA는 KNN만큼 유연하지 않지만, 훈련관측값이 적을경우 KNN보다 우수

# Smarket 데이터
install.packages("ISLR")
library(ISLR)
attach(Smarket)
head(Smarket) # Direction이 반응변수
plot(Volume, col="blue", pch=16)
# 연도가 증가할수록 증가

# Logistic Regression
glm.fit <- glm(Direction ~ Lag1 + Lag2 + Lag3 + Lag4 + Lag5 + Volume,
               data = Smarket, family = binomial(link="logit"))
# binomial => (link = "logit")
# gaussian => (link = "identity")
# Gamma => (link = "inverse")
# poisson => (link = "log")

summary(glm.fit)
# 계수들이 전체적으로 유의하지 않음
contrasts(Direction) # Up = 1, Down = 0
glm.probs <- predict(glm.fit, type="response") 
# 로지스틱 모형의 적합값, P(Y=1|X), Up의 오즈
length(glm.probs) # 1250
glm.pred <- rep("Down", 1250)
glm.pred[glm.probs>0.5] <-"UP"
table(glm.pred, Direction) # 혼동행렬
mean(glm.pred == Direction)

(정확도 <- (507 + 145) / 1250)
(오류율 <- 1-정확도)
# 임의추측 (0.5)보다 좋은 수준

# Fit logistic regression using training data
train <- (Year < 2005)
# Smarket중 Year<2005를 만족하는 것만 TRUE로 표시

test <- !train
Smarket.2005 <- Smarket[test,]
Direction.2005 <- Direction[test]
head(Smarket.2005)
# test데이터 정의

glm.fit1 <- glm(Direction ~ Lag1 + Lag2 + Lag3 + Lag4 + Lag5 + Volume,
               data = Smarket[train,], family = binomial)
# (glm.fit1 <- glm(Direction ~ Lag1 + Lag2 + Lag3 + Lag4 + Lag5 + Volume,
#                  data = Smarket, family = binomial, subset=train))
# train데이터로 적합

glm.probs1 <- predict(glm.fit1, newdata=Smarket.2005, type = 'response')
glm.probs1
# tain (2005년 이전)데이터로 적합한 모형식으로, 2005년도 예측   

dim(Smarket.2005)
# 252
glm.pred1 <- rep("Down", 252) 
glm.pred1[glm.probs1 > 0.5] <- "Up" ; glm.pred1
table(glm.pred1, Direction.2005)
mean(glm.pred1 == Direction.2005)
# 실제 2005년 데이터와 일치할 확률
# 임의추측보다 좋지 않음, train과 test가 다르기 때문
# 하지만 정확한 추정방법임

# Lag1과 Lag2만 사용한 training data
glm.fit2 <- glm(Direction ~ Lag1 + Lag2, data = Smarket, family = binomial,
                subset = train)
glm.probs2 <- predict(glm.fit2, newdata = Smarket.2005, type = 'response')
glm.pred2 <- rep("Down", 252)
glm.pred2[glm.probs > 0.5] <- "Up"
table(glm.pred2, Direction.2005)
mean(glm.pred2 == Direction.2005)

# LDA using training data
library(MASS)
lda.fit <- lda(Direction ~ Lag1 + Lag2, data=Smarket, subset=train)
lda.fit
# pi1 = 0.491987, pi2 = 0.508016
# 전날 수익률(Lag1, Lag2)이 양수이면 다음날 Down
# 전날 수익률이 음수이면 다음날 Up
# (주가 상승전 이틀동안은 수익률이 음수)
# (주가 하락전 이틀동안은 수익률이 양수)
# f = -0.6420*Lag1 - 005135*Lag2 + 상수

lda.pred <- predict(lda.fit, newdata = Smarket.2005)
lda.pred$class
table(lda.pred$class, Direction.2005)
mean(lda.pred$class == Direction.2005)

# QDA using training data
qda.fit <- qda(Direction ~ Lag1 + Lag2, data = Smarket, subset=train)
qda.fit

qda.pred <- predict(qda.fit, newdata = Smarket.2005)
table(qda.pred$class, Direction.2005)
mean(qda.pred$class == Direction.2005)

# KNN using training data
library(class)
trainX <- cbind(Lag1, Lag2)[train,]
testX <- cbind(Lag1, Lag2)[test,]
trainY <- Direction[train]

knn.pred <- knn(trainX, testX, trainY, k = 3)
table(knn.pred, Direction.2005)
mean(knn.pred == Direction.2005)

detach(Smarket)

# (1) Validation Set Approach
library(ISLR)
attach(Auto)
head(Auto)
dim(Auto)

set.seed(1)
train <- sort(sample(1:392, 196)) ; train
test<- setdiff(1:392, train) ; test

lm.fit1 <- lm(mpg ~ horsepower, subset=train)
summary(lm.fit1)
testY <- predict(lm.fit1, newdata = Auto[test,])
mean((mpg[test]-testY)^2)

lm.fit2 <- lm(mpg ~ poly(horsepower, 2), subset=train)
summary(lm.fit2)
testY <- predict(lm.fit2, newdata = Auto[test,])
mean((mpg[test]-testY)^2)

lm.fit3 <- lm(mpg ~ poly(horsepower, 3), subset=train)
summary(lm.fit3)
testY <- predict(lm.fit3, newdata = Auto[test,])
mean((mpg[test]-testY)^2)
# 모형이 제곱항 (lm.fit2)일때 MSE가 낮음

# (2) LOOCV
library(boot)

glm.fit <- glm(mpg ~ horsepower)
coef(glm.fit)
 
(cv.err <- cv.glm(Auto, glm.fit))
cv.err$delta[1]

cv.error <- rep(0,5)
for (i in 1:5) {
  glm.fit <- glm(mpg ~ poly(horsepower, i), data=Auto)
  cv.error[i] <- cv.glm(Auto, glm.fit)$delta[1]
}
cv.error

# (3) K-fold CV
set.seed(20)
k <- 10
cv.error <- rep(0,k)
for (i in 1:k) {
  glm.fit <- glm(mpg ~ poly(horsepower, i), data=Auto)
  cv.error[i] <- cv.glm(Auto, glm.fit, K=k)$delta[1]
}
cv.error
detach(Auto)

# (4) Bootstrap
library(boot)
library(ISLR)

head(Portfolio)
dim(Portfolio)

alpha.fn <- function(data, index) {
  x <- data$X[index]
  y <- data$Y[index]
  res <- (var(y)-cov(x,y))/(var(x)+var(y)-2*cov(x,y))
  return(res)
}
alpha.fn(Portfolio, 1:100)

length(unique(sort(sample(1:100, 100, replace=T))))
set.seed(2)
alpha.fn(Portfolio, sample(1:100, 100, replace=T))

boot(Portfolio, alpha.fn, R=1000)
# a_hat = 0.84, SE(a_hat) = 0.09

# (5) accuracy of linear regression model
boot.fn <- function(data, index) {
  res <- coef(lm(mpg~horsepower, data=data, subset=index))
  return(res)
}

dim(Auto)
boot.fn(Auto, 1:392)
boot.fn(Auto, sample(1:392, 392, replace=T))
       
boot(Auto, boot.fn, 1000)  
summary(lm(mpg~horsepower, data=Auto))$coef
# Bootstrap의 표준오차 결과값이 더 큼

boot.fn1 <- function(data, index) {
  res <- coef(lm(mpg~horsepower+I(horsepower^2), data=data, subset=index))
  return(res)
}
boot.fn1(Auto, 1:392)
boot.fn1(Auto, sample(1:392, 392, replace=T))
boot(Auto, boot.fn1, 1000)  
summary(lm(mpg~horsepower+I(horsepower^2), data=Auto))$coef

# (1) Classification tree using training data
install.packages("tree")
library(tree)
library(ISLR)
attach(Carseats)
str(Carseats)
head(Carseats)
quantile(Sales)
High <- as.factor(ifelse(Sales <=8, "No", "Yes"))
# 범주형 번수 High 추가
table(High)
Carseats <- data.frame(Carseats, High)
head(Carseats)
str(Carseats) ; head(Carseats)
tree.carseats <- tree(High~. -Sales, Carseats)
summary(tree.carseats)
# 가지가 27개 
plot(tree.carseats)
text(tree.carseats, pretty=0)

# (2) Classification tree using test error rate
set.seed(3)
train <- sort(sample(1:400, 200))
length(unique(train))
test <- setdiff(1:400, train)

High.test <- High[test]
Carseats.test <- Carseats[test,]
length(High.test) ; dim(Carseats.test)

tree.carseats <- tree(High~. -Sales, Carseats, subset=train)
summary(tree.carseats)
plot(tree.carseats)
tree.pred <- predict(tree.carseats, Carseats.test, type="class")
table(tree.pred, High.test)
mean(tree.pred == High.test)

# (3) CV + pruning for classification tree
set.seed(6)
cv.carseats <- cv.tree(tree.carseats, FUN=prune.misclass)
class(cv.carseats) ; names(cv.carseats)
cv.carseats                       
# dev(error)가 가장 작은 k(penalty)=4, size(가지)=5

prune.carseats <- prune.misclass(tree.carseats, best=5)
plot(prune.carseats)
text(prune.carseats, pretty=0, cex=0.8)
tree.prune <- predict(prune.carseats, Carseats.test, type="class")
table(tree.prune, High.test)
mean(tree.prune == High.test)

# (4) Regreession tree using training data
library(MASS)
set.seed(1)
head(Boston)
train <- sort(sample(1:nrow(Boston), nrow(Boston)/2))
test <- setdiff(1:nrow(Boston), train)
tree.boston <- tree(medv ~., Boston, subset = train)
summary(tree.boston)
plot(tree.boston)
text(tree.boston, pretty = 0, cex=0.8)

# (5) CV + pruning for Regression Tree
cv.boston <- cv.tree(tree.boston)
# cv.tree 는 10 folds CV가 디폴트 값
cv.boston
# dev가 최소가 되는 size=8, k =-Inf
prune.boston <- prune.tree(tree.boston, best = 8)
plot(prune.boston)
text(prune.boston, pretty =0, cex = 0.8)

yhat <- predict(tree.boston, Boston[test,])
y <- Boston[test,]$medv
length(yhat) ; length(y)
plot(yhat, y) ; abline(0,1)
(mse.test <- mean((yhat-y)^2))

# (6) Bagging
install.packages("randomForest")
library(randomForest)
dim(Boston)

set.seed(2)
train <- sort(sample(1:nrow(Boston), nrow(Boston)/2))
test <- setdiff(1:nrow(Boston), train)
Boston$rad <- factor(Boston$rad)
bag.boston <- randomForest(medv~., data=Boston, subset=train,
                           mtry=13, importance=T, ntree=100)
# mtyr= 13 = 14-1 (Boston의 차원)
bag.boston

y <- Boston[test,]$medv
yhat.bag <- predict(bag.boston, newdata=Boston[test,])
plot(yhat.bag, y)
abline(0,1, col='red')
mean((yhat.bag-y)^2)

importance(bag.boston)
varImpPlot(bag.boston)

# (7) Random Forests
set.seed(1)
rf.boston <- randomForest(medv~., data = Boston, subset=train,
                          mtry=6, importance=T)
yhat.rf <- predict(rf.boston, Boston[test,])
mean((y-yhat.rf)^2)

plot(yhat.rf, y)
abline(0,1, col='red')

importance(rf.boston)
varImpPlot(rf.boston)
# 배깅과 랜덤포레스트의 차이는 사용파라미터의 전체 혹은 부분

# (8) Boosting
install.packages("gbm")
library(gbm)
set.seed(1)
boost.boston <- gbm(medv~., Boston[train,], distribution="gaussian",
                    n.trees=5000, interaction.depth = 1,
                    shrinkage=0.05)
yhat.boost <- predict(boost.boston, Boston[test,], n.trees = 5000)
mean((yhat.boost-y)^2)

# 시뮬레이션 데이터 생성
# training data
set.seed(1)
x <- matrix(rnorm(20*2), ncol=2)
y <- c(rep(-1,10), rep(1,10)) ; y
x[y==1,] <- x[y==1]+1
plot(x, col=(3-y), pch=16) # y=1 2="red", y= -1 4="blue"
dat <- data.frame(x=x, y=as.factor(y))
head(dat)

# test data 생성
xtest <- matrix(rnorm(2*20), ncol=2)
ytest <- sample(c(-1,1),20, rep=T)
xtest[ytest==1,] <- xtest[ytest==1,]+1
testdat <- data.frame(x=xtest, y=as.factor(ytest))
head(testdat)

# Support vector classifier
install.packages("e1017")
library(e1071)
svmfit <- svm(y~., data=dat, kernel = "linear", cost=10, scale = F)
plot(svmfit, dat)
svmfit$index

svmfit2 <- svm(y~., data=dat, kernel = "linear", cost=0.1, scale = F)
plot(svmfit2, dat)
svmfit2$index

# 10-fold CV
set.seed(1)
tune.out <- tune(svm, y ~., data=dat, kernel="linear", 
     ranges=list(cost=c(0.001,0.01,0.1,1,5,10,100)))
tune.out
summary(tune.out)
(bestmod <- tune.out$best.model)

ypred <- predict(bestmod, newdata = testdat)
table(ypred, testdat$y)

# Support vector machine (non-linear)
# generate data
set.seed(1)
x <- matrix(rnorm(200*2), ncol=2)
x[1:100,] <- x[1:100,]+2
x[101:150,] <- x[101:150,]-2
y <- c(rep(1,150), rep(2,50))

dat1 <- data.frame(x=x, y=as.factor(y))
head(dat1)
plot(x, col=y+1, pch=16) # y=1 -> col=2, y=2 -> col=3

# fit SVM with radial kernel
train <- sort(sample(200,100))
test <- setdiff(1:200, train)

svmfit3 <- svm(y ~., data=dat1[train,], kernel="radial",
               gamma=1, cost=1)
summary(svmfit3)
plot(svmfit3, dat1[train,])
# cost값이 커지면 마진이 줄어듬 -> SV 감소
# gamma값이 증가하면 -> SV 증가

# 10-fold CV
set.seed(1)
tune.out <- tune(svm, y~., data=dat1[train,], kernel="radial",
     ranges=list(cost=c(0.1,1,10,100,1000), gamma=c(0.5,1,2,3,4)))
tune.out
summary(tune.out)
test1y <- dat1[test,]$y
pred1y <- predict(tune.out$best.model, newx = dat1[test,])
pred1y
table(test1y, pred1y)

svm.fit <- svm(y ~., data=dat1[train,], kernel = "radial",
               gamma=1, cost=1, decision.values=T)
fitted=attributes(predict(svm.fit, newdata = dat1[test,],decision.values=TRUE))$decision.values

# SVM with multiple classes
set.seed(1)
x <- rbind(x, matrix(rnorm(50*2),ncol=2))
dim(x)
y <- c(y,rep(0,50))
x[y==0,2] = x[y==0,2]+2
dat2 <- data.frame(x=x, y=as.factor(y))
head(dat2)
plot(x, col=(y+1), pch=16)

svmfit4 <- svm(y ~., data=dat2, kernel="radial",
               cost=10, gamma=1)
plot(svmfit4, dat2)
summary(svmfit4)

# Linear model Selection
# Best Subset Selection
library(ISLR)
head(Hitters)
dim(Hitters)
sum(is.na(Hitters))
Hitters <- na.omit(Hitters) ; dim(Hitters) # 결측값 처리 

install.packages("leaps")
library(leaps)
regfit.full <- regsubsets(Salary ~., Hitters, nvmax=19)
(res <- summary(regfit.full))

names(res)
res$rsq
res$bic

plot(res$rss, xlab = "Num of variables", ylab = "RSS", type='l')
plot(res$adjr2, xlab = "Num of variables", ylab = "RSS", type='l')
which.max(res$adjr2)
points(11, res$adjr2[11], col="red", cex=2, pch=20)
# adjusted R^2는 k값이 어느정도 이상 커지면, 감소함 

plot(res$cp, xlab = "Num of variables", ylab = "RSS", type='l')
which.min(res$cp)
points(10, res$cp[10], col="red", cex=2, pch=20)

plot(res$bic, xlab = "Num of variables", ylab = "RSS", type='l')
which.min(res$bic)
points(6, res$bic[6], col="red", cex=2, pch=20)

# (2) Forward and Backward stepwise selection
regfit.fwd <- regsubsets(Salary ~., Hitters, nvmax = 19, 
                         method = "forward")
summary(regfit.fwd)

regfit.bwd <- regsubsets(Salary ~., Hitters, nvmax = 19,
                         method = "backward")
summary(regfit.bwd)

coef(regfit.full, 7)
coef(regfit.fwd, 7)
coef(regfit.bwd, 7)

# (3) Model selection using validation set approach
set.seed(1)
dim(Hitters)
train <- sort(sample(1:nrow(Hitters), 132))
test <- setdiff(1:nrow(Hitters), train)

regfit.best <- regsubsets(Salary ~., Hitters[train,], nvmax = 19)
summary(regfit.best)
test.mat <- model.matrix(Salary ~., Hitters[test,])
dim(test.mat)
head(test.mat)
val.error <- rep(NA, 19)

for (i in 1:19) {
  coefi <- coef(regfit.best, id=i)
  pred <- test.mat[, names(coefi)] %*% coefi
  val.error[i] <- mean((Hitters$Salary[test]-pred)^2)
}
val.error
which.min(val.error)

regfit.best <- regsubsets(Salary ~., Hitters, nvmax = 19)
coef(regfit.best, id = 8)

# (4) Model selection using k-fold cv
k <- 10
set.seed(1)
folds <- sample(1:k, nrow(Hitters), replace = T)
table(folds)

cv.errors <- matrix(NA, k, 19, dimnames = list(NULL, paste(1:19)))
head(cv.errors)

for (j in 1:k) {
  best.fit <- regsubsets(Salary ~., data = Hitters[folds != j,], 
                         nvmax = 19)
  test.mat <- model.matrix(Salary ~., Hitters[folds == j,])
  for (i in 1:19) {
    coefi <- coef(best.fit, id = i)
    pred <- test.mat[, names(coefi)] %*% coefi
    cv.errors[j, i] <- mean((Hitters$Salary[folds ==j]-pred)^2)
    
  }
}
mean.cv.errors <- apply(cv.errors, 2, mean)
mean.cv.errors
plot(mean.cv.errors, type = "b")
which.min(mean.cv.errors)

reg.best <- regsubsets(Salary ~., Hitters, nvmax = 19)
coef(regfit.best, id=11)

# (5) Ridge Regression
install.packages("glmnet")
library(glmnet)

x <- model.matrix(Salary ~., Hitters)[,-1]
y <- Hitters$Salary
head(x) ; head(y)

ridge.mod <- glmnet(x, y, alpha = 0, lambda = 10^seq(10, -2, length =100))
#0을쓰면 릿지, 1을쓰면 라쏘
dim(coef(ridge.mod))
coef(ridge.mod)                    
ridge.mod$lambda[50]
coef(ridge.mod)[,50]

set.seed(1)
train <- sort(sample(1:nrow(Hitters), 132))
test <- setdiff(1:nrow(Hitters), train)

y.test <- y[test]
ridge.mod <- glmnet(x[train,], y[train], alpha = 0, lambda = 10^seq(10, -2, length = 100))
plot(ridge.mod)
ridge.pred <- predict(ridge.mod, s = 4 # s= lambda
                      , newx = x[test,])
mean((ridge.pred - y.test)^2)

# Select the best lambda using K-fold cv
set.seed(1)
cv.out <- cv.glmnet(x[train,], y[train], alpha = 0)
plot(cv.out)
best.lambda <- cv.out$lambda.min
best.lambda
ridge.pred <- predict(ridge.mod, s=best.lambda, newx=x[test,])
mean((ridge.pred - y.test)^2)

out <- glmnet(x,y, alpha = 0)
predict(out,type = "coefficients", s= best.lambda)

# (6) Lasso
lasso.mod <- glmnet(x[train,], y[train], alpha = 1, lamgbda = 10^seq(10, -2, length = 100))
plot(lasso.mod)

set.seed(1)
cv.out <- cv.glmnet(x[train,], y[train], alpha = 1)
plot(cv.out)

best.lambda <- cv.out$lambda.min
log(best.lambda)

lasso.pred <- predict(lasso.mod, s=best.lambda, newx = x[test,])
mean((lasso.pred - y[test])^2)

out <- glmnet(x,y, alpha = 1)
coef.lasso <- predict(out, type = "coefficients", s=best.lambda)
coef.lasso[coef.lasso != 0]

# (7) PCR
install.packages("pls")
library(pls)

# Fit PCR with all data
set.seed(2)
pcr.fit <- pcr(Salary ~., data = Hitters, scale = T, vialidaton = "CV")
pcr.fit
summary(pcr.fit)
validationplot(pcr.fit, val.type = "MSEP")

# Fit PCR with training / test data
set.seed(1)
pcr.fit <- pcr(Salary ~., data = Hitters, subset = train, scale = T,
               validation = "CV")
validationplot(pcr.fit, val.type = "MSEP")
summary(pcr.fit)
pcr.pred <- predict(pcr.fit, newdata = x[test,], ncomp = 6)
mean((pcr.pred - y.test)^2)

pcr.fit <- pcr(y ~ x, scale = T, ncomp = 6)
summary(pcr.fit)

# (8) Partial least Squares (PLS)
library(pls)

set.seed(1)
pls.fit <- plsr(Salary ~., data = Hitters, subset = train, scale = T,
                validation = "CV")
summary(pls.fit)
validationplot(pls.fit, val.type= "MSEP")

pls.pred <- predict(pls.fit, x[test,], ncomp = 7)
mean((pls.pred - y.test)^2)

pls.fit <- plsr(Salary ~., data = Hitters, scale = T, ncomp = 7)
summary(pls.fit)

# Non-Linear Models

# (1) Polynomial Regression and Step function
library(ISLR)
attach(Wage)

plot(age, wage)
fit <- lm(wage ~ age, data = Wage)
coef(summary(fit))

fit <- lm(wage ~ poly(age, 4), data = Wage)
coef(summary(fit))

fit1 <- lm(wage ~ poly(age, 4, raw = T), data = Wage)
coef(summary(fit1))
# poly(age, 4, raw =T)는 아래와 동일
fit2a <- lm(wage ~ age + I(age^2) + I(age^3) + I(age^4), data = Wage)
summary(fit2a)

head(poly(age, 4)) # 직교 형태
head(poly(age, 4, raw = T)) # Polynomial

# make plot for degree = 4 polynomial regression
(agelims <- range(age))
(age.grid <- seq(agelims[1], agelims[2]))
preds <- predict(fit, newdata = list(age = age.grid), se=T)
head(preds)
se.bands <- cbind(preds$fit + 2*preds$se.fit, preds$fit - 2*preds$se.fit)
se.bands # 95% CI

plot(age, wage, xlim = agelims, cex = 0.5, col = "dark grey", main = "Polynomial Regression")
lines(age.grid, preds$fit, lwd=2, col="blue")
lines(age.grid, se.bands[,1], lwd = 1, col = "blue", lty = 3)
lines(age.grid, se.bands[,2], lwd = 1, col = "blue", lty = 3)

# Select the degree of the polynomial regression
fit.1 <- lm(wage ~ age, data = Wage)
fit.2 <- lm(wage ~ poly(age, 2), data = Wage)
fit.3 <- lm(wage ~ poly(age, 3), data = Wage)
fit.4 <- lm(wage ~ poly(age, 4), data = Wage)
fit.5 <- lm(wage ~ poly(age, 5), data = Wage)

anova(fit.1, fit.2, fit.3, fit.4, fit.5)
summary(fit.5) # 3차 제곱항까지 유의함

# degree = 4 logistic regression
fit <- glm(I(wage > 250) ~ poly(age, 4), data = Wage, family = binomial)
summary(fit)
preds <- predict(fit, newdata = list(age = age.grid), se = T)
pfit <- exp(preds$fit) / (1 + exp(preds$fit)) # 적합값
head(pfit)
# preds <- predict(fit, newdata = list(age = age.grid), se = T, type = "response")
# head(preds)

se.bands.logit <- cbind(preds$fit + 2*preds$se.fit, preds$fit - 2*preds$se.fit)
se.bands <- exp(se.bands.logit) / (1 + exp(se.bands.logit))
head(se.bands) # 95% CI

plot(age, I(wage>250), xlim = agelims, type = "n", ylim= c(0,0.2))
points(jitter(age), I(wage>250)/5, cex = 0.5, pch = "l", col = "dark grey")
lines(age.grid, pfit, lwd = 2, col = "blue")
lines(age.grid, se.bands[,1], lwd = 2, col = "blue", lty = 3)
lines(age.grid, se.bands[,2], lwd = 2, col = "blue", lty = 3) # 95% CI

# step function
table(cut(age, 4))
fit1 <- lm(wage ~ cut(age, 4), data = Wage)
summary(fit1)

# (2) Splines

# Regresison splines
install.packages("splines")
library(splines)
fit <- lm(wage ~ bs(age, knots = c(25, 40, 60)), data = Wage)
summary(fit)
pred <- predict(fit, newdata = list(age = age.grid), se = T)
plot(age, wage, col = "grey")
lines(age.grid, pred$fit, lwd = 3, col = "blue")
lines(age.grid, pred$fit + 2*pred$se.fit, lwd = 2, col = "blue", lty = 3)
lines(age.grid, pred$fit - 2*pred$se.fit, lwd = 2, col = "blue", lty = 3)

# natural Splines
fit2 <- lm(wage ~ ns(age, df = 4), data = Wage)
summary(fit2)
pred2 <- predict(fit2, newdata = list(age = age.grid), se = T)
lines(age.grid, pred2$fit, lwd = 2, col = "red")
 
# Smoothing Splines
plot(age, wage, xlim = agelims, cex = 0.5, col = "darkgrey", main = "Smoothing Splines")
fit <- smooth.spline(age, wage , df = 16)
fit2 <- smooth.spline(age, wage, cv = T)
fit2$df ; fit$df

lines(fit, col = "red", lwd = 2)
lines(fit2, col = "blue", lwd = 2)
legend("topright", legend =c("df = 16", "df = 6.8"), col = c("red", "blue"),
                             lty = 1, lwd = 2)

# local regression
plot(age, wage, xlim = agelims, cex = 0.5, col = "darkgrey", main = "Local Splines")
fit <- loess(wage ~ age, span = 0.2, data = Wage)
fit2 <- loess(wage ~ age, span = 0.5, data = Wage)
pred <- predict(fit, newdata = data.frame(age = age.grid))
pred2 <- predict(fit2, newdata = data.frame(age = age.grid))
lines(age.grid, pred, col = "blue", lwd = 2)
lines(age.grid, pred2, col = "red", lwd = 2)
legend("topright", legend = c("Span = 0.2", "Span = 0.5"),
       col = c("blue", "red"), lwd = 2)

# (3) GAM
install.packages("gam")
library(gam)

# fit Splines
gam1 <- lm(wage ~ ns(year, df = 4) + ns(age, df =5) + education, data = Wage)
summary(gam1)

gam.m3 <- gam(wage ~ s(year, df = 4) + s(age, df =5) + education, data = Wage)
summary(gam.m3)

par(mfrow = c(1,3))
plot(gam.m3, se = T, col = "blue")

gam.m1 <- gam(wage ~ s(age, 5) + education, data = Wage)
gam.m2 <- gam(wage ~ year + s(age, 5) + education, data = Wage)
gam.m3 <- gam(wage ~ s(year, 4) + s(age, 5) + education, data = Wage)

anova(gam.m1, gam.m2, gam.m3)
summary(gam.m3)

# use local regression
gam.lo <- gam(wage ~ s(year, 4) + lo(age, span = 0.7) + education, data = Wage)
plot(gam.lo, se = T)

# logistic regression GAM
gam.lr <- gam(I(wage > 250) ~ year + s(age, 5) + education, data = Wage)
par(mfrow = c(1,3))
plot(gam.lr, se = T, col = "green")
table(education, I(wage > 250))

gam.lr.s <- gam(I(wage > 250) ~ year + s(age, 5) + education, 
                subset = (education) != "1. < Hs Grad", data = Wage)
plot(gam.lr.s, se = T, col = "green")
par(mfrow=c(1,1))

# (1) K-Means Clustering
# K-means with 2 cluster
set.seed(2)

x <- matrix(rnorm(50*2), ncol = 2)
x[1:25] <- x[1:25, 1] + 3
x[1:25,2] <- x[1:25, 2] - 4
plot(x)

km.out <- kmeans(x, 2, nstart = 20)
km.out$cluster
plot(x, col = km.out$cluster+1, main = "K-means Clustering with K=2", pch = 20, cex = 2)

# K-means with 3 cluster
set.seed(4)
km.out <- kmeans(x, 3, nstart =20)
km.out$cluster
plot(x, col = km.out$cluster+1, main = "K-means Clustering with K=3", pch = 20, cex = 2)

# tot.withinss
set.seed(4)
km.out <- kmeans(x, 3, nstart = 1)
km.out$tot.withinss

km.out <- kmeans(x, 3, nstart = 20)
km.out$tot.withinss

# (2) Hierarchical Clustering
head(x)
length(dist(x)) # = 50*49/2 
head(dist(x)) # dist(x) = 유클리디안 거리 
hc.complete <- hclust(dist(x), method = "complete")
hc.average <- hclust(dist(x), method = "average")
hc.single <- hclust(dist(x), method = "single")

par(mfrow = c(1,3))
plot(hc.complete, main = "Complete", cex = 0.9)
plot(hc.average, main = "Average", cex = 0.9)
plot(hc.single, main = "Single", cex = 0.9)

hc.complete
hc.average
hc.single

cutree(hc.complete, k = 3)
cutree(hc.average, k = 3)
cutree(hc.single, k = 3)

par(mfrow = c(1,2))
x.scaled <- scale(x)
mean(x.scaled[,1])
plot(hclust(dist(x), method = "complete"), main = "Complete")
plot(hclust(dist(x.scaled), method = "complete"), main = "Complete(Scaled)")

# Correlation based clustering 
par(mfrow = c(1,1))
x <- matrix(rnorm(30*3), ncol = 3)
head(x); dim(x)
dim(1- cor(t(x)))

hc.complete <- hclust(as.dist(1-cor(t(x))), method = "complete")
plot(hc.complete, main = "Complete linkage with correlation")
