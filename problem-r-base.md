```R
library(tidyverse)
ggplot2::theme_set(theme_bw())
```


```R
library(showtext)
font_add_google(name = "Black Han Sans", family = "blackhansans")
showtext_auto()
```

    Loading required package: sysfonts
    
    Loading required package: showtextdb
    
    


```R
setwd("C:/Users/이찬솔/Documents/ADP/problem/problem1")
```

# 1번
온,습도,조도,CO2농도에 따른 객실의 사용유무 판별     
종속변수 Occupancy, 0: 비어있음 , 1: 사용중    

데이터 경로 : /kaggle/input/adp-kr-p1/problem1.csv

### 1 - (1)
데이터 EDA 수행 후, 분석가 입장에서 의미있는 탐색


```R
problem1 <- read.csv("problem1.csv")
colSums(is.na(problem1))
```


<style>
.dl-inline {width: auto; margin:0; padding: 0}
.dl-inline>dt, .dl-inline>dd {float: none; width: auto; display: inline-block}
.dl-inline>dt::after {content: ":\0020"; padding-right: .5ex}
.dl-inline>dt:not(:first-of-type) {padding-left: .5ex}
</style><dl class=dl-inline><dt>date</dt><dd>0</dd><dt>Temperature</dt><dd>0</dd><dt>Humidity</dt><dd>0</dd><dt>Light</dt><dd>0</dd><dt>CO2</dt><dd>21</dd><dt>HumidityRatio</dt><dd>0</dd><dt>Occupancy</dt><dd>0</dd></dl>




```R
library(lubridate)
problem1$date <-  as_datetime(problem1$date)
problem1$Occupancy <- as.factor(problem1$Occupancy)
```


```R
# summary(problem1)
# map(problem1 %>% select(-c(date, CO2)), sd)
# sd(problem1$CO2, na.rm = T)
```

- 관측시간별 변수들의 변화


```R
date <- rep(problem1$date, 5)
```


```R
gather(problem1 %>% select(-c(date, Occupancy))) %>% mutate(date = date) %>% 
    group_by(key, date) %>%
    ggplot(aes(date, value, group = key, colour = key)) + geom_line() + 
    theme(axis.text.x = element_blank()) +
    facet_wrap(~ key, scales = "free_y")
```


    
![png](problem-r-base_files/problem-r-base_10_0.png)
    


- 날짜별 변수들의 평균 변화


```R
gather(problem1 %>% select(-c(date, Occupancy))) %>% 
    mutate(date = format(date, "%Y-%m-%d")) %>% 
    group_by(key, date) %>% summarise(mean = mean(value, na.rm = T)) %>% 
    ggplot(aes(date, mean, group = key, colour = key)) + geom_line() +
    theme(axis.text.x = element_blank()) +
    facet_wrap(~ key, scales = "free_y")
```

- 시간대별 변수들의 평균 변화


```R
gather(problem1 %>% select(-c(date, Occupancy))) %>% 
    mutate(date = format(date, "%H")) %>% 
    group_by(key, date) %>% summarise(mean = mean(value, na.rm = T)) %>% 
    ggplot(aes(date, mean, group = key, colour = key)) + geom_line() +
    theme(axis.text.x = element_blank()) +
    facet_wrap(~ key, scales = "free_y")
```

- 변수별 빈도분포


```R
gather(problem1 %>% select(-c(date, Occupancy))) %>%
    ggplot(aes(value)) + geom_histogram(bins = 50) + 
    facet_wrap(~ key, scales = "free_x")
```

- datetime형 변수별 변수들의 변동


```R
library("PerformanceAnalytics")
```


```R
problem1 %>% na.omit %>% 
    select(-date) %>%
    chart.Correlation(histogram = , pch = "+")
```


    
![png](problem-r-base_files/problem-r-base_19_0.png)
    


- 수치형 변수중 종속변수에 가장 큰 영향을 미치는 변수는 Light이며, 모든 상관관계는 통계적으로 유의


```R
library("corrgram")

problem1 %>% na.omit %>% 
    select(-date) %>% cor
problem1 %>% na.omit %>% 
    select(-date) %>% cor %>% corrgram(upper.panel = panel.conf)
```

### 1 - (2)
결측치를 대체하는 방식 선택하고 근거제시, 대체 수행


```R
21 / nrow(problem1)
```


0.00117252931323283


- 완전 분석법을 선택하여 결측값을 모두 제거
- 결측값이 데이터에서 차지하는 비율이 0.5%미만이기에, 자료가 삭제되어 발생하는 효율성 상실과, 통계적 추론 타당성 문제의 부작용이 감쇄됨


```R
problem1 <- read.csv("problem1.csv")
problem1_clean <- na.omit(problem1)
```

### 1 - (3)
추가적으로 데이터의 질 및 품질관리를 향상시킬만한 내용 작성

- 종속변수 Occupancy를 범주형 변수로 변경
- 수치형 변수들의 단위가 각각 상이함으로, 이에 따라 표준화를 시행


```R
library(recipes)
```


```R
problem1_clean$Occupancy <- as.factor(problem1_clean$Occupancy)
```


```R
problem1_rec <- recipe(Occupancy ~ ., data = problem1_clean) %>%
    step_center(all_numeric()) %>%
    step_scale(all_numeric()) %>%
    prep(training = problem1_clean, retain = T) %>%
    juice()
```

- date변수를 파싱하여 월, 일, 시, 분, 초 별로 변수 생성


```R
problem1_rec$date <- as.POSIXlt(problem1_rec$date)
```


```R
problem1_rec <- problem1_rec %>%
    mutate(mon = unclass(problem1_rec$date)$mon,
           mday = unclass(problem1_rec$date)$mday,
           hour = unclass(problem1_rec$date)$hour,
           min = unclass(problem1_rec$date)$min,
           sec = unclass(problem1_rec$date)$sec) %>%
    select(-date)
```


```R
problem1_rec %>% head
```


<table class="dataframe">
<caption>A tibble: 6 × 11</caption>
<thead>
	<tr><th scope=col>Temperature</th><th scope=col>Humidity</th><th scope=col>Light</th><th scope=col>CO2</th><th scope=col>HumidityRatio</th><th scope=col>Occupancy</th><th scope=col>mon</th><th scope=col>mday</th><th scope=col>hour</th><th scope=col>min</th><th scope=col>sec</th></tr>
	<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;fct&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>2.988318</td><td>-0.2573837</td><td>2.966159</td><td>0.3940566</td><td>0.7917802</td><td>1</td><td>1</td><td>2</td><td>14</td><td>19</td><td>59</td></tr>
	<tr><td>2.992848</td><td>-0.2900848</td><td>2.464166</td><td>0.4442319</td><td>0.7535430</td><td>1</td><td>1</td><td>2</td><td>14</td><td>22</td><td> 0</td></tr>
	<tr><td>3.024552</td><td>-0.2752206</td><td>2.433625</td><td>0.4590922</td><td>0.7837496</td><td>1</td><td>1</td><td>2</td><td>14</td><td>23</td><td> 0</td></tr>
	<tr><td>3.030591</td><td>-0.2633293</td><td>2.908439</td><td>0.4975540</td><td>0.8006109</td><td>1</td><td>1</td><td>2</td><td>14</td><td>23</td><td>59</td></tr>
	<tr><td>3.024552</td><td>-0.2573837</td><td>2.554602</td><td>0.5220298</td><td>0.8055895</td><td>1</td><td>1</td><td>2</td><td>14</td><td>25</td><td>59</td></tr>
	<tr><td>3.006435</td><td>-0.2375649</td><td>2.560532</td><td>0.5639882</td><td>0.8229227</td><td>1</td><td>1</td><td>2</td><td>14</td><td>28</td><td> 0</td></tr>
</tbody>
</table>



### 2 - (1)
데이터에 불균형이 있는지 확인, 불균형 판단 근거 작성



```R
problem1_rec %>% group_by(Occupancy) %>%
    count() %>% t()
problem1_rec %>% ggplot(aes(Occupancy)) + geom_bar(fill = "white", col = "black")
```


<table class="dataframe">
<caption>A matrix: 2 × 2 of type chr</caption>
<tbody>
	<tr><th scope=row>Occupancy</th><td>0    </td><td>1    </td></tr>
	<tr><th scope=row>n</th><td>15790</td><td> 2099</td></tr>
</tbody>
</table>




    
![png](problem-r-base_files/problem-r-base_36_1.png)
    


- 위와같이 반응변수 Occupancy의 범주별 분포가 불균형한 것을 알 수 있다. => 데이터 불균형 존재

### 2 - (2)
- 오버샘플링 방법들 중 2개 선택하고 장단점 등 선정 이유 제시

### 오버 샘플링 : 소수 클래스의 데이터를 복제 또는 생성하여 데이터의 비율을 맞추는 방법

#### 장점
- 정보가 손실되지 않음
- 알고리즘의 성능이 언더샘플링에 비해 증가

#### 단점
- 데이터 증가로 인한 계산시간의 증가
- 과적합을 초래하여, 검증의 성능이 감소할 가능성 존재

1. 랜덤 과대표집 (ROS) 
- 무작위로 소수 클래스 데이터를 복제하여 데이터의 비율을 맞추는 **간단한 방법**이지만, 데이터의 중복으로 인하여 과적합 문제 발생 가능성이 증가

2. SMOTE (Synthetic Minority Oversampling Technique)
- 소수 클래스에서 중심이 되는 데이터와 주변 데이터 사이에 가상의 직선을 만든 후, 그 위에 데이터를 추가하는 방법
- 랜덤 과대표집과 달리 중복을 사용하는 알고리즘이 아님 => ROS에 비해 과적합 문제 발생 가능성이 낮음, 하지만 마찬가지로 과적합 가능성 존재

### 2 - (3)
오버샘플링 수행 및 결과, 잘 되었다는 것을 판단해라


```R
library(caret)
UpSamp <- caret::upSample(problem1_rec %>% select(-Occupancy), 
                           problem1_rec$Occupancy)
```


```R
UpSamp %>% group_by(Class) %>%
    count() %>% t()
UpSamp %>% ggplot(aes(Class)) + geom_bar()
```


<table class="dataframe">
<caption>A matrix: 2 × 2 of type chr</caption>
<tbody>
	<tr><th scope=row>Class</th><td>0    </td><td>1    </td></tr>
	<tr><th scope=row>n</th><td>15790</td><td>15790</td></tr>
</tbody>
</table>




    
![png](problem-r-base_files/problem-r-base_42_1.png)
    


- 랜덤 과대표집(ROS) 시행결과, Occupancy의 범주별 수가 각각 15790으로 동일하게 되어 균형이 맞추어졌다.


```R
library(smotefamily)
```


```R
Smote <- smotefamily::SMOTE(problem1_rec %>% select(-Occupancy),
                            problem1_rec$Occupancy)
```


```R
Smote_data <- Smote$data
Smote_data$class <- Smote_data$class %>% as.factor()
```


```R
Smote_data %>% group_by(class) %>%
    count() %>% t()
Smote_data %>% ggplot(aes(class)) + geom_bar()
```


<table class="dataframe">
<caption>A matrix: 2 × 2 of type chr</caption>
<tbody>
	<tr><th scope=row>class</th><td>0    </td><td>1    </td></tr>
	<tr><th scope=row>n</th><td>15790</td><td>14693</td></tr>
</tbody>
</table>




    
![png](problem-r-base_files/problem-r-base_47_1.png)
    


- SMOTE 시행결과, Occupancy의 "1"범주 수가 14693으로 증가하게 되어 균형이 맞추어졌다.

- problem1_rec : 오버샘플링 전

- UpSamp : ROS

- Smote_data : SMOTE

### 3 - (1)
속도측면, 정확도측면 모델 1개씩 선택, 선택 이유도 기술

#### 속도측면 : 로지스틱 회귀 분석
- 반응변수가 범주형인 경우 적용되는 기본적인 회귀 분석 모형
- 하이퍼 파라미터의 조정이 필요없음

#### 정확도측면 : 랜덤 포레스트
- 랜덤 포레스트 모델은 기본적으로 원 데이터를 대상으로 복원추출 방식으로 데이터의 양을 증가시킨 후 모델을 생성하기 대문에 데이터의 양이 부족해서 발생하는 과적합의 원인을 해결할 수 있다.
- 이는 오버 샘플링이 가진 단점인 과적합을 보완해줄 것

### 3 - (2)
위에서 오버샘플링 한 데이터 2개, 오버샘플링 하기 전 데이터 1개에 대해 모델 2개를 적용하고 성능 보여주기

- 로지스틱 회귀


```R
library(rsample)

set.seed(1234)
split_raw <- initial_split(problem1_rec, 0.7)
train_raw <- training(split_raw)
test_raw <- testing(split_raw)

split_Up <- initial_split(UpSamp, 0.7)
train_Up <- training(split_Up)
test_Up <- testing(split_Up)

split_Smote <- initial_split(Smote_data, 0.7)
train_Smote <- training(split_Smote)
test_Smote <- testing(split_Smote)
```


```R
model1_1 <- glm(Class ~ ., data = train_Up,
                family = binomial)

pred1_1 <- predict(model1_1, newdata = test_Up, type = "response") %>% round

mean(pred1_1 == test_Up$Class)
```

    Warning message in predict.lm(object, newdata, se.fit, scale = 1, type = if (type == :
    "prediction from a rank-deficient fit may be misleading"
    


0.990394764618957



```R
model1_2 <- glm(class ~ ., data = train_Smote,
                family = binomial)

pred1_2 <- predict(model1_2, newdata = test_Smote, type = "response") %>% round

mean(pred1_2 == test_Smote$class)
```

    Warning message:
    "glm.fit: fitted probabilities numerically 0 or 1 occurred"
    Warning message in predict.lm(object, newdata, se.fit, scale = 1, type = if (type == :
    "prediction from a rank-deficient fit may be misleading"
    


0.991580098414434



```R
model1_3 <- glm(Occupancy ~ ., data = train_raw,
                family = binomial)

pred1_3 <- predict(model1_3, newdata = test_raw, type = "response") %>% round

mean(pred1_3 == test_raw$Occupancy)
```

    Warning message in predict.lm(object, newdata, se.fit, scale = 1, type = if (type == :
    "prediction from a rank-deficient fit may be misleading"
    


0.986025712688653


- ROS, SMOTE, 오버 샘플링 이전 데이터로 생성된 로지스틱 회귀 모형의 분류 정확도는 각각 98.997%, 99.06%, 98.6026%퍼센트의 높은 정확도를 가진다
- 정확도의 성능은 SMOTE, ROS, 오버 샘플링 이전 데이터 순으로 높으며, 오버 샘플링 이전 데이터의 성능이 가장 낮다.

- Random FOrest


```R
library(randomForest)
```


```R
model2_1 <- randomForest(Class ~ ., data = train_Up, 
                   mtry = round(sqrt(ncol(train_Up - 1))))
```

    Warning message in Ops.factor(left, right):
    "'-' not meaningful for factors"
    


```R
model2_1
```


    
    Call:
     randomForest(formula = Class ~ ., data = train_Up, mtry = round(sqrt(ncol(train_Up -      1)))) 
                   Type of random forest: classification
                         Number of trees: 500
    No. of variables tried at each split: 3
    
            OOB estimate of  error rate: 0.31%
    Confusion matrix:
          0     1 class.error
    0 10998    68 0.006144948
    1     0 11040 0.000000000



```R
pred2_1 <- predict(model2_1, test_Up)
```


```R
mean(pred2_1 == test_Up$Class)
```


0.997783407219759



```R
model2_2 <- randomForest(class ~ ., data = train_Smote, 
                   mtry = round(sqrt(ncol(train_Smote - 1))))
```

    Warning message in Ops.factor(left, right):
    "'-' not meaningful for factors"
    


```R
model2_2
```


    
    Call:
     randomForest(formula = class ~ ., data = train_Smote, mtry = round(sqrt(ncol(train_Smote -      1)))) 
                   Type of random forest: classification
                         Number of trees: 500
    No. of variables tried at each split: 3
    
            OOB estimate of  error rate: 0.4%
    Confusion matrix:
          0     1 class.error
    0 10936    65 0.005908554
    1    20 10317 0.001934797



```R
pred2_2 <- predict(model2_2, test_Smote)
```


```R
mean(pred2_2 == test_Smote$class)
```


0.996610169491525



```R
model2_3 <- randomForest(Occupancy ~ ., data = train_raw, 
                   mtry = round(sqrt(ncol(train_raw - 1))))
```

    Warning message in Ops.factor(left, right):
    "'-' not meaningful for factors"
    


```R
model2_3
```


    
    Call:
     randomForest(formula = Occupancy ~ ., data = train_raw, mtry = round(sqrt(ncol(train_raw -      1)))) 
                   Type of random forest: classification
                         Number of trees: 500
    No. of variables tried at each split: 3
    
            OOB estimate of  error rate: 0.51%
    Confusion matrix:
          0    1 class.error
    0 11011   38 0.003439225
    1    26 1447 0.017651052



```R
pred2_3 <- predict(model2_3, test_raw)
```


```R
mean(pred2_3 == test_raw$Occupancy)
```


0.9927333705981


- ROS, SMOTE, 오버 샘플링 이전 데이터로 생성된 로지스틱 회귀 모형의 분류 정확도는 각각 99.7783%, 99.661%, 99.2733%퍼센트의 높은 정확도를 가진다
- 정확도의 성능은 ROS, SMOTE, 오버 샘플링 이전 데이터 순으로 높으며, 오버 샘플링 이전 데이터의 성능이 가장 낮다.
- OOB 검정 에러율 역시 ROS, SMOTE, 오버 샘플링 이전 데이터 순으로 낮다.

### 3 - (3)
위 예측결과 사용해서 오버샘플링이 미친 영향에 대해 작성하라



- 오버 샘플링한 데이터로 생성한 모형이, 오버 샘플링 이전 데이터로 생성한 모형보다 전체적으로 분류 정확도가 높음을 알 수 있다.
- 이는 오버 샘플링의 장점인 "알고리즘 성능의 증가"라고 해석 할 수 있다.

# 2번
공장에서는 진공관 수명이 1만 시간이라고 주장하여 품질관리팀에서 12개 샘플을 뽑았음 유의수준 5%에서 부호 검정하시오    
데이터 경로 : /kaggle/input/adp-kr-p1/problem2.csv


```R
problem2 <- read.csv("problem2.csv")
sum(is.na(problem2))
```


0



```R
glimpse(problem2)
mean(problem2$life.span)
```

    Rows: 12
    Columns: 2
    $ name      [3m[90m<chr>[39m[23m "sample1", "sample2", "sample3", "sample4", "sample5", "samp~
    $ life.span [3m[90m<int>[39m[23m 10000, 9000, 9500, 10000, 10000, 8900, 9900, 10100, 10300, 1~
    


9793.33333333333


### 1
귀무가설, 연구가설 세우기

- 귀무가설 : 진공관 수명이 (life.span)의 중위수는 1만시간이다.
- 대립가설 : 진공관 수명의 중위수는 1만시간이 아니다.

### 2
유효한 데이터의 개수는?

- 중위수와 동일한 값들은 순위 부호 검정에서 불필요한 데이터


```R
problem2 %>% filter(life.span != 10000) %>% nrow
```


8


유효한 데이터의ㅣ 개수는 8개

### 3
검정통계량 및 연구가설 채택 여부를 작성하라


```R
wilcox.test(problem2 %>% filter(life.span != 10000) %>% .$life.span, 
            alternative = "two.sided", mu = 10000)
```

    Warning message in wilcox.test.default(problem2 %>% filter(life.span != 10000) %>% :
    "cannot compute exact p-value with ties"
    


    
    	Wilcoxon signed rank test with continuity correction
    
    data:  problem2 %>% filter(life.span != 10000) %>% .$life.span
    V = 8.5, p-value = 0.207
    alternative hypothesis: true location is not equal to 10000
    


- 검정통계량 s는 8.5이며 P-value > 0.05 => 귀무가설 기각 불가 => 진공관 수명의 평균은 10000시간이 아니다.

# 3번
코로나 시계열 데이터     
데이터 출처(후처리과정 미포함) :https://www.kaggle.com/antgoldbloom/covid19panels?select=country_panel.csv    
     
데이터 경로 : /kaggle/input/adp-kr-p1/problem3_covid.csv


```R
problem3 <- read.csv("problem3_covid2.csv")
```


```R
colSums(is.na(problem3))
```


<style>
.dl-inline {width: auto; margin:0; padding: 0}
.dl-inline>dt, .dl-inline>dd {float: none; width: auto; display: inline-block}
.dl-inline>dt::after {content: ":\0020"; padding-right: .5ex}
.dl-inline>dt:not(:first-of-type) {padding-left: .5ex}
</style><dl class=dl-inline><dt>location</dt><dd>0</dd><dt>date</dt><dd>0</dd><dt>new_cases</dt><dd>233</dd></dl>




```R
problem3$date <- as_date(problem3$date)
```


```R
problem3 %>% group_by(location) %>%
    summarise(NAs = sum(is.na(new_cases))) %>% arrange(-NAs) %>% head
```


<table class="dataframe">
<caption>A tibble: 6 × 2</caption>
<thead>
	<tr><th scope=col>location</th><th scope=col>NAs</th></tr>
	<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th></tr>
</thead>
<tbody>
	<tr><td>Palau     </td><td>233</td></tr>
	<tr><td>Austria   </td><td>  0</td></tr>
	<tr><td>Bangladesh</td><td>  0</td></tr>
	<tr><td>Bhutan    </td><td>  0</td></tr>
	<tr><td>Chile     </td><td>  0</td></tr>
	<tr><td>Colombia  </td><td>  0</td></tr>
</tbody>
</table>




```R
problem3 <- problem3 %>%
    mutate(location = as.factor(location),
           new_cases = ifelse(is.na(new_cases), 0, new_cases))
```

### 1 
데이터는 일자별 각 나라의 일일 확진자수를 나타낸다. 각 나라의 일자별 누적확진자 수를 나타내는 데이터 프레임을 생성하라


```R
problem31 <- problem3 %>%
    group_by(location) %>%
    summarise(cumsum = cumsum(new_cases)) %>% ungroup() %>%
    mutate(date = problem3$date) %>% select(location, date, cumsum)
```

    [1m[22m`summarise()` has grouped output by 'location'. You can override using the `.groups` argument.
    


```R
problem31 %>% print
```

    [90m# A tibble: 11,895 x 3[39m
       location date       cumsum
       [3m[90m<fct>[39m[23m    [3m[90m<date>[39m[23m      [3m[90m<dbl>[39m[23m
    [90m 1[39m Austria  2021-01-01   [4m2[24m096
    [90m 2[39m Austria  2021-01-02   [4m3[24m487
    [90m 3[39m Austria  2021-01-03   [4m4[24m953
    [90m 4[39m Austria  2021-01-04   [4m6[24m595
    [90m 5[39m Austria  2021-01-05   [4m8[24m906
    [90m 6[39m Austria  2021-01-06  [4m1[24m[4m1[24m375
    [90m 7[39m Austria  2021-01-07  [4m1[24m[4m3[24m915
    [90m 8[39m Austria  2021-01-08  [4m1[24m[4m5[24m978
    [90m 9[39m Austria  2021-01-09  [4m1[24m[4m8[24m256
    [90m10[39m Austria  2021-01-10  [4m1[24m[4m9[24m907
    [90m# ... with 11,885 more rows[39m
    

### 2
1에서 구한 데이터를 각 나라별로 acf값을 구하고(lag는 50개까지 구하고 첫번째 값을 제외하라) 국가를 기준으로 유클리디안 거리를 기준으로 클러스터링을 진행 후 계층적 군집 분석을 위해 덴드로그램 작성하라




```R
problem32 <- problem31 %>% spread(location, cumsum) %>% select(-date)
```


```R
acfs <- matrix(nrow = ncol(problem32), ncol = 49)
for (i in 1:ncol(problem32)) {
    acfs[i, ] <- acf(problem32[, i], lag.max = 50, plot = F)$acf[2:50]  
}
```


```R
acfs <- acfs %>% data.frame()
rownames(acfs) <- colnames(problem32)
acfs %>% head
```


<table class="dataframe">
<caption>A data.frame: 6 × 49</caption>
<thead>
	<tr><th></th><th scope=col>X1</th><th scope=col>X2</th><th scope=col>X3</th><th scope=col>X4</th><th scope=col>X5</th><th scope=col>X6</th><th scope=col>X7</th><th scope=col>X8</th><th scope=col>X9</th><th scope=col>X10</th><th scope=col>...</th><th scope=col>X40</th><th scope=col>X41</th><th scope=col>X42</th><th scope=col>X43</th><th scope=col>X44</th><th scope=col>X45</th><th scope=col>X46</th><th scope=col>X47</th><th scope=col>X48</th><th scope=col>X49</th></tr>
	<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>...</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><th scope=row>Austria</th><td>0.9869103</td><td>0.9738945</td><td>0.9610272</td><td>0.9483469</td><td>0.9358839</td><td>0.9235627</td><td>0.9113884</td><td>0.8992865</td><td>0.8872453</td><td>0.8752772</td><td>...</td><td>0.5317045</td><td>0.5204199</td><td>0.5091831</td><td>0.4979598</td><td>0.4867449</td><td>0.4755426</td><td>0.4643703</td><td>0.4532669</td><td>0.4422424</td><td>0.4313336</td></tr>
	<tr><th scope=row>Bangladesh</th><td>0.9939576</td><td>0.9877566</td><td>0.9814014</td><td>0.9748946</td><td>0.9682402</td><td>0.9614389</td><td>0.9544910</td><td>0.9473939</td><td>0.9401497</td><td>0.9327650</td><td>...</td><td>0.6551037</td><td>0.6444044</td><td>0.6336432</td><td>0.6228244</td><td>0.6119496</td><td>0.6010194</td><td>0.5900345</td><td>0.5790055</td><td>0.5679337</td><td>0.5568202</td></tr>
	<tr><th scope=row>Bhutan</th><td>0.9945855</td><td>0.9891467</td><td>0.9835901</td><td>0.9779759</td><td>0.9722264</td><td>0.9664591</td><td>0.9606362</td><td>0.9546784</td><td>0.9487972</td><td>0.9427963</td><td>...</td><td>0.7102043</td><td>0.7007492</td><td>0.6911933</td><td>0.6815638</td><td>0.6718471</td><td>0.6620470</td><td>0.6521654</td><td>0.6421743</td><td>0.6320912</td><td>0.6219113</td></tr>
	<tr><th scope=row>Chile</th><td>0.9924549</td><td>0.9848461</td><td>0.9771647</td><td>0.9694148</td><td>0.9615983</td><td>0.9537113</td><td>0.9457676</td><td>0.9377683</td><td>0.9297230</td><td>0.9216348</td><td>...</td><td>0.6574334</td><td>0.6478904</td><td>0.6383022</td><td>0.6286721</td><td>0.6189985</td><td>0.6092850</td><td>0.5995266</td><td>0.5897102</td><td>0.5798314</td><td>0.5699112</td></tr>
	<tr><th scope=row>Colombia</th><td>0.9933398</td><td>0.9865957</td><td>0.9797601</td><td>0.9728376</td><td>0.9658572</td><td>0.9588198</td><td>0.9517289</td><td>0.9445868</td><td>0.9373843</td><td>0.9301208</td><td>...</td><td>0.6884212</td><td>0.6794712</td><td>0.6704593</td><td>0.6613823</td><td>0.6522379</td><td>0.6430293</td><td>0.6337511</td><td>0.6244062</td><td>0.6150000</td><td>0.6055322</td></tr>
	<tr><th scope=row>Costa Rica</th><td>0.9918104</td><td>0.9835349</td><td>0.9751530</td><td>0.9667514</td><td>0.9582855</td><td>0.9497913</td><td>0.9412421</td><td>0.9325714</td><td>0.9238242</td><td>0.9149723</td><td>...</td><td>0.6278797</td><td>0.6180374</td><td>0.6082169</td><td>0.5983956</td><td>0.5887287</td><td>0.5789864</td><td>0.5691815</td><td>0.5594356</td><td>0.5497661</td><td>0.5401296</td></tr>
</tbody>
</table>




```R
library(cluster)
library(factoextra)
```


```R
d <- dist(acfs, method = "euclidean")
hc <- hclust(d, method = "ward.D")
```

- 와드 연결법 :다른 연결법 보다 분산(variance)이 가장 적고 노이즈나, 이상치에 덜 민감


```R
p1 <- fviz_nbclust(acfs, FUN = hcut, "wss")
p2 <- fviz_dend(hc, k = 3)

gridExtra::grid.arrange(grobs = list(p1, p2))
```


    
![png](problem-r-base_files/problem-r-base_104_0.png)
    


# 4번
아래 이미지와 같은 학과별 학점 분포 인원수 표가 있다. 학과와 성적이 관계있는지를 검정하라    
![image](https://github.com/Datamanim/datarepo/blob/main/adp/p1/problem4.png?raw=true)


### 1번
귀무가설, 연구가설 세우기


```R
score <- c("1.5 ~ 2.5", "2.5 ~ 3.5", "3.5 ~ 4.5")
major <- c("사회과학", "자연과학", "공학")
problem4 <- matrix(nrow = 3, ncol = 3, data = c(15, 60, 24, 25, 69, 5, 10 ,77, 13),
                   byrow = F)
```


```R
rownames(problem4) <- score
colnames(problem4) <- major
(table <- addmargins(problem4))
```


<table class="dataframe">
<caption>A matrix: 4 × 4 of type dbl</caption>
<thead>
	<tr><th></th><th scope=col>사회과학</th><th scope=col>자연과학</th><th scope=col>공학</th><th scope=col>Sum</th></tr>
</thead>
<tbody>
	<tr><th scope=row>1.5 ~ 2.5</th><td>15</td><td>25</td><td> 10</td><td> 50</td></tr>
	<tr><th scope=row>2.5 ~ 3.5</th><td>60</td><td>69</td><td> 77</td><td>206</td></tr>
	<tr><th scope=row>3.5 ~ 4.5</th><td>24</td><td> 5</td><td> 13</td><td> 42</td></tr>
	<tr><th scope=row>Sum</th><td>99</td><td>99</td><td>100</td><td>298</td></tr>
</tbody>
</table>



- 귀무가설 : 학과에 따라 성적의 차이가 없다. (두 변수는 독립이다)
- 대립가설 : 학과에 따라 성적의 차이가 있다. (두 변수는 독립이 아니다)

### 2번
학과와 성적이 독립일 경우의 기댓값을 구하시오


```R
E <- matrix(nrow = 3, ncol = 3)
for (i in 1:3) {
    for (j in 1:3) {
        E[i, j] <- table[i, 4] * table[4, j] / 298
    }
}
rownames(E) <- score
colnames(E) <- major
E
```


<table class="dataframe">
<caption>A matrix: 3 × 3 of type dbl</caption>
<thead>
	<tr><th></th><th scope=col>사회과학</th><th scope=col>자연과학</th><th scope=col>공학</th></tr>
</thead>
<tbody>
	<tr><th scope=row>1.5 ~ 2.5</th><td>16.61074</td><td>16.61074</td><td>16.77852</td></tr>
	<tr><th scope=row>2.5 ~ 3.5</th><td>68.43624</td><td>68.43624</td><td>69.12752</td></tr>
	<tr><th scope=row>3.5 ~ 4.5</th><td>13.95302</td><td>13.95302</td><td>14.09396</td></tr>
</tbody>
</table>



### 3번
검정통계량 구하고 연구가설의 채택여부 작성


```R
library("gmodels")
ct <- CrossTable(problem4, chisq = T)
# chisq.test(problem4)
```

    
     
       Cell Contents
    |-------------------------|
    |                       N |
    | Chi-square contribution |
    |           N / Row Total |
    |           N / Col Total |
    |         N / Table Total |
    |-------------------------|
    
     
    Total Observations in Table:  298 
    
     
                 |  
                 |  사회과학 |  자연과학 |      공학 | Row Total | 
    -------------|-----------|-----------|-----------|-----------|
       1.5 ~ 2.5 |        15 |        25 |        10 |        50 | 
                 |     0.156 |     4.237 |     2.739 |           | 
                 |     0.300 |     0.500 |     0.200 |     0.168 | 
                 |     0.152 |     0.253 |     0.100 |           | 
                 |     0.050 |     0.084 |     0.034 |           | 
    -------------|-----------|-----------|-----------|-----------|
       2.5 ~ 3.5 |        60 |        69 |        77 |       206 | 
                 |     1.040 |     0.005 |     0.897 |           | 
                 |     0.291 |     0.335 |     0.374 |     0.691 | 
                 |     0.606 |     0.697 |     0.770 |           | 
                 |     0.201 |     0.232 |     0.258 |           | 
    -------------|-----------|-----------|-----------|-----------|
       3.5 ~ 4.5 |        24 |         5 |        13 |        42 | 
                 |     7.234 |     5.745 |     0.085 |           | 
                 |     0.571 |     0.119 |     0.310 |     0.141 | 
                 |     0.242 |     0.051 |     0.130 |           | 
                 |     0.081 |     0.017 |     0.044 |           | 
    -------------|-----------|-----------|-----------|-----------|
    Column Total |        99 |        99 |       100 |       298 | 
                 |     0.332 |     0.332 |     0.336 |           | 
    -------------|-----------|-----------|-----------|-----------|
    
     
    Statistics for All Table Factors
    
    
    Pearson's Chi-squared test 
    ------------------------------------------------------------
    Chi^2 =  22.13692     d.f. =  4     p =  0.0001882265 
    
    
     
    

- 검정통계량 : 22.13692, P-value < 0.05 => 귀무가설 기각 
- 학과와 성적의 관련성은 있는 것으로 나타났다.
