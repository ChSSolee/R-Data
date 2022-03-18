## 뉴스 키워드 분석 (Naver API)

### 자연어 처리
#### 절차

- 불용어 : 불필요한 용어
- 형태소 분석 (Stemming) : 공통 어간을 가지는 단어를 묶는 작업을 Stemming
- 형태소 분석을 진행하기 위해 말뭉치 사전(Corpus) 필요, (SejongDic, NIADic)
- 정제된 텍스트 데이터는 n차원의 행렬로 구성 -> VSM(벡터 공간 모델), TVM(단어 벡터 모델) (Bag-of-words, N-gram, Ontology-based)
- 벡터 공간 모델의 차원을 축소 -> 분류(Document Classification), 감성 분석 (SNA)


```R
library(rJava)
library(httr)
library(KoNLP)
```

#### 네이버 오픈 API 종류 : https://developers.naver.com/docs/common/openapiguide/apilist.md
#### 네이버 뉴스 검색 API
### 관심 토픽 : 황의조


```R
URL = "https://openapi.naver.com/v1/search/news.json?" 
search = "황의조" 
```


```R
news = GET(url = URL,  # URL
           add_headers("X-Naver-Client-Id" = cId,
                       "X-Naver-Client-Secret" = cSec),
           query = list(query = search,  # 키워드
                        display = 100,  # 100개
                        start = 1,  # 검색 결과 몇 번째 페이지 부터 조회할지 결정
                        sort = "date"))  # 날짜순 정렬
```


```R
httr::content(news)$total # 전체 뉴스 건수
```


67635



```R
names(httr::content(news))
```


<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>'lastBuildDate'</li><li>'total'</li><li>'start'</li><li>'display'</li><li>'items'</li></ol>




```R
head(httr::content(news)$item)
```


<ol>
	<li><dl>
	<dt>$title</dt>
		<dd>'이제는 영혼의 파트너! &lt;b&gt;황의조&lt;/b&gt;-조규성, 이란 격파 선봉장으로'</dd>
	<dt>$originallink</dt>
		<dd>'https://sports.donga.com/article/all/20220315/112343355/2'</dd>
	<dt>$link</dt>
		<dd>'https://sports.news.naver.com/news.nhn?oid=382&amp;aid=0000966725'</dd>
	<dt>$description</dt>
		<dd>'팀 조직이 탄탄하고 수비가 뛰어난 이란을 격파할 선봉에는 &lt;b&gt;황의조&lt;/b&gt;(30·보르도)와 조규성(24·김천 상무)이... 월드컵 본선 체제로 전환을 앞둔 시점에서 아시아권에서 가장 강한 상대와 결전에 맞춰 &lt;b&gt;황의조&lt;/b&gt;와 조규성을... '</dd>
	<dt>$pubDate</dt>
		<dd>'Wed, 16 Mar 2022 07:01:00 +0900'</dd>
</dl>
</li>
	<li><dl>
	<dt>$title</dt>
		<dd>'\'국대 발탁\' 조규성, &amp;quot;&lt;b&gt;황의조&lt;/b&gt;는 내 우상, 골로 증명하겠다&amp;quot;'</dd>
	<dt>$originallink</dt>
		<dd>'http://www.fourfourtwo.co.kr/news/articleView.html?idxno=11351'</dd>
	<dt>$link</dt>
		<dd>'https://sports.news.naver.com/news.nhn?oid=411&amp;aid=0000007713'</dd>
	<dt>$description</dt>
		<dd>'조규성을 대신해 도쿄올림픽 와일드카드 공격수로 출전했던 &lt;b&gt;황의조&lt;/b&gt;와도 아이러니하게 국가대표팀에서 만나며 경쟁자이자 좋은 선후배, 동료로서의 모습을 보이기도 했다. 조규성은 &amp;quot;&lt;b&gt;황의조&lt;/b&gt; 선수는 어렸을 때부터... '</dd>
	<dt>$pubDate</dt>
		<dd>'Wed, 16 Mar 2022 04:04:00 +0900'</dd>
</dl>
</li>
	<li><dl>
	<dt>$title</dt>
		<dd>'메시 아버지, “바르셀로나와 메시 복귀 논의 중”'</dd>
	<dt>$originallink</dt>
		<dd>'http://www.osen.co.kr/article/G1111785625'</dd>
	<dt>$link</dt>
		<dd>'https://sports.news.naver.com/news.nhn?oid=109&amp;aid=0004572689'</dd>
	<dt>$description</dt>
		<dd>'PSG는 13일 파리에서 열린 ‘2021-22 리그앙 28라운드’에서 &lt;b&gt;황의조&lt;/b&gt;가 뛴 보르도를 3-0으로 이겼다. 승점 65점의 PSG는 여전히 압도적인 리그 선두다. 스리톱으로 나선 킬리안 음바페와 네이마르는 나란히 골맛을 봤다.... '</dd>
	<dt>$pubDate</dt>
		<dd>'Tue, 15 Mar 2022 23:09:00 +0900'</dd>
</dl>
</li>
	<li><dl>
	<dt>$title</dt>
		<dd>'\'물오른 활약상에 의욕 충만\' 조규성, &amp;quot;이란·UEA전 모두 득점 노리겠다&amp;quot;'</dd>
	<dt>$originallink</dt>
		<dd>'https://www.goal.com/kr/뉴스/a/bltdb3c96378203de62'</dd>
	<dt>$link</dt>
		<dd>'https://sports.news.naver.com/news.nhn?oid=216&amp;aid=0000120364'</dd>
	<dt>$description</dt>
		<dd>'조규성을 대신해 도쿄올림픽 와일드카드 공격수로 출전했던 &lt;b&gt;황의조&lt;/b&gt;(29·지롱댕 드 보르도)와도 아이러니하게 국가대표팀에서 만나며 경쟁자이자 좋은 선후배, 동료로서의 모습을 보이기도 했다. 조규성은 &amp;quot;&lt;b&gt;황의조&lt;/b&gt;... '</dd>
	<dt>$pubDate</dt>
		<dd>'Tue, 15 Mar 2022 22:14:00 +0900'</dd>
</dl>
</li>
	<li><dl>
	<dt>$title</dt>
		<dd>'\'국가대표\' 조규성-박지수-권창훈, &amp;quot;수사불패 정신으로 임하겠다&amp;quot;'</dd>
	<dt>$originallink</dt>
		<dd>'http://www.fourfourtwo.co.kr/news/articleView.html?idxno=11340'</dd>
	<dt>$link</dt>
		<dd>'https://sports.news.naver.com/news.nhn?oid=411&amp;aid=0000007702'</dd>
	<dt>$description</dt>
		<dd>'이번에도 &lt;b&gt;황의조&lt;/b&gt;와 함께 단 두 명의 공격수로 국가대표에 발탁되며 본인의 가치를 증명한 조규성은 &amp;quot;대표팀 발탁은 언제나 영광스럽다. 매 순간 초심을 잃지 않고 팀과 함께 더 나아가도록 하겠다&amp;quot;고 발탁 소감을... '</dd>
	<dt>$pubDate</dt>
		<dd>'Tue, 15 Mar 2022 20:27:00 +0900'</dd>
</dl>
</li>
	<li><dl>
	<dt>$title</dt>
		<dd>'\'보르도에게 대재앙\'…몽펠리에, &lt;b&gt;황의조&lt;/b&gt; 영입 고려'</dd>
	<dt>$originallink</dt>
		<dd>'http://www.mydaily.co.kr/new_yk/html/read.php?newsid=202203151905774364&amp;ext=na&amp;utm_campaign=naver_news&amp;utm_source=naver&amp;utm_medium=related_news'</dd>
	<dt>$link</dt>
		<dd>'https://sports.news.naver.com/news.nhn?oid=117&amp;aid=0003584857'</dd>
	<dt>$description</dt>
		<dd>'프랑스 리그1의 몽펠리에가 &lt;b&gt;황의조&lt;/b&gt; 영입을 고려하는 것으로 전해졌다. 프랑스 매체 지롱댕포에버는 15일(한국시간) 몽펠리에의 &lt;b&gt;황의조&lt;/b&gt; 영입설을 전했다. &lt;b&gt;황의조&lt;/b&gt;는 프랑스 리그1에서 두시즌 연속 10골 고지를 돌파한... '</dd>
	<dt>$pubDate</dt>
		<dd>'Tue, 15 Mar 2022 19:07:00 +0900'</dd>
</dl>
</li>
</ol>



 <br/>
 
 
### 뉴스 페이지 첫 번쨰 페이지 부터 열 번쨰 페이지 까지 총 1000개 뉴스 수집


```R
all_news = data.frame()
for(i in 1:10){
  param = list(query = search,
               display = 100,
               start = i, # 첫 번쨰 페이지 부터 열 번쨰 페이지 까지 총 1000개
               sort = "date")
  news = GET(url = URL,
             add_headers("X-Naver-Client-Id" = cId,
                         "X-Naver-Client-Secret" = cSec),
             query = param)
  body = data.frame(t(sapply(httr::content(news)$item, data.frame)))
  all_news = rbind(all_news, body)
  Sys.sleep(0.1)
}
dim(all_news)
```


<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>1000</li><li>5</li></ol>




```R
names(all_news)
```


<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>'title'</li><li>'originallink'</li><li>'link'</li><li>'description'</li><li>'pubDate'</li></ol>




```R
all_news$title[1:10]
```


<ol>
	<li>'이제는 영혼의 파트너! &lt;b&gt;황의조&lt;/b&gt;-조규성, 이란 격파 선봉장으로'</li>
	<li>'\'국대 발탁\' 조규성, &amp;quot;&lt;b&gt;황의조&lt;/b&gt;는 내 우상, 골로 증명하겠다&amp;quot;'</li>
	<li>'메시 아버지, “바르셀로나와 메시 복귀 논의 중”'</li>
	<li>'\'물오른 활약상에 의욕 충만\' 조규성, &amp;quot;이란·UEA전 모두 득점 노리겠다&amp;quot;'</li>
	<li>'\'국가대표\' 조규성-박지수-권창훈, &amp;quot;수사불패 정신으로 임하겠다&amp;quot;'</li>
	<li>'\'보르도에게 대재앙\'…몽펠리에, &lt;b&gt;황의조&lt;/b&gt; 영입 고려'</li>
	<li>'조규성이 밝힌 꾸준한 대표팀 승선 배경… “자신감과 웨이트”'</li>
	<li>'\'서울E 최초 국대 발탁\' 이재익, &amp;quot;구단 역사에 한 획, 들뜨지 않을게요&amp;quot;'</li>
	<li>'원점으로 돌아간 벤투호…원톱은 누가 될까?'</li>
	<li>'[김남구의 유럽통신] 보르도 감독, “&lt;b&gt;황의조&lt;/b&gt;, 개선할 미세한 부분 많아”'</li>
</ol>





### 텍스트 전처리
- gsub("[\r\n\t]", ' ', news) : 이스케이프 제거
- gsub('[[:punct:]]', ' ', news_pre) : 문장부호 제거
- gsub('[[:cntrl:]]', ' ', news_pre) : 특수문자 제거
- gsub('\\\\d+', ' ', news_pre) : 숫자 제거  
- gsub('[a-z]+', ' ', news_pre) : 영 대문자 제거
- gsub('[A-Z]+', ' ', news_pre) : 영 소문자 제거
- gsub('\\\\s+', ' ', news_pre) : 2개 이상 공백 교체


```R
pat = "<b>|</b>|&quot;|Q&amp;A" ; rep = " "
title = gsub(pattern = pat, replacement = rep, x = all_news$title)
title <- gsub('[[:punct:]]', replacement = rep, title) 
title <- gsub("개월", replacement = rep, title)
title <- gsub("UEA", replacement = "UAE", title)
title <- gsub('[[:cntrl:]]', replacement = rep, title) 
title <- gsub('\\d+', replacement = rep, title)
head(title, 10)
```


<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li><span style=white-space:pre-wrap>'이제는 영혼의 파트너   황의조  조규성  이란 격파 선봉장으로'</span></li><li><span style=white-space:pre-wrap>' 국대 발탁  조규성    황의조 는 내 우상  골로 증명하겠다 '</span></li><li><span style=white-space:pre-wrap>'메시 아버지   바르셀로나와 메시 복귀 논의 중 '</span></li><li><span style=white-space:pre-wrap>' 물오른 활약상에 의욕 충만  조규성   이란 UAE전 모두 득점 노리겠다 '</span></li><li><span style=white-space:pre-wrap>' 국가대표  조규성 박지수 권창훈   수사불패 정신으로 임하겠다 '</span></li><li><span style=white-space:pre-wrap>' 보르도에게 대재앙  몽펠리에   황의조  영입 고려'</span></li><li><span style=white-space:pre-wrap>'조규성이 밝힌 꾸준한 대표팀 승선 배경   자신감과 웨이트 '</span></li><li><span style=white-space:pre-wrap>' 서울E 최초 국대 발탁  이재익   구단 역사에 한 획  들뜨지 않을게요 '</span></li><li>'원점으로 돌아간 벤투호 원톱은 누가 될까 '</li><li><span style=white-space:pre-wrap>' 김남구의 유럽통신  보르도 감독    황의조   개선할 미세한 부분 많아 '</span></li></ol>



<br/>


### 사전 설정
(SejongDic, NIADic)


```R
useNIADic()  # useSejongDic()
```

    Backup was just finished!
    1213109 words dictionary was built.
    

#### 명사 추출


```R
noun_list = extractNoun(title); head(noun_list)
```


<ol>
	<li><style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>'영혼'</li><li>'파트너'</li><li>'황의조'</li><li>'조규'</li><li>'성'</li><li>'이란'</li><li>'격파'</li><li>'선봉장'</li><li>'로'</li></ol>
</li>
	<li><style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>'국대'</li><li>'발탁'</li><li>'조규'</li><li>'성'</li><li>'황의조'</li><li>'내'</li><li>'우상'</li><li>'증명하겠'</li></ol>
</li>
	<li><style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>'메시'</li><li>'아버지'</li><li>'바르셀로나'</li><li>'메시'</li><li>'복귀'</li><li>'논'</li><li>'중'</li></ol>
</li>
	<li><style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>'활약상'</li><li>'의욕'</li><li>'충만'</li><li>'조규'</li><li>'성'</li><li>'이란'</li><li>'UAE'</li><li>'전'</li><li>'득점'</li><li>'노리겠'</li></ol>
</li>
	<li><style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>'국가대표'</li><li>'조규'</li><li>'성'</li><li>'박지수'</li><li>'권창훈'</li><li>'수사'</li><li>'불패'</li><li>'정신'</li><li>'임하겠'</li></ol>
</li>
	<li><style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>'보르도'</li><li>'대재앙'</li><li>'몽펠리에'</li><li>'황의조'</li><li>'영입'</li><li>'려'</li></ol>
</li>
</ol>




```R
tail(noun_list)
```


<ol>
	<li><style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>'메시'</li><li>'네이마르'</li><li>'야유'</li><li>'PSG'</li><li>'DF'</li><li>'야유'</li><li>'이해'</li><li>'한'</li></ol>
</li>
	<li><style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>'수원FC'</li><li>'박민규'</li><li>'벤투호'</li><li>'첫'</li><li>'발'</li></ol>
</li>
	<li><style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>'손흥민'</li><li>'지원사'</li><li>'격'</li><li>'K'</li><li>'리거'</li><li>'들'</li><li>'맡겼'</li></ol>
</li>
	<li><style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>'유럽파'</li><li>'황의조'</li><li>'vs'</li><li>'상승세'</li><li>'조규'</li><li>'성'</li><li>'국대'</li><li>'스트라이커'</li><li>'경쟁'</li><li>'파'</li></ol>
</li>
	<li><style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>'벤투호'</li><li>'손흥민'</li><li>'황희'</li><li>'찬'</li><li>'등'</li><li>'해외파'</li><li>'호출'</li><li>'이란'</li><li>'전'</li><li>'최정예'</li><li>'명단'</li><li>'공'</li><li>'개'</li></ol>
</li>
	<li><style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>'리그'</li><li>'G'</li><li>'골'</li><li>'폭발'</li><li>'벤투호'</li><li>'승선'</li><li>'조규'</li><li>'성'</li><li>'팀'</li><li>'짐'</li></ol>
</li>
</ol>





#### 사전에 단어 추가


```R
term <- c("조규성", "벤투호", "바르셀로나", "K리거", "K-리거", "이강인", 
          "황희찬", "이란", "UAE", "바르셀로나", "GK", "DF", "MF", "FW", 
          "해외파", "공개", "지원사격", "공격수", "골키퍼", "미드필더", "수비수", "코치", "팬들", "효민",
         "의욕충만", "의욕 충만", "선발", "증명하겠다", "노리겠다", "임하겠다", "서울E", "선봉장", "티아라")
userDic <- data.frame(term = term, tag = "ncn")
```


```R
buildDictionary(ext_dic = c("NIADic", "woorimalsam", "insighter", "sejong"),
                user_dic = userDic,
                replace_usr_dic = T)
```

    1070053 words dictionary was built.
    



#### 사전에 단어 추가 후 다시 명사 추출


```R
noun_list = extractNoun(title); head(noun_list)
```


<ol>
	<li><style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>'영혼'</li><li>'파트너'</li><li>'황의조'</li><li>'조규성'</li><li>'이란'</li><li>'격파'</li><li>'선봉장'</li><li>'로'</li></ol>
</li>
	<li><style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>'국대'</li><li>'발탁'</li><li>'조규성'</li><li>'황의조'</li><li>'내'</li><li>'우상'</li><li>'증명하겠'</li></ol>
</li>
	<li><style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>'메시'</li><li>'아버지'</li><li>'바르셀로나'</li><li>'메시'</li><li>'복귀'</li><li>'논'</li><li>'중'</li></ol>
</li>
	<li><style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>'활약상'</li><li>'의욕'</li><li>'충만'</li><li>'조규성'</li><li>'이란'</li><li>'UAE'</li><li>'전'</li><li>'득점'</li><li>'노리겠'</li></ol>
</li>
	<li><style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>'국가대표'</li><li>'조규성'</li><li>'박지수'</li><li>'권창훈'</li><li>'수사'</li><li>'불패'</li><li>'정신'</li><li>'임하겠'</li></ol>
</li>
	<li><style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>'보르도'</li><li>'대재앙'</li><li>'몽펠리에'</li><li>'황의조'</li><li>'영입'</li><li>'려'</li></ol>
</li>
</ol>




```R
tail(noun_list)
```


<ol>
	<li><style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>'메시'</li><li>'네이마르'</li><li>'야유'</li><li>'PSG'</li><li>'팬들'</li><li>'DF'</li><li>'야유'</li><li>'이해'</li><li>'한'</li></ol>
</li>
	<li><style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>'수원FC'</li><li>'박민규'</li><li>'벤투호'</li><li>'첫'</li><li>'발'</li></ol>
</li>
	<li><style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>'손흥민'</li><li>'지원사격'</li><li>'K'</li><li>'리거'</li><li>'들'</li><li>'맡겼'</li></ol>
</li>
	<li><style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>'유럽파'</li><li>'황의조'</li><li>'vs'</li><li>'상승세'</li><li>'조규성'</li><li>'국대'</li><li>'스트라이커'</li><li>'경쟁'</li><li>'파'</li></ol>
</li>
	<li><style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>'벤투호'</li><li>'손흥민'</li><li>'황희찬'</li><li>'등'</li><li>'해외파'</li><li>'호출'</li><li>'이란'</li><li>'전'</li><li>'최정예'</li><li>'명단'</li><li>'공'</li><li>'개'</li></ol>
</li>
	<li><style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>'리그'</li><li>'G'</li><li>'골'</li><li>'폭발'</li><li>'벤투호'</li><li>'승선'</li><li>'조규성'</li><li>'팀'</li><li>'짐'</li></ol>
</li>
</ol>





#### 명사가 몇 번 등장했는지 확인 (빈도수 테이블)


```R
tb_noun = table(unlist(noun_list))
length(tb_noun)
```


366



```R
df_noun = data.frame(tb_noun)
(head(df_noun))
```


<table class="dataframe">
<caption>A data.frame: 6 × 2</caption>
<thead>
	<tr><th></th><th scope=col>Var1</th><th scope=col>Freq</th></tr>
	<tr><th></th><th scope=col>&lt;fct&gt;</th><th scope=col>&lt;int&gt;</th></tr>
</thead>
<tbody>
	<tr><th scope=row>1</th><td>A  </td><td>40</td></tr>
	<tr><th scope=row>2</th><td>DF </td><td> 6</td></tr>
	<tr><th scope=row>3</th><td>G  </td><td> 1</td></tr>
	<tr><th scope=row>4</th><td>K  </td><td>14</td></tr>
	<tr><th scope=row>5</th><td>N  </td><td>20</td></tr>
	<tr><th scope=row>6</th><td>PSG</td><td>36</td></tr>
</tbody>
</table>




```R
df_noun$Var1 <- as.character(df_noun$Var1)
df_noun <- df_noun[nchar(df_noun$Var1) > 1, ]
```


```R
library(dplyr)
```


```R
df_noun <- df_noun %>% arrange(desc(df_noun$Freq))
```

### "황의조"와 관련된 Top10 키워드


```R
(top10_noun <- head(df_noun, 10))
```


<table class="dataframe">
<caption>A data.frame: 10 × 2</caption>
<thead>
	<tr><th></th><th scope=col>Var1</th><th scope=col>Freq</th></tr>
	<tr><th></th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th></tr>
</thead>
<tbody>
	<tr><th scope=row>1</th><td>벤투호</td><td>347</td></tr>
	<tr><th scope=row>2</th><td>이란  </td><td>296</td></tr>
	<tr><th scope=row>3</th><td>조규성</td><td>233</td></tr>
	<tr><th scope=row>4</th><td>황의조</td><td>212</td></tr>
	<tr><th scope=row>5</th><td>손흥민</td><td>186</td></tr>
	<tr><th scope=row>6</th><td>김천  </td><td>130</td></tr>
	<tr><th scope=row>7</th><td>상무  </td><td>110</td></tr>
	<tr><th scope=row>8</th><td>황희찬</td><td>102</td></tr>
	<tr><th scope=row>9</th><td>발탁  </td><td>100</td></tr>
	<tr><th scope=row>10</th><td>권창훈</td><td> 95</td></tr>
</tbody>
</table>



<br/>

### 시각화
- 두 글자 이상인 것 들에 대해서만 시각화


```R
library(ggplot2)
library(showtext)
```


```R
font_add("nanum", "NanumGothic.ttf")
showtext_auto()
```


```R
ggplot(top10_noun) +
  geom_bar(aes(x = reorder(Var1, -Freq), y = Freq), stat = "identity") +
xlab("키워드") + 
ylab("빈도") + 
theme_light(base_family = "nanum") +
theme(axis.title = element_text(size = 12),
      axis.title.y = element_text(angle = 0, 
                                  vjust = 0.5),
      panel.background = element_blank(),
      panel.grid = element_blank())
```


    
![png](output_38_0.png)
    


<br/>

### 워드클라우드


```R
library(wordcloud2)
library(htmlwidgets)
library(tidyverse)
library(nord)
library(jsonlite)
library(yaml)
library(base64enc)
library(wordcloud)
library(RColorBrewer)
```

#### wordcloud 기본 시각화
- word : 단어
- freq : 단어들의 빈도
- size : 가장빈도가 큰 단어와 빈도가 가장 작은 단어 폰트 사이의 크기 차이
- min.freq : 출력될 단어의 최소 빈도
- max.word : 출력될 단어들의 최대개수
- random.order : TRUE 이면 램덤으로 단어출력, FALSE 이면 빈도수가 큰 단어일수록 중앙에 배치
- random.color : TRUE 이면 단어색은 랜덤순으로 정해지고, FALSE이면 빈도순으로 정해짐
- rot.per : 90도로 회전된 각도로 출력되는 단어의 비율
- colors : 가장 작은 빈도부터 큰 빈도까지의 단어색


```R
wordcloud(words = df_noun$Var1, 
          freq = df_noun$Freq,
          random.order = F, 
          min.freq = 10,  
          colors = brewer.pal(8, "Dark2"))
```


    
![png](output_42_0.png)
    


<br/>

#### wordcloud2 
- data : 단어(word)와 빈도(freq) 컬럼을 갖는 데이터프레임
- size : 폰트 사이즈
- minSize : 서브타이틀 문자열
- gridSize : 그리드 사이즈
- fontFamily : 폰트 지정
- fontWeight : 폰트 볼드체 여부 지정 가능 (normal / bold / 600)
- color : 텍스트 색상 팔레트 (random-dark / random-light / 기타 컬러 벡터)
- backgroundColor : 배경 색 지정
- minRotation : 워드클라우드의 단어들을 회전시키려는 경우, 최소 회전각(rad 단위 입력) (* default : -pi/4)
- maxRotation : 워드클라우드의 단어들을 회전시키려는 경우, 최대 회전각(rad 단위 입력) (* default : pi/4)
- shuffle : (TRUE : 같은 데이터프레임이 주어져도 워드클라우드를 그릴 때마다 다른 결과값 표시)
- rotateRatio : 단어의 회전 확률 조절
- shape : 워드클라우드 형태(도형) 결정 (circle / cardioid / diamond / triangle-forward / triangle / pentagon / star)
- ellipticity : 워드클라우드 셰이프의 평평한 정도
- widgetsize  : 위젯 사이즈
- figPath  : 형태를 이미지 마스크로 지정할 경우, 해당 이미지의 경로와 파일명


```R
wordcloud2(data = df_noun,
           color = "random-light",
           backgroundColor='#F7ECEA',
           shape = "star",
           fontFamily = "맑은고딕",
           fontWeight = 200,
           size = 1,
           widgetsize = c(900, 600))
```






<br/>

#### 이미지 모양대로 wordcloud 생성


```R
wordcloud2(df_noun, figPath = "C:/rp/uijo.png")  
```





<br/>

#### 글씨 모양대로 wordcloud 생성


```R
letterCloud(df_noun, word = "HWANG", size = 1)
```





<br/>

<br/>

## 뉴스 그래프 분석

### 관심 키워드 : 황희찬


```R
URL = "https://openapi.naver.com/v1/search/news.json?"
search = "황희찬"

all_news = data.frame()
for(i in 1:100){
   param = list(query = search,
                display = 100,
                start = i,
                sort = "sim")
   news = GET(url = URL,
              add_headers("X-Naver-Client-Id" = cId,
                          "X-Naver-Client-Secret" = cSec),
              query = param)
   body = data.frame(t(sapply(httr::content(news)$item,
                              data.frame)))
        
   all_news = rbind(all_news, body)
   Sys.sleep(0.1)
}
```


```R
names(all_news)
```


<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>'title'</li><li>'originallink'</li><li>'link'</li><li>'description'</li><li>'pubDate'</li></ol>



#### 날짜 형식 변경


```R
head(all_news$pubDate)
```


<ol>
	<li>'Mon, 14 Mar 2022 06:59:00 +0900'</li>
	<li>'Wed, 16 Mar 2022 06:45:00 +0900'</li>
	<li>'Mon, 14 Mar 2022 07:33:00 +0900'</li>
	<li>'Mon, 14 Mar 2022 15:42:00 +0900'</li>
	<li>'Mon, 14 Mar 2022 01:43:00 +0900'</li>
	<li>'Mon, 14 Mar 2022 11:30:00 +0900'</li>
</ol>




```R
all_news$pubDate = as.Date(unlist(all_news$pubDate), "%a, %d %b %Y")
```


```R
head(all_news$pubDate)
```


<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li><time datetime="2022-03-14">2022-03-14</time></li><li><time datetime="2022-03-16">2022-03-16</time></li><li><time datetime="2022-03-14">2022-03-14</time></li><li><time datetime="2022-03-14">2022-03-14</time></li><li><time datetime="2022-03-14">2022-03-14</time></li><li><time datetime="2022-03-14">2022-03-14</time></li></ol>



### "황희찬"토픽와 관련된 인터넷 뉴스의 수


```R
ggplot(all_news, aes(x = pubDate)) +
   geom_line(stat = "count", color = "#EEEEEE", size = 1.5) + 
   geom_point(stat = "count", color = "#424242", size = 2) +
   geom_text(aes(label = ..count..),
             stat = "count",
             position = position_nudge(y = 150)) +
   labs(title = "황희찬 뉴스 트렌드") +
   xlab("날짜") +
   ylab("") +
   scale_x_date(date_labels = "%m-%d") +
   theme(text = element_text(size = 15),
         panel.background = element_blank(),
         axis.ticks = element_blank())
```


    
![png](output_57_0.png)
    



```R
pat = "<b>|</b>|&quot;|Q&amp;A" ; rep = " "
all_news$title = gsub(pattern = pat, replacement = rep, x = all_news$title)
all_news$title <- gsub('[[:punct:]]', replacement = rep, x = all_news$title) 
all_news$title <- gsub("개월", replacement = rep, x = all_news$title)
all_news$title <- gsub("UEA", replacement = "UAE", x = all_news$title)
all_news$title <- gsub('[[:cntrl:]]', replacement = rep, x = all_news$title) 
all_news$title <- gsub('\\d+', replacement = rep, x = all_news$title)
```


```R
class(all_news$title)
```


'character'



```R
top <- data.frame(1:10)
for(i in 1:length(unique(all_news$pubDate))) {
   sub_news = all_news[all_news$pubDate == sort(unique(all_news$pubDate))[i],]  
   df_target = data.frame(table(unlist(strsplit(sub_news$title, " "))))
   df_target = df_target[order(df_target$Freq, decreasing = TRUE),]
   df_target$Var1 = as.character(df_target$Var1)
   df_target = df_target[nchar(df_target$Var1) > 1 & nchar(df_target$Var1) < 7, ]
   
   top10 = head(df_target, 10)
   if (length(top10) < 10) {
      dif <- nrow(top) - nrow(top10)
      top10 <- data.frame(Var1 <- c(top10$Var1, rep(NA, dif)), Freq <- c(top10$Freq, rep(NA, dif)))
      colnames(top10) = c("Var1", "Freq")
   }
   top <- cbind(top, top10)
}
```


```R
top <- t(top)
top <- top[-1, ]
nrow(top)
```


18



```R
key <- matrix(nrow = length(unique(all_news$pubDate)), ncol = 10)
for (i in 1:nrow(top)) {
   if (i%%2 == 1) {
      k <- i/2 + 1
      key[k,] <- top[i,]
   }
}
rownames(key) <- as.character(unique(all_news$pubDate))
colnames(key) <- paste(c(1:10), "위")
```

### 2022-03-14 ~ 2022-03.05기간 "황희찬"관련 Top10 키워드


```R
key
```


<table class="dataframe">
<caption>A matrix: 9 × 10 of type chr</caption>
<thead>
	<tr><th></th><th scope=col>1 위</th><th scope=col>2 위</th><th scope=col>3 위</th><th scope=col>4 위</th><th scope=col>5 위</th><th scope=col>6 위</th><th scope=col>7 위</th><th scope=col>8 위</th><th scope=col>9 위</th><th scope=col>10 위</th></tr>
</thead>
<tbody>
	<tr><th scope=row>2022-03-14</th><td>감독  </td><td>끊고  </td><td>도전  </td><td>신뢰  </td><td>연패    </td><td>호골        </td><td>황희찬  </td><td>NA        </td><td>NA    </td><td>NA      </td></tr>
	<tr><th scope=row>2022-03-16</th><td>연패  </td><td>황희찬</td><td>풀타임</td><td>수렁  </td><td>부상    </td><td>울버햄프턴은</td><td>회복    </td><td>울버햄프턴</td><td>만에  </td><td>울버햄튼</td></tr>
	<tr><th scope=row>2022-03-15</th><td>황희찬</td><td>상대로</td><td>시즌  </td><td>호골  </td><td>넣은    </td><td>다시        </td><td>데뷔골  </td><td>돌아온    </td><td>왓퍼드</td><td>웃을까  </td></tr>
	<tr><th scope=row>2022-03-13</th><td>황희찬</td><td>도움  </td><td>연패  </td><td>탈출  </td><td>EPL     </td><td>울버햄프턴  </td><td>울버햄튼</td><td>리그      </td><td>왓퍼드</td><td>대승    </td></tr>
	<tr><th scope=row>2022-03-11</th><td>같았다</td><td>극찬  </td><td>동료  </td><td>득점  </td><td>왓포드전</td><td>칸토나      </td><td>황희찬  </td><td>NA        </td><td>NA    </td><td>NA      </td></tr>
	<tr><th scope=row>2022-03-10</th><td>황희찬</td><td>교체  </td><td>부상  </td><td>전반  </td><td>아웃    </td><td>선발        </td><td>충돌    </td><td>에버턴    </td><td>만에  </td><td>부상으로</td></tr>
	<tr><th scope=row>2022-03-06</th><td>황희찬</td><td>부상  </td><td>벤투호</td><td>손흥민</td><td>교체    </td><td>명단        </td><td>울버햄튼</td><td>만에      </td><td>발탁  </td><td>복귀    </td></tr>
	<tr><th scope=row>2022-03-12</th><td>황희찬</td><td>손흥민</td><td>이란  </td><td>뚫는다</td><td>춘천듀오</td><td>만에        </td><td>감독은  </td><td>모르겠다  </td><td>울브스</td><td>재부상  </td></tr>
	<tr><th scope=row>2022-03-05</th><td>교체된</td><td>대표팀</td><td>문제  </td><td>부상  </td><td>소속팀서</td><td>없을까      </td><td>합류는  </td><td>황희찬    </td><td>NA    </td><td>NA      </td></tr>
</tbody>
</table>


