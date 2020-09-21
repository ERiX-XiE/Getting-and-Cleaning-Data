# # myapp = oauth_app("twitter", key="yourConsumerKetyHere",secret="yourConsumerSecretHere")
# # sig = sign_oauth1.0(myapp,token="yourTokenHere",token_secret="yourTokenSecretHere")
# # homeTL = GET("https//api.twitter.com/1.1/statuses/home_timeline.json",sig)
# 
#   library(httr)
# 
# # 1. Find OAuth settings for github:
# #    http://developer.github.com/v3/oauth/
# oauth_endpoints("github")
# 
# # 2. To make your own application, register at
# #    https://github.com/settings/developers. Use any URL for the homepage URL
# #    (http://github.com is fine) and  http://localhost:1410 as the callback url
# #
# #    Replace your key and secret below.
# myapp <- oauth_app("app for Getting and Cleaning Data",
#                    key = "544bacffdfa043244156",
#                    secret = "e24bfd1ea0ff516fdcfd8c5d56f460063211f483"
# )
# 
# # 3. Get OAuth credentials
# github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
# 
# # 4. Use API
# gtoken <- config(token = github_token)
# req <- GET("https://api.github.com/users/jtleek/repos", gtoken) 
# # to : https://api.github.com/users/jtleek/repos, in demo:https://api.github.com/rate_limit
# stop_for_status(req)
# content(req)
# 
# # OR:
# req <- with_config(gtoken, GET("https://api.github.com/rate_limit"))
# stop_for_status(req)
# content(req)
# 
# n <- rep(0,4)
# for ( i in c(1:3)) {
#   n[i] <- nchar(htmlCode[i * 10])
# }
# n[4] <- nchar(htmlCode[100])
for_file_data <- read.fwf("/Users/sirerix/Documents/Coursera-jhu/Getting-and-Cleaning-Data/week2/getdata-wksst8110.for",
                          widths = c(28,4,1),skip = 4)
head(for_file_data)