
# Gertting and Cleaning Data Week 2 quiz

library(httr)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at at
#    https://github.com/settings/applications. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
myapp <- oauth_app("github",
                   key = "e62ef3ebb66ec831d3b6",
                   secret = "2fb2e4c8993fcfc59873f4ca9225220bbf9a872f")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
content <- content(req)

# Question 1: find the time that the datasharing repo was created 
content[[5]]$created_at

# Question 2:
acs <- read.csv("data/getdata-data-ss06pid.csv")
sum(acs[acs$AGEP < 50,]$pwgtp1) # Test: sum the pgtw2 column the old way
sum(sqldf("select pwgtp1 from acs where AGEP < 50")) # Answer

# Question 3:
sum(unique(acs$AGEP)) # Test: sum the pgtw2 column the old way
sum(sqldf("select distinct AGEP from acs")) # Answer

# Question 4
con = url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode = readLines(con)
close(con)
sapply(htmlCode[c(10,20,30,100)], nchar)

# Question 5
x <- read.fwf(
            file=url("http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for"),
            skip=4,
            widths=c(12, 7,4, 9,4, 9,4, 9,4))

sum(x[,4])
