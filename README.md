## 1. 대한민국 축구 국가 대표팀 '2022 카타르 월드컵 최종예선'경기의 YouTube 하이라이트 영상  댓글 키워드를 활용한 감성분석  

<br/>

- 라이브러리 호출
```javascript
library(tuber)
library(ggplot2)
```

<br/>

### '2022 카타르 월드컵 최종예선'의 독점중계사인 tvN SPORTS채널에 업로드된, 경기별 YouTube 댓글수집  

#### YouTube 하이라이트 영상을 수집할 경기는 아래와 같다.
- 2021-09-02 | 대한민국 0:0 이라크 | 하이라이트 영상 (https://www.youtube.com/watch?v=tD3Rt0G5DzQ)
- 2021-09-07 | 대한민국 1:0 레바논 | 하이라이트 영상 (https://www.youtube.com/watch?v=KpeMHJt51dM)
- 2021-10-07 | 대한민국 2:1 시리아 |  하이라이트 영상 (https://www.youtube.com/watch?v=moWz-iJt21A)
- 2021-10-12 | 이란 1:1 대한민국 |  하이라이트 영상 (https://www.youtube.com/watch?v=dilLNo2tXaE)
- 2021-11-11 | 대한민국 1:0 아랍에미리트 | 하이라이트 영상 (https://www.youtube.com/watch?v=IwgZhtMLx3s)
- 2021-11-17 | 이라크 0:3 대한민국 |  하이라이트 영상 (https://www.youtube.com/watch?v=aVNcxjMxnHg)
- 2022-01-27 | 레바논 0:1 대한민국 |  하이라이트 영상 (https://www.youtube.com/watch?v=TYT15A1ZzQQ)
- 2022-02-01 | 시리아 0:2 대한민국 |  하이라이트 영상 (https://www.youtube.com/watch?v=SvtTEEOuokc)

<br/>

#### YouTube API를 통한 영상 정보 수집

```javascript
yt_oauth(app_id = app_id,
         app_secret = app_secret,
         token = "")
```
```javascript
video_id = c("tD3Rt0G5DzQ", "KpeMHJt51dM", "moWz-iJt21A", "dilLNo2tXaE",
             "IwgZhtMLx3s", "aVNcxjMxnHg", "TYT15A1ZzQQ", "SvtTEEOuokc")
title <- c("1R 이라크전", "2R 레바논전", "3R 시리아전", "4R 이란전", "5R UAE전", "6R 이라크전", "7R 레바논전", "8R 시리아전")
```
```javascript
round <- data.frame()
for (i in 1:length(video_id)) {
  r <- as.data.frame(get_stats(video_id = video_id[i]))
  round <- rbind(round, r)
}
round <- cbind(title, round)
```
```javascript
round$viewCount <- as.integer(round$viewCount)
round$likeCount <- as.integer(round$likeCount)
round$commentCount <- as.integer(round$commentCount)
```

<br/>

**title** |	**id** | **viewCount**	| **likeCount**	| **favoriteCount**	| **commentCount** |
| ---- | ---- | ---- | ---- | ---- | ---- |
1R 이라크전	| tD3Rt0G5DzQ	| 899422	| 5362	| 0	| 4418
2R 레바논전	| KpeMHJt51dM	| 869906	| 5597	| 0	| 2791
3R 시리아전	| moWz-iJt21A	| 1696184 | 11743	| 0	| 5377
4R 이란전	| dilLNo2tXaE	| 1287991 | 8735	| 0	| 4531
5R UAE전	| IwgZhtMLx3s	| 1558372 | 11789 | 0 | 3849
6R 이라크전	| aVNcxjMxnHg	| 2409278	| 21574	| 0	| 3177
7R 레바논전	| TYT15A1ZzQQ	| 1029614	| 7255	| 0	| 1792
8R 시리아전	| SvtTEEOuokc	| 1025858	| 10064	| 0	| 2040

- id : 해당 영상의 코드
- viewCount : 해당 영상의 조회수
- likeCount : 해당 영상의 좋아요 수
- commentCount : 해당 영상의 댓글 수

<br/>





<br/>


#### 경기 영상별 조회 수 시각화
```javascript
ggplot(round, aes(x = title, y = viewCount)) +
  geom_bar(fill = "#F07777", colour = "#E74C3C", stat = "identity") +
  geom_text(aes(label = format(viewCount, big.mark = ","),
                y = viewCount), stat = "identity", vjust = -0.5) +
  labs(title = "경기 영상별 조회 수") +
  xlab("") + 
  ylab("") + 
  theme(text = element_text(size = 15),
        panel.background = element_blank(),
        legend.position = "none",
        axis.ticks = element_blank(),
        axis.text.y = element_blank())
```


<br/>


#### 경기 영상별 댓글 수 시각화
```javascript
ggplot(round, aes(x = title, y = commentCount)) +
  geom_bar(fill = "#D7BDE2", colour = "#A569BD", stat = "identity") +
  geom_text(aes(label = format(commentCount, big.mark = ","),
                y = commentCount), stat = "identity", vjust = -0.5) +
  labs(title = "경기 영상별 댓글 수") +
  xlab("") + 
  ylab("") + 
  theme(text = element_text(size = 15),
        panel.background = element_blank(),
        legend.position = "none",
        axis.ticks = element_blank(),
        axis.text.y = element_blank())
```


<br/>


#### 경기 영상별 좋아요 수 시각화
```javascript
ggplot(round, aes(x = title, y = likeCount)) +
  geom_bar(fill = "#A9CCE3", colour = "#5499C7", stat = "identity") +
  geom_text(aes(label = format(likeCount, big.mark = ","),
                y = likeCount), stat = "identity", vjust = -0.5) +
  labs(title = "경기 영상별 좋아요 수") +
  xlab("") + 
  ylab("") + 
  theme(text = element_text(size = 15),
        panel.background = element_blank(),
        legend.position = "none",
        axis.ticks = element_blank(),
        axis.text.y = element_blank())
```


<br/>


#### 영상 댓글 수집하기
- 2021-09-02 | 대한민국 0:0 이라크 | 하이라이트 영상 (https://www.youtube.com/watch?v=tD3Rt0G5DzQ)과 2021-10-12 | 이란 1:1 대한민국 |  하이라이트 영상 (https://www.youtube.com/watch?v=dilLNo2tXaE)은 get_all_comments() 적용에 있어 오류발생
- 이에 따라 다른 YouTube채널(쿠팡플레이)의 유사한 영상으로 대체 혹은 수집에서 제외
```javascript
video_id
# cmt1 <- get_all_comments(video_id = video_id[1])
cmt2 <- get_all_comments(video_id = video_id[2])
cmt3 <- get_all_comments(video_id = video_id[3])
cmt4 <- get_all_comments(video_id = "GZNF-mIGL4Y") 
cmt5 <- get_all_comments(video_id = video_id[5])
cmt6 <- get_all_comments(video_id = video_id[6])
cmt7 <- get_all_comments(video_id = video_id[7])
cmt8 <- get_all_comments(video_id = video_id[8]) 
names(cmt8)
```


#### RcppMeCab 패키지를 이용하여 한글 자연어 처리
```javascript
library(RcppMeCab)
library(RmecabKo)
```


- 각 영상의 인기 콘텐츠 댓글들을 데이터 프레임으로 저장
```javascript
cmt2_pos <- posParallel(sentence = cmt2$textOriginal, format = "data.frame")
cmt3_pos <- posParallel(sentence = cmt3$textOriginal, format = "data.frame")
cmt4_pos <- posParallel(sentence = cmt4$textOriginal, format = "data.frame")
cmt5_pos <- posParallel(sentence = cmt5$textOriginal, format = "data.frame")
cmt6_pos <- posParallel(sentence = cmt6$textOriginal, format = "data.frame")
cmt7_pos <- posParallel(sentence = cmt7$textOriginal, format = "data.frame")
cmt8_pos <- posParallel(sentence = cmt8$textOriginal, format = "data.frame")
```
```javascript
head(cmt2_pos)
```




#### 긍정/부정 사전을 이용하여 감성 분석
- KNU 한국어 감성사전 (https://github.com/park1200656/KnuSentiLex)의 긍정/부정사전을 각각 로드
- 부정 단어에는 -1, 긍정 단어에는 1로 구분
```javascript
nego = readLines("neg_pol_word.txt", encoding = "UTF-8")
posi = readLines("pos_pol_word.txt", encoding = "UTF-8")
```
```javascript
negoWord = data.frame(keyword = nego, value = -1)
head(negoWord)
```
```javascript
posiWord = data.frame(keyword = posi, value = 1)
head(posiWord)
```


#### merge()함수를 통하여 각 영상의 댓글에 존재하는 키워드와, 긍정/부정 사전을 각각 대조
```javascript
compareCmt <- function(cmt_pos) {
  neg = merge.data.frame(x = cmt_pos, y = negoWord, 
                         by.x = "token", by.y = "keyword")
  pos = merge.data.frame(x = cmt_pos, y = posiWord,
                         by.x = "token", by.y = "keyword")
  sentiment <- rbind(neg, pos)
  return(sentiment)
}

sentiment_2 <- compareCmt(cmt2_pos)
sentiment_3 <- compareCmt(cmt3_pos)
sentiment_4 <- compareCmt(cmt4_pos)
sentiment_5 <- compareCmt(cmt5_pos)
sentiment_6 <- compareCmt(cmt6_pos)
sentiment_7 <- compareCmt(cmt7_pos)
sentiment_8 <- compareCmt(cmt8_pos)
```


#### 댓글별로 등장한 긍정 키워드와 부정 키워드의 숫자를 더해, 댓글별로 긍정/부정의 점수를 분류
- 각각의 댓글에 포함된 긍정/부정 단어들의 빈도를 aggregate()함수로 총합하여, 그에 따라 점수를 계산하고 댓글의 긍정/부정의 정도를 파악
- 댓글의 점수 : 0  => 중립
- 댓글의 점수 > 0  => 긍정
- 댓글의 점수 < 0  => 부정
```javascript
score <- function(sent) {
  sent_sum = aggregate(value ~ doc_id, sent, sum)
  
  for(i in 1:nrow(sent_sum)) {
    if (sent_sum$value[i] > 0) {
      sent_sum$senti[i] = "긍정"
    } else if(sent_sum$value[i] < 0) {
      sent_sum$senti[i] = "부정"
    } else sent_sum$senti[i] = "중립"
  }
  return(sent_sum)
}
```


```javascript
ScorenRatio <- function(sentiment) {
  sent <- score(sentiment)
  t <- table(sent$senti)
  posrat <- t[1] / sum(t)
  negrat <- t[2] / sum(t)
  t[4] <- posrat
  t[5] <- negrat
  names(t) <- c("긍정", "부정", "중립", "긍정 비율", "부정 비율")
  return(t)
}

t2 <- ScorenRatio(sentiment_2)
t3 <- ScorenRatio(sentiment_3)
t4 <- ScorenRatio(sentiment_4)
t5 <- ScorenRatio(sentiment_5)
t6 <- ScorenRatio(sentiment_6)
t7 <- ScorenRatio(sentiment_7)
t8 <- ScorenRatio(sentiment_8)
```


```javascript
res <- rbind(t2, t3, t4, t5, t6, t7, t8)
res <- as.data.frame(res)
rownames(res) <- c(2:8)
res[4] <- round(res[4]*100, 2)
res[5] <- round(res[5]*100, 2)
res$title <- title[-1]
```

긍정 | 부정 | 중립 | 긍정 비율 | 부정 비율 | title |
---- | ---- | ---- | ---- | ---- | ---- |
2 | 262 | 209 | 47 | 50.58 | 40.35 | 2R 레바논전 |
3 | 458 | 490 | 102 | 43.62 | 46.67 | 3R 시리아전 |
4 | 313 | 375 | 71 | 41.24 | 49.41 | 4R 이란전 |
5 | 628 | 347 | 113 | 57.72 | 31.89 | 5R UAE전 |
6 | 508 | 225 | 77 | 62.72 | 27.78 | 6R 이라크전 |
7 | 177 | 129 | 44 | 50.57 | 36.86 | 7R 레바논전 |
8 | 246 | 196 | 57 | 49.30 | 39.28 | 8R 시리아전 |



#### 경기 영상별 댓글의 긍정 비율 시각화
```javascript
ggplot(res, aes(x = title, y = `긍정 비율`)) +
  geom_bar(fill = "#73C6B6", colour = "#52BE80", stat = "identity") +
  geom_text(label = paste0(res$`긍정 비율`, "%"), nudge_y = 3) +
  labs(title = "경기 영상별 댓글의 긍정 비율") +
  xlab("") + 
  ylab("") + 
  theme(text = element_text(size = 15),
        panel.background = element_blank(),
        legend.position = "none",
        axis.ticks = element_blank(),
        axis.text.y = element_blank())
```
