# Analysis of Bank Marketing Dataset


# Identification of marketing attributes : Portugese Bank

## Introduction
Banks andy Corporations spend tons of money for advertising and marketing. Most of this money, energy and effort of staff is
not efficiently utilized. 

## Objective
To build a classifier model to identify factors that would allow the bank to devise a more 
efficient and precise campaign strategy to help reduce the costs and improve the profits its "Term Deposit Product". 

## Dataset Description
The dataset is taken from [UCI MACHINE LEARNING REPOSITORY](https://archive.ics.uci.edu/ml/datasets/bank+marketing).             
The dataset has 45211 records spread across 17 variables. A brief description of the variables is as below:

## Abstract
Aim of the project is to identify the main attributes to increase the efficiency of the Marketing Strategy of the Bank , whether a customer would subscribe a 'Term - Deposit' 

## Introduction
Telemarketing strategy are very economical and viable , but without knowing the customers
whom we are marketting too, we are wasting a lot of resources and time.In order to save costs and time, 
it is important to filter the contacts but keep a certain success rate.

## Objective
Our objective is to build classification models, from which we can identify the important attributes of those customers who do subscribe to the 'Term - Deposit' products, thereby implementing targeted telemarketing. 

## Dataset Description
The dataset is taken from [UCI MACHINE LEARNING REPOSITORY](https://archive.ics.uci.edu/ml/datasets/bank+marketing).             
The dataset has 45211 records spread across 17 variables. A brief description of the variables is as below:

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
library(ROSE)


# Set the working directory and load dataset
setwd("/Users/Deepika/Desktop/Learning/Projects/Bank")

bank <- read.csv("bank-full.csv")
dim(bank)
The column names/descriptor attributes  along with their structure are as below:
names(bank)
str(bank)
any(is.na(bank))
head(bank)



summary(bank)

bank %>% filter(education == 'unknown') %>% group_by(y) %>% summarise(Number_of_Unkowns = n())
edn_per <- bank %>% filter(education == 'unknown') %>% summarise(Percentage_of_Unkowns = n() * 100/45211)


bank %>% filter(poutcome == 'unknown') %>% group_by(y) %>% summarise(Number_of_Unkowns = n())
pout_per <- bank %>% filter(poutcome == 'unknown') %>% summarise(Percentage_of_Unkowns = n() * 100/45211)



Education_tbl <- table(bank$education,bank$y)
Education_tbl
chisq_education <- chisq.test(Education_tbl)
chi_edn <- chisq_education$p.value

The chi-square stastic between the columns education and y is 1.626656e-51 , it is lesser than 0.05. 
Indicating, the unknowns are stastically significant.


poutcome_tbl <- table(bank$poutcome,bank$y)
poutcome_tbl
chisq_poutcome <- chisq.test(poutcome_tbl)
pout_chi <- chisq_poutcome$p.value

The chi-square stastic between the columns poutcome and y is 0 , it is lesser than 0.05.
Indicating, the unknowns are stastically significant.


bank$poutcome <- NULL
bank <- bank %>% filter(!(education == 'unknown' | contact == 'unknown' | day == 'other'))


### How do we deal with the Imbalanced Dataset
On inspection of our dataset, we can notice that our predictor variable y is not evenly distributed.
The responses with 'no' is 90% of the dataset and 'yes' is 10% of the dataset. 

table(bank$y)

bank %>% group_by(y) %>% summarise(Count = n()) %>% ggplot() + 
  aes(x = as.factor(y),y = Count, fill = as.factor(y)) + 
  geom_col(aes(fill = as.factor(y)),alpha = 0.9) +
  scale_fill_brewer(palette = "Blues") +
  labs(title =' Number of Yes/No in the Dataset') +
  ylab("Number") + 
  xlab("") +
  scale_x_discrete(labels = c("NO","YES"))  +
  geom_text(aes(label = Count),vjust = 0.00) + 
  guides(fill = FALSE) +
  theme_bw()

#Classification Models      

**Split the dataset into Training and Test**
Prior to the application of classification models to the dataset, the data set is first split into "Training" and "Test" . 
Our Training Set contains 70% of the original dataset and Test Set the remenant. 

dt = sort(sample(nrow(bank), nrow(bank)*.7))
Training_Set <- bank[dt,]
Test_Set <- bank[-dt,]



##1. Decision - Tree Model :
The most common of all classification methodologies , is the decision tree. It works for both categorical and continous input and output variables.

**Model Performance with Training Set**
tree <- rpart(y~.,data=Training_Set,method ="class")
predict_train_tree <- predict(tree,Training_Set,type='class')
confusionMatrix(predict_train_tree,Training_Set$y)
roc.curve(Training_Set$y,predict_train_tree)

**Model Performance with Testing Set**
predict_tree <- predict(tree,Test_Set,type='class')
confusionMatrix(predict_tree,Test_Set$y)
roc.curve(Test_Set$y,predict_tree)
conf_tree <- confusionMatrix(predict_tree,Test_Set$y)
TPR_tree <- (conf_tree$table[2,2]/(conf_tree$table[2,1]+conf_tree$table[2,2]))

Imp_tree <- varImp(tree)

tree_imp <- Imp_tree %>% mutate(Name_of_variable = as.factor(rownames(Imp_tree))) %>% arrange(desc(Overall)) %>% top_n(10,wt = Overall) %>%
mutate(Name_of_variable = reorder(Name_of_variable,Overall))

Imp_tree <- varImp(tree)

tree_imp <- Imp_tree %>% mutate(Name_of_variable = as.factor(rownames(Imp_tree))) %>% arrange(desc(Overall)) %>% top_n(10,wt = Overall) %>%
mutate(Name_of_variable = reorder(Name_of_variable,Overall))


tree_imp %>%  ggplot() + aes(Name_of_variable,Overall) +
  geom_bar(stat="Identity",width=0.05) + geom_point(col='blue') +
  coord_flip() +
  xlab( "Variable") + ylab("") +
  scale_y_continuous(breaks = NULL) +
  ggtitle("Top 10 important variables by Decision Tree")



**Observations:**

From the above graphs:  
1. The AUC is 0.695, when the model is run on the Test Set.  
2. The TRUE positive Rate is `r TPR_tree`.  
3. The important attributes observed are as shown in the chart below.  



#2. Random Forest
In this mode, multiple trees are grown as opposed to a single tree. The tree with the most votes is chosen by the model.

library(randomForest)
random_fit <- randomForest(y~.,data = Training_Set,ntree = 500)
random_predict_train <- predict(random_fit,Training_Set,type='response')
confusionMatrix(random_predict_train,Training_Set$y)
roc.curve(Training_Set$y,random_predict_train)

random_predict_test <- predict(random_fit,Test_Set,type='response')
confusionMatrix(random_predict_test,Test_Set$y)
roc.curve(Test_Set$y,random_predict_test)

conf_random <- confusionMatrix(random_predict_test,Test_Set$y)
TPR_random <- (conf_random$table[2,2]/(conf_random$table[2,1]+conf_random$table[2,2]))

require(randomForest)
var <- varImp(random_fit)

r <- var %>% mutate(Name_of_variable = as.factor(rownames(var))) %>% arrange(desc(Overall)) %>% top_n(10,wt = Overall) %>%
mutate(Name_of_variable = reorder(Name_of_variable,Overall))

r %>%  ggplot() + aes(Name_of_variable,Overall) +
  geom_bar(stat="Identity",width=0.05) + geom_point(col='blue') +
  coord_flip() +
  xlab( "Variable") + ylab("") +
  scale_y_continuous(breaks = NULL) +
  ggtitle("Top 10 important variables by Random Forest")


**Observations:**

From the above graphs:  
1. The AUC is 0.712, when the model is run on the Test Set.  
2. The TRUE positive Rate is `r TPR_random`.  
3. The important attributes observed are as shown in the chart below.




#3. Support Vector Machines
In this algorithm, we plot each data item as a point in n-dimensional space (where n is number of features you have) with the value of each feature being the value of a particular coordinate. Then, we perform classification by finding the hyper-plane that differentiate the two classes very well. Support Vectors are simply the co-ordinates of individual observation. Support Vector Machine is a frontier which best segregates the two classes (hyper-plane/ line).


library(e1071) # Misc Functions of the Department of Statistics, Probability Theory Group (Formerly: E1071), TU Wien

library(rminer)
library(randomForest)
library(caret)
require(rminer)
s_fit <- fit(y~.,data = Training_Set,model="svm",task="class")
p_svm_train <- predict(s_fit,Training_Set,type = 'class')
confusionMatrix(p_svm_train,Training_Set$y)
roc.curve(Training_Set$y,p_svm_train)

p_svm_test <- predict(s_fit,Test_Set,type = 'class')
confusionMatrix(p_svm_test,Test_Set$y)
roc.curve(Test_Set$y,p_svm_test)

conf_svm <- confusionMatrix(p_svm_test,Test_Set$y)
TPR_svm <- (conf_svm$table[2,2]/(conf_svm$table[2,1]+conf_svm$table[2,2]))

svm_imp <- Importance(s_fit,Training_Set)
L=list(runs=1,sen=t(svm_imp$imp),sresponses=svm_imp$sresponses)

mgraph(L,graph="IMP",leg=names(Training_Set),col="gray",Grid=10)


**Observations:**

From the above graphs:  
1. The AUC is 0.650, when the model is run on the Test Set.  
2. The TRUE positive Rate is `r TPR_svm`.  
3. The important attributes observed are as shown in the chart below.   



#4. Logistic Regression
Logistic Regression is a special case of Linear Regression , where outcome is categorical binary outcome

logistic_model <- glm(y~.,data = Training_Set, family = binomial)
summary(logistic_model)
predict_train_test <- predict(logistic_model,Training_Set,type = 'response')
threshold <- 0.5
pred <- factor( ifelse(predict_train_test > 0.5, "yes", "no") )
confusionMatrix(pred, Training_Set$y)
roc.curve(Training_Set$y,pred)

predict_test <- predict(logistic_model,Test_Set,type = 'response')
threshold <- 0.5
pred_test <- factor( ifelse(predict_test > 0.5, "yes", "no") )
confusionMatrix(pred_test, Test_Set$y)
roc.curve(Test_Set$y,pred_test)

conf_log <- confusionMatrix(pred_test, Test_Set$y)
TPR_log <- (conf_log$table[2,2]/(conf_log$table[2,1]+conf_log$table[2,2]))

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


**Observations:**

From the above graphs:  
1. The AUC is 0.650, when the model is run on the Test Set.  
2. The TRUE positive Rate is `r TPR_log`.  
3. The important attributes observed are as shown in the chart below. 

#Conclusions:
In all the four classifications models ,we can see that :  
* The duration of the call is very important.  
* The SVM shows only 2 important variables - pdays and duration
* The important common variables in the other 3 classification models are - age,housing,month and pdays.





