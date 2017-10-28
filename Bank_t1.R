# Analysis of Bank Marketing Dataset


# Identification of marketing attributes : Portugese Banking 

## Introduction

## Objective
To build a classifier model to identify factors that would allow the bank to devise a more 
efficient and precise campaign strategy to help reduce the costs and improve the profits its "Term Deposit Product". 

## Dataset Description
The dataset is taken from [UCI MACHINE LEARNING REPOSITORY](https://archive.ics.uci.edu/ml/datasets/bank+marketing).             
The dataset has 45211 records spread across 17 variables. A brief description of the variables is as below:

rm(list=ls())
library(dplyr) # for data manipluation
library(tidyr)
library(readr) # for reading csv file
library(ggplot2) # for plotting
library(rpart) # for decision tree classification
library(rpart.plot) # for plotting tree
library(caret) # for getting accuracy/specificity/sensitivity of model
library(pROC) # for plotting ROC curve of model
library(ROCR)
library(lubridate)
library(ggthemes)
library(class) # knn algorithm



# Set the working directory and load dataset
setwd("/Users/Deepika/Desktop/Learning/Projects/Bank")

bank <- read.csv("bank-full.csv")


# Explore data set
names(bank)
dim(bank)
str(bank)
any(is.na(bank))
head(bank)
# Check for any NA's under each column
summary(bank)

# Description of dataset attributes
1 - age (numeric)
2 - job : type of job (categorical: 'admin.','blue-collar','entrepreneur','housemaid','management','retired','self-employed','services','student','technician','unemployed','unknown')
3 - marital : marital status (categorical: 'divorced','married','single','unknown'; note: 'divorced' means divorced or widowed)
4 - education (categorical: 'basic.4y','basic.6y','basic.9y','high.school','illiterate','professional.course','university.degree','unknown')
5 - default: has credit in default? (categorical: 'no','yes','unknown')
6 - housing: has housing loan? (categorical: 'no','yes','unknown')
7 - loan: has personal loan? (categorical: 'no','yes','unknown')

# related with the last contact of the current campaign:
8 - contact: contact communication type (categorical: 'cellular','telephone') 
9 - month: last contact month of year (categorical: 'jan', 'feb', 'mar', ..., 'nov', 'dec')
10 - day_of_week: last contact day of the week (categorical: 'mon','tue','wed','thu','fri')
11 - duration: last contact duration, in seconds (numeric). 
Important note: this attribute highly affects the output target (e.g., if duration=0 then y='no'). 
Yet, the duration is not known before a call is performed. 
Also, after the end of the call y is obviously known. 
Thus, this input should only be included for benchmark purposes and should be discarded 
if the intention is to have a realistic predictive model.

# other attributes:
12 - campaign: number of contacts performed during this campaign and for this client (numeric, includes last contact)
13 - pdays: number of days that passed by after the client was last contacted from a previous campaign (numeric; 999 means client was not previously contacted)
14 - previous: number of contacts performed before this campaign and for this client (numeric)
15 - poutcome: outcome of the previous marketing campaign (categorical: 'failure','nonexistent','success')

#Output variable (desired target):
17- y - has the client subscribed a term deposit? (binary: 'yes','no')

# Convert the duration of the calll to seconds
bank <- bank %>% mutate(D = ms(duration/60))

#------------------------------------Chi-Square Test for checking the 'dependency' of the 2 columns--------------------------
# We can notice that 2 columns education and poutcome(determining the outcome of previour marketing campaign )
#have a considerable number of unknown's

str(bank)
#Number of occurence for each category under 'yes/no' was determined
bank %>% select(education,y) %>% group_by(education,y) %>% summarise(Number_of_Occurence = n()) %>%
          spread(y,Number_of_Occurence) %>% mutate(Total = no + yes)

#Proportion of Unknown under wach outcome is determined.
bank %>% select(education,y) %>% group_by(y) %>% summarise(SUM=n())
bank %>% filter(education == 'unknown'| poutcome == 'unknown') %>% group_by(y) %>% summarise(Number_of_Unkowns = n())
bank %>% filter(education == 'unknown'| poutcome == 'unknown') %>% summarise(Percentage_of_Unkowns = n() * 100/45211)

#The chi-square test of independence is used to analyze the frequency table (i.e. contengency table)
#formed by two categorical variables.
#The chi-square test evaluates whether there is a significant association between the categories of the two variables.
Education_tbl <- table(bank$education,bank$y)
Education_tbl
chisq_education <- chisq.test(Education_tbl)
chisq_education$p.value

poutcome_tbl <- table(bank$poutcome,bank$y)
poutcome_tbl
chisq_poutcome <- chisq.test(poutcome_tbl)
chisq_poutcome

#-----------------------------------------------------Imbalanced Data Set----------------------------------------------------
#Dataset  contains how many yes's and how many no's
table(bank$y)

ggplot(bank,aes(y,fill = y)) +
  geom_bar(stat = "Count",alpha = 0.9) +
  labs(title = "Number of Yes/No in Dataset",fill = NULL) +
  xlab("") + ylab("") +
  scale_x_discrete(labels = c("No","Yes")) +
  theme(plot.title = element_text(size=20))+
  guides(fill = FALSE)

# it can be observed above that the distribution of yes & no in the dataset is uneven. 
# How to deal with imbalanced dataset ??
# Change the accuracy mesurement of model - as the model will try to fit the "NO" cases more than "Yes" and our focus is on "Yes"
#1. USE ROC and AUC as measurement parameters
#2. OverSampling - sampling with replacement from the group with lesser data until the number equals larger group
#3  UnderSampling - sampling with replacement from the group with more data until the number equals smaller group
#4. Smote the data 

## Remeber as we are trying to predict the 'yes' class more than the 'no' class,we need to ensure the Neg PRed Rate if high 
## and speciicity is high

#------------------------------------------Split into Training /Testing Model--------------------------------------------

y_No <- bank %>% filter(y == 'no')
y_Yes <- bank %>% filter(y == 'yes')

Train_No <- head(y_No,0.75* nrow(y_No))
Test_No <- tail(y_No,0.25*nrow(y_No))

Train_Yes <- head(y_Yes,0.75 * nrow(y_Yes))
Test_Yes <- tail(y_Yes,nrow(y_Yes)*0.25)

# now the Training_set and Test_Set are both having balanced yes and no.
Training_Set <- rbind(Train_No,Train_Yes)
Test_Set <- rbind(Test_No,Test_Yes)

# Data when Oversampled
#Oversampling of Dataset i.e increasing the minority dataset.
# As we are interest more in the 'yes' column
library(ROSE) # Random OverSampling Examples
table(Training_Set$y)
Training_Set_Oversample <- ovun.sample(y~.,data=Training_Set,method ="over",N = 59882)$data
table(Training_Set_Oversample$y)
Test_Set_Oversample <- ovun.sample(y~.,data=Test_Set,method ="over",N = 19962)$data
table(Test_Set_Oversample$y)

#Undersampling the dataset
# Reduce the majority class
table(Training_Set$y)
Training_Set_Undersample <- ovun.sample(y~.,data=Training_Set,method ="under",N = 7932)$data
table(Training_Set_Undersample$y)
table(Test_Set$y)
Test_Set_Undersample <- ovun.sample(y~.,data=Test_Set,method ="under",N = 2646)$data
table(Test_Set_Undersample$y)

#-----------------------------------------Applying decision tree algorithm--------------------------------------------------
# building the tree taking all attributes into consideration
tree <- rpart(y~.,data=Training_Set,method ="class")
summary(tree)
predict_train_tree <- predict(tree,Training_Set,type='class')
confusionMatrix(Training_Set$y,predict_train_tree)
plot(roc(Training_Set$y,as.numeric(predict_train_tree)),print.auc=TRUE)

#run the test data, so as 
predict_tree <- predict(tree,Test_Set,type='class')
confusionMatrix(Test_Set$y,predict_tree)
plot(roc(Test_Set$y,as.numeric(predict_tree)),print.auc=TRUE)

Imp_tree <- varImp(tree)

tree_imp <- Imp_tree %>% mutate(Name_of_variable = as.factor(rownames(Imp_tree))) %>% arrange(desc(Overall)) %>% top_n(10,wt = Overall) %>%
  mutate(Name_of_variable = reorder(Name_of_variable,Overall))

tree_imp %>%  ggplot() + aes(Name_of_variable,Overall) +
  geom_bar(stat="Identity",width=0.05) + geom_point(col='blue') +
  coord_flip() +
  xlab( "Variable") + ylab("") +
  scale_y_continuous(breaks = NULL) +
  ggtitle("Top 10 important variables by Decision Tree")

# predicting the Training_set based on construted classifier
pred <- predict(tree,Test_Set,type = "class")

# Constructing the confusion matrix to determing performance of classifier
conf_matrix <- table(Test_Set$y,pred)
conf_matrix

# building the tree on oversampled data
tree_os <- rpart(y~.,data=Training_Set_Oversample,method ="class")
summary(tree_os)
predict_train_tree_os <- predict(tree_os,Training_Set_Oversample,type='class')
confusionMatrix(Training_Set_Oversample$y,predict_train_tree_os)
plot(roc(Training_Set_Oversample$y,as.numeric(predict_train_tree_os)),print.auc=TRUE)

#run the model on test data
predict_tree_os <- predict(tree_os,Test_Set_Oversample,type='class')
confusionMatrix(Test_Set_Oversample$y,predict_tree_os)
plot(roc(Test_Set_Oversample$y,as.numeric(predict_tree_os)),print.auc=TRUE)

Imp_tree_os <- varImp(tree_os)

tree_imp_os <- Imp_tree_os %>% mutate(Name_of_variable = as.factor(rownames(Imp_tree_os))) %>% arrange(desc(Overall)) %>% top_n(10,wt = Overall) %>%
  mutate(Name_of_variable = reorder(Name_of_variable,Overall))

tree_imp_os %>%  ggplot() + aes(Name_of_variable,Overall) +
  geom_bar(stat="Identity",width=0.05) + geom_point(col='blue') +
  coord_flip() +
  xlab( "Variable") + ylab("") +
  scale_y_continuous(breaks = NULL) +
  ggtitle("Top 10 important variables by Decision Tree")

## run on undersampled data
# building the tree on oversampled data
tree_us <- rpart(y~.,data=Training_Set_Undersample,method ="class")
summary(tree_us)
predict_train_tree_us <- predict(tree_us,Training_Set_Undersample,type='class')
confusionMatrix(Training_Set_Undersample$y,predict_train_tree_us)
plot(roc(Training_Set_Undersample$y,as.numeric(predict_train_tree_us)),print.auc=TRUE)

#run the model on test data
predict_tree_us <- predict(tree_us,Test_Set_Undersample,type='class')
confusionMatrix(Test_Set_Undersample$y,predict_tree_us)
plot(roc(Test_Set_Undersample$y,as.numeric(predict_tree_us)),print.auc=TRUE)

Imp_tree_us <- varImp(tree_us)

tree_imp_us <- Imp_tree_us %>% mutate(Name_of_variable = as.factor(rownames(Imp_tree_us))) %>% arrange(desc(Overall)) %>% top_n(10,wt = Overall) %>%
  mutate(Name_of_variable = reorder(Name_of_variable,Overall))

tree_imp_us %>%  ggplot() + aes(Name_of_variable,Overall) +
  geom_bar(stat="Identity",width=0.05) + geom_point(col='blue') +
  coord_flip() +
  xlab( "Variable") + ylab("") +
  scale_y_continuous(breaks = NULL) +
  ggtitle("Top 10 important variables by Decision Tree")



##Observations:
1. All the 3 decision tree models suffer , from overfitting. 
2. As ,we are more interested in the negative class that is 'yes' int his case, we notice that the last model,
 with undersampled data had the best Neg Pred Value of 0.89.
3. The 3 model predicts - month,duration,contact, pdays,previous ,poutcome,age,day,job and marital as the top 10 imp variables
#---------------------------------------------------Random Forest Algorithm----------------------------------------------------

library(randomForest)
random_fit <- randomForest(y~.,data = Training_Set,ntree = 500)
summary(random_fit)
random_predict <- predict(random_fit,Training_Set,type='response')
confusionMatrix(Training_Set$y,random_predict)
#high sensitivity is notice , and as we are concentrating on predicting 'yes', most of the are well predicted.
# It is able to predict the 'yes' classes much better compared to the logistic regression model.
# we further explore the specificity ,which is also high
plot(roc(Training_Set$y,as.numeric(random_predict)),print.auc = TRUE)

random_predict_test <- predict(random_fit,Test_Set,type='response')
confusionMatrix(Test_Set$y,random_predict_test)
# on test data , we can notice that the Specificity has drastically reduced, but the Neg Pred Value is high, in this case 'yes'
plot(roc(Test_Set$y,as.numeric(random_predict_test)),print.auc = TRUE)

require(randomForest)
var <- varImp(random_fit)
var
library(ggplot2)
r <- var %>% mutate(Name_of_variable = as.factor(rownames(var))) %>% arrange(desc(Overall)) %>% top_n(10,wt = Overall) %>%
  mutate(Name_of_variable = reorder(Name_of_variable,Overall))

r %>%  ggplot() + aes(Name_of_variable,Overall) +
  geom_bar(stat="Identity",width=0.05) + geom_point(col='blue') +
  coord_flip() +
  xlab( "Variable") + ylab("") +
  scale_y_continuous(breaks = NULL) +
  ggtitle("Top 10 important variables by Random Forest")

# Oversampled Dataset's
random_fit_oversample <- randomForest(y~.,data = Training_Set_Oversample,ntree = 500)
summary(random_fit_oversample)
random_train_os <- predict(random_fit_oversample,Training_Set_Oversample,type='response')
#high sensitivity is notice , and as we are concentrating on predicting 'yes', most of the are well predicted.
confusionMatrix(Training_Set_Oversample$y,random_train_os)
plot(roc(Training_Set_Oversample$y,as.numeric(random_train_os)),print.auc = TRUE)

random_predict_os <- predict(random_fit_oversample,Test_Set_Oversample,type='response')
#high sensitivity is notice , and as we are concentrating on predicting 'yes', most of the are well predicted.
confusionMatrix(Test_Set_Oversample$y,random_predict_os)
plot(roc(Test_Set_Oversample$y,as.numeric(random_predict_os)),print.auc = TRUE)

var_os <- varImp(random_fit_oversample)
var_os
library(ggplot2)
r_os <- var_os %>% mutate(Name_of_variable = as.factor(rownames(var))) %>% arrange(desc(Overall)) %>% top_n(10,wt = Overall) %>%
  mutate(Name_of_variable = reorder(Name_of_variable,Overall))

r_os %>%  ggplot() + aes(Name_of_variable,Overall) +
  geom_bar(stat="Identity",width=0.05) + geom_point(col='blue') +
  coord_flip() +
  xlab( "Variable") + ylab("") +
  scale_y_continuous(breaks = NULL) +
  ggtitle("Top 10 important variables by Random Forest")

#Undersampling the dataset
random_fit_undersample <- randomForest(y~.,data = Training_Set_Undersample,ntree = 500)
summary(random_fit_undersample)
random_train_us <- predict(random_fit_undersample,Training_Set_Undersample,type='response')
#high sensitivity is notice , and as we are concentrating on predicting 'yes', most of the are well predicted.
confusionMatrix(Training_Set_Undersample$y,random_train_us)
plot(roc(Training_Set_Undersample$y,as.numeric(random_train_us)),print.auc = TRUE)


random_predict_us <- predict(random_fit_undersample,Test_Set_Undersample,type='response')
confusionMatrix(Test_Set_Undersample$y,random_predict_us)
# the "Neg Pred Value remains high
plot(roc(Test_Set_Undersample$y,as.numeric(random_predict_us)),print.auc = TRUE)


var_us <- varImp(random_fit_undersample)
var_us
r_us <- var_us %>% mutate(Name_of_variable = as.factor(rownames(var))) %>% arrange(desc(Overall)) %>% top_n(10,wt = Overall) %>%
  mutate(Name_of_variable = reorder(Name_of_variable,Overall))

r_us %>%  ggplot() + aes(Name_of_variable,Overall) +
  geom_bar(stat="Identity",width=0.05) + geom_point(col='blue') +
  coord_flip() +
  xlab( "Variable") + ylab("") +
  scale_y_continuous(breaks = NULL) +
  ggtitle("Top 10 important variables by Random Forest")

#Observations 
1. THe random forest modesl were better classifiers. 
2. The AUC for the oversampled data is 0.507 and for undersampled is 0.503
   but the Neg Pred Value for undersampled dataset is better ( prediction of 'yes' class is better)
3. The important variables for 3 models was found to be - Duration, Month , Age, contact,day,balance,job,D,Pdays,campaign

#-------------------------------------------------------Logistic Regression------------------------------------------------------  
# Logistic Regression is a special case of Linear Regression , where outcome is categorical.binary outcome
logistic_model <- glm(y~.,data = Training_Set, family = binomial)
summary(logistic_model)
predict_train_test <- predict(logistic_model,Training_Set,type = 'response')
threshold <- 0.5
pred <- factor( ifelse(predict_train_test > 0.5, "yes", "no") )
confusionMatrix(pred, Training_Set$y)
plot(roc(Training_Set$y,as.numeric(pred)),print.auc = TRUE)

predict_test <- predict(logistic_model,Test_Set,type = 'response')
threshold <- 0.5
pred_test <- factor( ifelse(predict_test > 0.5, "yes", "no") )
confusionMatrix(pred_test, Test_Set$y)
plot(roc(Test_Set$y,as.numeric(pred_test)),print.auc = TRUE)

logistic_variables <- varImp(logistic_model)

library(ggplot2)
log <- logistic_variables %>% mutate(Name_of_variable = as.factor(rownames(logistic_variables))) %>% arrange(desc(Overall)) %>%
       top_n(10,wt = Overall) %>%
       mutate(Name_of_variable = reorder(Name_of_variable,Overall))

log %>%  ggplot() + aes(Name_of_variable,Overall) +
  geom_bar(stat="Identity",width=0.05) + geom_point(col='blue') +
  coord_flip() +
  xlab( "Variable") + ylab("") +
  scale_y_continuous(breaks = NULL) +
  ggtitle("Top 10 important variables by Logistic Regression")

# logistic_regression model on oversample data
logistic_model_oversample <- glm(y~.,data = Training_Set_Oversample, family = binomial)
summary(logistic_model_oversample)
predict_log_oversample <- predict(logistic_model_oversample,Training_Set_Oversample,type = 'response')
threshold <- 0.5
pred_log_oversample <- factor(ifelse(predict_log_oversample > threshold, "yes", "no") )
confusionMatrix(pred_log_oversample, Training_Set_Oversample$y)
plot(roc(Training_Set_Oversample$y,predict_log_oversample),print.auc = TRUE)

predict_log_os <- predict(logistic_model_oversample,Test_Set_Oversample,type = 'response')
threshold <- 0.5
pred_log_os <- factor(ifelse(predict_log_os > threshold, "yes", "no") )
confusionMatrix(pred_log_os, Test_Set_Oversample$y)
plot(roc(Test_Set_Oversample$y,predict_log_os),print.auc = TRUE)

log_variables_os <- varImp(logistic_model_oversample)
log_os <- log_variables_os %>% mutate(Name_of_variable = as.factor(rownames(log_variables_os))) %>%
          arrange(desc(Overall)) %>%
          top_n(10,wt = Overall) %>%
          mutate(Name_of_variable = reorder(Name_of_variable,Overall))

log_os %>%  ggplot() + aes(Name_of_variable,Overall) +
  geom_bar(stat="Identity",width=0.05) + geom_point(col='blue') +
  coord_flip() +
  xlab( "Variable") + ylab("") +
  scale_y_continuous(breaks = NULL) +
  ggtitle("Top 10 important variables by Logistic Regression")


# logistic_regression model on under-sampled data
# Obeservation Accuracy of Model increased and Specificity also increased more than "Over Sampling of Data"
logistic_model_undersample <- glm(y~.,data = Training_Set_Undersample, family = binomial)
summary(logistic_model_undersample)
predict_log_us <- predict(logistic_model_undersample,Training_Set_Undersample,type = 'response')
threshold <- 0.5
pred_log_us <- factor(ifelse(predict_log_us > threshold, "yes", "no") )
confusionMatrix(pred_log_us, Training_Set_Undersample$y)
plot(roc(Training_Set_Undersample$y,as.numeric(pred_log_us)),print.auc = TRUE)

predict_test_us <- predict(logistic_model_undersample,Test_Set_Undersample,type = 'response')
threshold <- 0.5
pred_test_us <- factor(ifelse(predict_test_us > threshold, "yes", "no") )
confusionMatrix(pred_test_us, Test_Set_Undersample$y)
plot(roc(Test_Set_Undersample$y,as.numeric(pred_test_us)),print.auc = TRUE)

log_variables_us <- varImp(logistic_model_undersample)
log_us <- log_variables_us %>% mutate(Name_of_variable = as.factor(rownames(log_variables_us))) %>%
  arrange(desc(Overall)) %>%
  top_n(10,wt = Overall) %>%
  mutate(Name_of_variable = reorder(Name_of_variable,Overall))

log_us %>%  ggplot() + aes(Name_of_variable,Overall) +
  geom_bar(stat="Identity",width=0.05) + geom_point(col='blue') +
  coord_flip() +
  xlab( "Variable") + ylab("") +
  scale_y_continuous(breaks = NULL) +
  ggtitle("Top 10 important variables by Logistic Regression")


#Observations :
1. The performance of the oversampled logistic regression model was the best so far,  with AUC being 0.703.
2. Important variables - duration,contact,month,poutcome,housing.

#--------------------------------------------------------Support Vector Machine----------------------------------------------
s_fit_os <- fit(y~.,data = Training_Set_Oversample,model="svm",task="class")
p_svm_os <- predict(s_fit_os,Training_Set_Oversample,type = 'class')
confusionMatrix(Training_Set_Oversample$y,p_svm_os)
plot(roc(Training_Set_Oversample$y,as.numeric(p_svm_os)),print.auc = TRUE)

p_svm_test_os <- predict(s_fit_os,Test_Set_Oversample,type = 'class')
confusionMatrix(Test_Set_Oversample$y,p_svm_test_os)
plot(roc(Test_Set_Oversample$y,as.numeric(p_svm_test_os)),print.auc = TRUE)
svm_imp_os <- Importance(s_fit_os,Training_Set_Oversample)

str(svm_imp_os)
t(svm_imp_os$imp)
svm_imp_os$sresponses

L=list(runs=1,sen=t(svm_imp_os$imp),sresponses=svm_imp_os$sresponses)
mgraph(L,graph="IMP",leg=names(Training_Set_Oversample),col="gray",Grid=10)

#Address Overfitting problem by running first on training set and then test set

# Which classification algorithm was well suited ?
# Selection criteria for the clsssification algorithm
# Discuss Strengths/Weakness of models
#Discuss Structure of Data
# Choice of Classification algorithms
# write about ROC and AUC

#----------------------------------------------------Data Exploration---------------------------------------------------------

#How many unique job - profiles exist??
bank %>% distinct(job) # We observe 12 job profiles exist

# to find out the number of occurences of each of these
bank %>% group_by(job) %>% dplyr::summarise(Count = n()) %>% ungroup() %>% mutate(job = reorder(job,Count)) %>%
  ggplot(aes(x=job,y = Count)) + geom_bar(stat = "Identity",aes(fill=Count)) + coord_flip() + 
  labs(title = " Distribution of Customer-Base : Job - Wise",fill = NULL) 


# Now out of all customers contacted , we can see the proportion of distribution of yes and no among the customer base.
bank %>% group_by(job,y) %>% dplyr::summarise(Count = n()) %>% ungroup() %>% mutate(job = reorder(job,Count)) %>%
  spread(y,Count) %>% mutate( sum = no + yes) %>% 
  mutate(percentage_no = round(no * 100 /sum,2) ,percentage_yes = round(yes * 100 /sum, 2)) %>%
  gather(Percentage,value,c("percentage_no","percentage_yes")) %>% 
  ggplot(aes(x=job,y=value)) + geom_bar(stat="Identity",position='stack',aes(fill = Percentage)) + coord_flip() +
  labs(title = "Percentage of Customers who availed Bank Term Depsoit : Job - Wise",fill = NULL ) +
  geom_text(aes(label = paste0(value,"%"),fill= NULL)) + scale_fill_manual(values=c("#40b8d0", "#b2d183"))



# We want to see how many of the customer's have a house and among them how many have availed loan
bank %>% group_by(housing,y) %>% dplyr::summarise(Count = n()) %>% 
  ggplot(aes(x = housing , y = Count,fill = y)) + geom_col() + 
  labs(title = " Distribution of Customer-Base : Housing - Wise",fill = NULL) +
  scale_fill_manual(values=c("#40b8d0", "#b2d183")) +
  guides(fill = FALSE) +
  scale_x_discrete(labels = c("No","Yes")) +
  xlab("Housing")

bank %>% group_by(housing,y) %>% dplyr::summarise(Count = n()) %>% filter(y == 'yes') %>% 
  spread(housing,Count) %>%
  mutate(Percentage_yes = yes/(no+yes) ,percentage_no = no/(no+yes)) %>% 
  gather(Percentage,value,c(Percentage_yes,percentage_no))  %>% 
  ggplot(aes(x=as.factor(Percentage),y =value,fill='steelblue')) +
  geom_bar(stat="Identity") 


# Distribution of dataset Age Wise
bank %>% mutate(category = cut(age,breaks =seq(0,100,by=10))) %>% group_by(category) %>% summarise(Count =n()) %>%
  ungroup() %>% mutate(category = reorder(category,Count)) %>% 
  ggplot(aes(x= category,y=Count)) + geom_bar(stat= "Identity",aes(fill= Count)) + coord_flip() +
  labs( title = "Distribution of Age in Dataset")

# Below plot shows me out of the customers in different age groups contacted how many said yes and how many no
bank %>% select(age,y) %>% mutate(category = cut(age,breaks =seq(0,100,by=10))) %>% group_by(category,y) %>% 
  dplyr::summarise( Count=n()) %>% ungroup() %>% mutate(category = reorder(category,Count)) %>%
  ggplot(aes(x=category,y=Count,fill=y)) + geom_bar(stat="identity") + facet_wrap(~y) + coord_flip() +
  xlab("Age Dsitribution" ) + labs(title = " Distribution of Customer-Base : Age - Wise",fill = NULL) + 
  scale_fill_manual(values=c("#40b8d0", "#b2d183"))

# it can be observed that in first four age groups though the customer's proportion of who said no seems to differ significantly
# the proportion customer's who said yes seems to differ less significantly.
bank %>% select(age,y) %>% mutate(category = cut(age,breaks =seq(0,100,by=10))) %>% group_by(category,y) %>% 
  dplyr::summarise(Count=n()) %>% spread(y,Count) %>% 
  mutate(Total = no + yes ,percent_yes = round(yes * 100/Total,2),percent_no = round(no * 100/Total,2)) %>%
  select(-(2:3)) %>% gather(Percentage,value,c("percent_yes","percent_no")) %>% ungroup() %>%
  mutate(category = reorder(category,Total)) %>%
  ggplot(aes(x=category,y = value,fill = Percentage)) + geom_bar(stat="Identity") + coord_flip() +
  geom_text(aes(label = paste0(value,"%"),fill= NULL)) + scale_fill_manual(values=c("#40b8d0", "#b2d183"))


# Distribution of Data by month ,maybe customers are more prone to a crunch in funds during holiday season
bank %>% group_by(month,y) %>% 
  dplyr::summarise(Count=n()) %>% ungroup() %>% mutate(month =reorder(month,Count)) %>%
  ggplot(aes(x=month,y=Count,fill=y)) + geom_bar(stat="identity",position = "dodge") + coord_flip() +
  labs(title = 'Month Wise Distribution of Data',fill= NULL) + scale_fill_manual(values=c("#40b8d0", "#b2d183"))

# May % and dec % comaprision of yes/no
bank %>% group_by(month,y) %>% 
  dplyr::summarise(Count=n()) %>% ungroup() %>% mutate(month =reorder(month,Count)) %>%
  filter(month == 'may'| month == 'dec') %>% spread(y,Count) %>% 
  mutate(total= no + yes, percent_yes = round(yes*100/total,2),percent_no=round(no*100/total,2)) %>% 
  gather(Percent,value,c("percent_yes","percent_no")) %>% group_by(month,Percent) %>%
  ggplot(aes(x=month,y=value,fill= Percent)) + geom_bar(stat="Identity",position="dodge") +
  scale_fill_manual(values=c("#40b8d0", "#b2d183")) + 
  labs(title = "Comparision between Dec and May",fill = NULL) +
  scale_x_discrete(labels = c("dec" = "December","may" = "May")) +guides ( fill = FALSE)

#Job Wise % of Yes and No.
bank %>% group_by(job,y) %>% dplyr::summarise(Count = n()) %>% ungroup() %>% mutate(job = reorder(job,Count)) %>%
  group_by(job) %>% spread(y,Count) %>% mutate( sum = no + yes) %>% 
  mutate(percentage_no = round(no * 100 /sum,2) ,percentage_yes = round(yes * 100 /sum, 2)) %>%
  gather(Percentage,value,c("percentage_no","percentage_yes")) %>% 
  ggplot(aes(x=job,y=value)) + geom_bar(stat="Identity",position='stack',aes(fill = Percentage)) + coord_flip() +
  labs(title = "Percentage of Customers who availed Bank Term Depsoit : Job - Wise") +
  geom_text(aes(label = paste0(value,"%"))) + scale_fill_manual(values=c("#40b8d0", "#b2d183")) +
  guides(fill = FALSE)


