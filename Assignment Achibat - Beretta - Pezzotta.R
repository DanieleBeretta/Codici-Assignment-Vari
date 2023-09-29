### ACHIBAT ASSAN 1086225
### BERETTA DANIELE 1066906
### PEZZOTTA STEFANO 1064888

rm(list=ls())
library(tidyverse)
library(tidytext)
library(wordcloud)
library(widyr)
library(udpipe)
library(RSelenium)
library(rvest)
library(httr)
library(cld2)
library(caret)
library(quanteda.textmodels)
library(quanteda)
library(topicmodels)
library(tm)

#Scraping fastest delivery date ----

setwd()

Driver <- rsDriver(browser = "firefox", chromever = NULL)
remDr <- Driver[["client"]]

url <- "https://www.amazon.co.uk/HP-i5-3470-Windows-Professional-Computer/dp/B07116YQB4/ref=cm_cr_arp_d_product_top?ie=UTF8&th=1#renewedProgramDescriptionBtfSection"
remDr$navigate(url)

buyingopt <- remDr$findElement(using = "css", value = "#buybox-see-all-buying-choices > span:nth-child(1)")
buyingopt$clickElement()
fastestdelivery <- remDr$getPageSource(header = TRUE)
write(fastestdelivery[[1]], file = "fastestdelivery.html")
remDr$close()Driver$server$stop()

webpage <- read_html("fastestdelivery.html", encoding = "utf-8")

webpage %>% html_element(css = "#mir-layout-DELIVERY_BLOCK-slot-PRIMARY_DELIVERY_MESSAGE_LARGE > span:nth-child(1) > span:nth-child(1)") %>% html_text2()

#Product information scraping----

for (i in 1:24)
{
  voiceselector = str_c("#productDetails_techSpec_section_1 > tbody:nth-child(1) > tr:nth-child(", as.character(i), ") > th:nth-child(1)")
  print(webpage %>% html_element(css = voiceselector) %>% html_text2())
  infoselector = str_c("#productDetails_techSpec_section_1 > tbody:nth-child(1) > tr:nth-child(", as.character(i), ") > td:nth-child(2)")
  print(webpage %>% html_element(css = infoselector) %>% html_text2() %>% str_replace(pattern = "\r ", replacement = ""))
}

#Customer ratings scraping----
print(webpage %>% html_element(css = infoselector) %>% html_text2())
print(webpage %>% html_element(css = "#averageCustomerReviews_feature_div > div:nth-child(2) > span:nth-child(3) > a:nth-child(1) > span:nth-child(1)") %>% html_text2())

#Scraping reviews----
rwdocument <- c()
rwtitle <- c()
rwstars <- c()

cookies = c(
  `session-id` = "261-6310633-1636741",
  `session-id-time` = "2082787201l",
  `i18n-prefs` = "GBP",
  `sp-cdn` = "L5Z9:IT",
  `csm-hit` = "tb:XP43KZVPCR8ESRX3KEEC s-8R60KR0WYBQCHBT6JS29^|1686063319159&t:1686063319159&adb:adblk_no",
  `ubid-acbuk` = "260-9426763-5119226",
  `session-token` = "5SdpR2LaNC/Uq6zi1q1lLyqKgVKJ6DnocAB0XQXa6VEkMS8OlXPeRVBbuKxZHXfhYS9HRhzUyFdAiUjAJGb5h6beCtw9CJwqO21cS/ykiCbCO/Bn317z9lwKcX9mqbwx4KsgYyzi9MCbU0lCxuZ04mSHhqoveayH3 iloXGsntUVbxrZXPIFi/F0d8aKIgvOrY4xXaV6jOT5BJ1cjgEW gs aSp8NSGRN6z8fHteKDI=",
  `lc-acbuk` = "en_GB"
)

headers = c(
  `User-Agent` = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/113.0",
  `Accept` = "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8",
  `Accept-Language` = "it-IT,it;q=0.8,en-US;q=0.5,en;q=0.3",
  `Accept-Encoding` = "gzip, deflate, br",
  `Connection` = "keep-alive",
  `Upgrade-Insecure-Requests` = "1",
  `Sec-Fetch-Dest` = "document",
  `Sec-Fetch-Mode` = "navigate",
  `Sec-Fetch-Site` = "none",
  `Sec-Fetch-User` = "?1",
  `TE` = "trailers"
)

params = list(
  `ie` = "UTF8",
  `reviewerType` = "all_reviews",
  `pageNumber` = "1"
)

for (i in 1:90)
{
  params$pageNumber <- as.character(i)
  GETrequest <- str_c("https://www.amazon.co.uk/product-reviews/B07116YQB4/ref=cm_cr_arp_d_paging_btm_next_", as.character(i))
  res <- httr::GET(url = GETrequest, httr::add_headers(.headers=headers), query = params, httr::set_cookies(.cookies = cookies))
  content <- httr::content(res, as = "text")
  content <- read_html(content, encoding="utf-8")
  rwdocument <- c(rwdocument, content %>% html_elements("[class='a-size-base review-text review-text-content']") %>% html_text2())
  rwtitle <-c(rwtitle, content %>% html_elements("[data-hook='review-title']") %>% html_elements("span") %>% html_text2())
  rwstars <-c(rwstars, content %>% html_elements("[data-hook='review-star-rating']") %>% html_elements("[class='a-icon-alt']") %>% html_text2() %>% str_remove_all(pattern = ' out of 5 stars') )
}

indexes = seq(from = 3, to=length(rwtitle), by=3)
rwtitle = rwtitle[indexes]
reviews.original <- tibble(rwtitle, rwdocument, rwstars)
reviews.original$rwtitlelang = detect_language(reviews.original$rwtitle)
reviews.original$rwdocumentlang = detect_language(reviews.original$rwdocument)

#Converting stars into numbers ----

reviews.original = reviews.original %>% mutate(score = as.numeric(substring(rwstars, 1, 1)))

#Assessing reviws sentiment ----

reviews.original = reviews.original %>% mutate(sentiment = ifelse(score>=4, "positive", "negative"))

#write_csv(tibbleresults, "results.csv")
#Import the csv in order to implement the SA
#reviews.original <- read.csv("C:/Users/dapaf/OneDrive/Desktop/Nuova cartella (3)/reviews.csv")
View(reviews.original)

#Rename the column
reviews.original=reviews.original%>%rename(title=rwtitle,
                          comments=rwdocument,
                          language_title=rwtitlelang,
                          language_document=rwdocumentlang)
View(reviews.original)

#Add a column with the sentiments (If the stars are 4 or 5, it's positive)
reviews.original=reviews.original%>%
  mutate(sentiment.conv=ifelse(rwstars<4, "negative", "positive"))


View(reviews.original)

#Convert all to lower case. This needs in order to have a better
#cleaning and uniformity for the analysis(when we count the most frequent term)
reviews.original$comments=str_to_lower(reviews.original$comments)

#Select only the most important columns (column, sentiment) 
#for the analysis and create an ID variable
reviews.mod=reviews.original%>%mutate(ID=seq_along(comments))%>%
  select(ID,comments,sentiment.conv,rwstars)
View(reviews.mod)
#Clean the data
#before removing the stopwords
tidy.reviews=reviews.mod%>%unnest_tokens(word, comments)
View(tidy.reviews)
length(tidy.reviews$word)
#Observe the most common words
tidy.reviews%>%count(word, sort=T)%>%head(10)
#we have 37193 words before removing all stopwords

#after removing the stopwords
tidy.reviews1=reviews.mod%>%unnest_tokens(word,comments)%>%
  anti_join(stop_words)
View(tidy.reviews1)
length(tidy.reviews1$word)
#we have 14212 words after removing all stopwords

#after removing the digits
tidy.reviews1=tidy.reviews1%>%filter(!str_detect(word, "[:digit:]"))
View(tidy.reviews1)
length(tidy.reviews1$word)
#we have 13392 words after cleaning the data by removing the digits

#Observe the most common words in the reviews
freq.df=tidy.reviews1%>%count(word,sort=T)
head(freq.df,10)

#Provide a geom_col plot about the most frequent terms
freq.df%>%filter(n>70)%>%ggplot(aes(word,n, fill=factor(word)))+
  geom_col(show.legend=F)+
  xlab(NULL)+
  ylab("Frequency of words")+
  ggtitle("Most common words in the reviews")+
  coord_flip()

#Provide a wordcloud of the top 100 most frequent terms
dev.new(width=2550, height=1345, unit="px")
wordcloud(freq.df$word, freq.df$n, colors=brewer.pal(8, "Accent"),
          random.order=F,min.freq=5, max.words=100)

### SA WITH BING DICTIONARY
#Implement a dictionary-based approach with "bing"
bing=get_sentiments("bing")
View(bing)

#Observe the word that are in the bing dictionary to perform SA
rev.pol=tidy.reviews1%>%inner_join(bing, by= "word")
View(rev.pol)

rev.pol=rev.pol%>%
  select(ID, word, sentiment)
View(rev.pol)

#Observe how much each word contribute for each sentiment
rev.word.count=tidy.reviews1%>%inner_join(bing)%>%count(word,sentiment, sort=T)
head(rev.word.count)

#observe a geom_col plot
rev.word.count%>%group_by(sentiment)%>%top_n(15)%>%
  mutate(word=reorder(word,n))%>%
  ggplot(aes(word,n, fill=factor(sentiment)))+
  geom_col(show.legend=F)+
  facet_wrap(~sentiment, scales="free_y")+
  xlab(NULL)+
  ylab("contribution to sentiment")+
  coord_flip()

#Make a comparison cloud of most frequent terms for each sentiment
dev.new(width=2230, height=1250, unit="px")
rev.word.count%>%pivot_wider(names_from=sentiment, values_from=n, values_fill=0)%>%
  column_to_rownames(var="word")%>%
  comparison.cloud(max.words=100, colors=c("green2", "red1"))


#Preprocess the data and associate a dataset to the words according to the lexicon bing
rev.pol=rev.pol%>%count(ID,sentiment)
View(rev.pol)



#Produce a new dataset with one line for each ID and two variable
#with the number of positives and negatives reviews
rev.pol=rev.pol%>%pivot_wider(names_from=sentiment, values_from = n,
                              values_fill = 0)
dim(rev.pol)

#Compute the polarity of the reviews
rev.pol=rev.pol%>%mutate(sentiment.bing.tidy=positive-negative)
View(rev.pol)

rev.pol=rev.pol%>%mutate(sentiment.bing.tidyw=ifelse(sentiment.bing.tidy>0, "positive", 
                                                    ifelse(sentiment.bing.tidy==0, "neutral", "negative")))
View(rev.pol)
#Observe the number of positive and negative reviews of reviews
rev.pol%>%count(sentiment.bing.tidyw)

#Add two columns referring to the polarity of bing(tidy approach) 
#in the dataset with all the reviews. One column measures the polarity in numbers and the other in
#the classic classification: positive,negative, neutral
View(reviews.mod)
reviews.mod=reviews.mod%>%left_join(rev.pol%>%select(ID,sentiment.bing.tidy, sentiment.bing.tidyw))
View(reviews.mod)

#Observe the comparison table between the polarity according to bing and the conventional 
#according to the division of stars
tabcomp1=table(CONV=reviews.mod$sentiment.conv, BING=reviews.mod$sentiment.bing.tidyw)
tabcomp1

### UDPIPE DICTIONARY
#Set UTF-8 as encoding for comments in reviews
reviews.mod$comments=iconv(reviews.mod$comments, to="UTF-8")

# Preprocess data to apply the udpipe function
data=tibble(doc_id=1:nrow(reviews.mod), text=reviews.mod$comments)
output=udpipe(data, "english-gum")
View(output)

bing=get_sentiments("bing")
bing_dict=bing%>%mutate(sentiment=ifelse(sentiment=="negative",-1,1))%>%
  rename(term="word", polarity="sentiment")
View(bing_dict)

#Provide udpipe analysis without any negators, amplifiers and weights. 
# We focus on the tokens, in order to compare with the tidy approach
scores_bing=txt_sentiment(output, term="token",
                                        polarity_terms = bing_dict,
                                        polarity_negators="",
                                        polarity_amplifiers="",
                                        polarity_deamplifiers ="",
                                        amplifier_weight = 0.8,
                                        n_before=0,
                                        n_after=0,
                                        constrain=F)
data$bing=scores_bing$overall$sentiment_polarity

#Provide udpipe analysis with negators, amplifiers, deamplifiers and weights
scores_udpipe=txt_sentiment(output, term="token",
                            polarity_terms = bing_dict,
                            polarity_negators=c("without","nor",
                                                "no", "never", "not",
                                                "neither", "nor"),
                            polarity_amplifiers=c("great", "very", "super",
                                                  "wonderful", "really", "definitely"),
                            polarity_deamplifiers = c("hardly", "barely", "slightly", "somewhat"),
                            amplifier_weight = 0.8,
                            n_before=3,
                            n_after=3,
                            constrain=F)
data$udpipe=scores_udpipe$overall$sentiment_polarity
reviews.mod$sent.udpipe=data$udpipe



#Observe the graphical representation to compare the sentiment analysis for the different approaches
par(mfrow=c(1,2))
hist(scale(reviews.mod$sentiment.bing.tidy), col="green3", xlab="polarity tidy bing", main="Sentiment distribution-Bing")
hist(scale(reviews.mod$sent.udpipe), col="red3", xlab="polarity udpipe", main="Sentiment distribution-Udpipe")
length(reviews.mod$sent.udpipe)
length(reviews.mod$sentiment.bing.tidy)
reviews.mod=reviews.mod%>%mutate(bing_pol=ifelse(sentiment.bing.tidy>0, "positive", ifelse(sentiment.bing.tidy==0, "neutral", "negative")),
              udpipe_pol=ifelse(sent.udpipe>0, "positive", ifelse(sent.udpipe==0, "neutral", "negative")))

#count number of positive and negative reviews for the udpipe approach
reviews.mod%>%count(udpipe_pol)

#observe the comparison table between the polarity according to the tidy bing approach 
# and th udpipe with negators, amplifiers and deamplifiers
tab_class=table(reviews.mod$bing_pol, reviews.mod$udpipe_pol)
tab_class
confusionMatrix(tab_class)



###LDA

# Build the Dtm (Document Term Matrix) in order to launch the LDA model
View(tidy.reviews1)

rev.dtm=tidy.reviews1%>%count(ID,word)%>%cast_dtm(ID,word,n)
lda_rev <- LDA(rev.dtm, k=2, control=list(seed=1102))  
lda_rev
class(lda_rev)

# Observe the per word per topic probabilities for each document and 
#observe the most frequent terms for each topic
rev_topics=tidy(lda_rev, matrix="beta")

rev_topics

rev_top_terms=rev_topics%>%group_by(topic)%>%
  slice_max(beta, n=10)%>%ungroup()%>%arrange(topic, -beta)
rev_top_terms

rev_top_terms%>%mutate(term=reorder(term,beta))%>%
  ggplot(aes(term,beta, fill=factor(topic)))+
  geom_col(show.legend=F)+
  facet_wrap(~topic, scales="free")+
  coord_flip()

# Observe the per topic per document probabilities and count 
#how many documents are made by topic 1
# and how many documents are made by topic 2
rev_document=tidy(lda_rev, matrix="gamma")

rev_document%>%arrange(desc(topic))

doc_class <- rev_document %>%
  group_by(document) %>%
  slice_max(gamma) %>%
  ungroup() %>%
  arrange(as.numeric(document))


doc_class <- doc_class %>%
  anti_join(doc_class %>%
              select(document) %>%
              mutate(dup = duplicated(document)) %>%
              filter(dup == "TRUE"))



doc_ass <- reviews.mod %>%
  mutate(id = as.character(ID)) %>%
  rename(document = "id") %>%
  inner_join(doc_class)

doc_ass

doc_ass%>%count(topic)

# Observe the word assignment to each topic 
assignments=augment(lda_rev, rev.dtm)
head(assignments,10)

