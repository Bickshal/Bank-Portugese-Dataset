Identification of marketing attributes : Portugese Bank
================

Abstract
--------

Aim of the project is to identify the main attributes to increase the efficiency of the Marketing Strategy of the Bank , whether a customer would subscribe a 'Term - Deposit'

Introduction
------------

Telemarketing strategy are very economical and viable , but without knowing the customer's whom we are marketting too, we are wasting a lot of resources and time.In order to save costs and time, it is important to filter the contacts but keep a certain success rate.

Objective
---------

Our objective is to build classification models, from which we can identify the important attributes of those customers who do subscribe to the 'Term - Deposit' products, thereby implementing targeted telemarketing.

Dataset Description
-------------------

The dataset is taken from [UCI MACHINE LEARNING REPOSITORY](https://archive.ics.uci.edu/ml/datasets/bank+marketing).
The dataset has 45211 records spread across 17 variables. A brief description of the variables is as below:

    ## [1] 45211    17

The column names/descriptor attributes along with their structure are as below:

    ##  [1] "age"       "job"       "marital"   "education" "default"  
    ##  [6] "balance"   "housing"   "loan"      "contact"   "day"      
    ## [11] "month"     "duration"  "campaign"  "pdays"     "previous" 
    ## [16] "poutcome"  "y"

    ## 'data.frame':    45211 obs. of  17 variables:
    ##  $ age      : int  58 44 33 47 33 35 28 42 58 43 ...
    ##  $ job      : Factor w/ 12 levels "admin.","blue-collar",..: 5 10 3 2 12 5 5 3 6 10 ...
    ##  $ marital  : Factor w/ 3 levels "divorced","married",..: 2 3 2 2 3 2 3 1 2 3 ...
    ##  $ education: Factor w/ 4 levels "primary","secondary",..: 3 2 2 4 4 3 3 3 1 2 ...
    ##  $ default  : Factor w/ 2 levels "no","yes": 1 1 1 1 1 1 1 2 1 1 ...
    ##  $ balance  : int  2143 29 2 1506 1 231 447 2 121 593 ...
    ##  $ housing  : Factor w/ 2 levels "no","yes": 2 2 2 2 1 2 2 2 2 2 ...
    ##  $ loan     : Factor w/ 2 levels "no","yes": 1 1 2 1 1 1 2 1 1 1 ...
    ##  $ contact  : Factor w/ 3 levels "cellular","telephone",..: 3 3 3 3 3 3 3 3 3 3 ...
    ##  $ day      : int  5 5 5 5 5 5 5 5 5 5 ...
    ##  $ month    : Factor w/ 12 levels "apr","aug","dec",..: 9 9 9 9 9 9 9 9 9 9 ...
    ##  $ duration : int  261 151 76 92 198 139 217 380 50 55 ...
    ##  $ campaign : int  1 1 1 1 1 1 1 1 1 1 ...
    ##  $ pdays    : int  -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 ...
    ##  $ previous : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ poutcome : Factor w/ 4 levels "failure","other",..: 4 4 4 4 4 4 4 4 4 4 ...
    ##  $ y        : Factor w/ 2 levels "no","yes": 1 1 1 1 1 1 1 1 1 1 ...

**Description of dataset attributes**

1.  age (numeric)
2.  job : type of job (categorical: 'admin.','blue-collar','entrepreneur','housemaid','management','retired','self-employed','services','student','technician','unemployed','unknown')
3.  marital : marital status (categorical: 'divorced','married','single','unknown'; note: 'divorced' means divorced or widowed) 4 . education (categorical: 'basic.4y','basic.6y','basic.9y','high.school','illiterate','professional.course','university.degree','unknown')
4.  default: has credit in default? (categorical: 'no','yes','unknown')
5.  balance : representing balance held by customer under various accounts in that bank.
6.  housing: has housing loan? (categorical: 'no','yes','unknown')
7.  loan: has personal loan? (categorical: 'no','yes','unknown') 9 . contact: contact communication type (categorical: 'cellular','telephone')
8.  month: last contact month of year (categorical: 'jan', 'feb', 'mar', ..., 'nov', 'dec')
9.  day\_of\_week: last contact day of the week (categorical: 'mon','tue','wed','thu','fri')
10. duration: last contact duration, in seconds (numeric) 13 - campaign: number of contacts performed during this campaign and for this client (numeric, includes last contact) 14 - pdays: number of days that passed by after the client was last contacted from a previous campaign (numeric; 999 means client was not previously contacted) 15 - previous: number of contacts performed before this campaign and for this client (numeric) 16 - poutcome: outcome of the previous marketing campaign (categorical: 'failure','nonexistent','success') 17- y - has the client subscribed a term deposit? (binary: 'yes','no')

*Important note* *The duration attribute highly affects the output target (e.g., if duration=0 then y='no').Yet, the duration is not known before a call is performed.Also, after the end of the call y is obviously known.Thus, this input should only be included for benchmark purposes and should be discarded if the intention is to have a realistic predictive model.*

The dataset is checked if any 'NA's' exists and the top rows of the dataset are below:

    ## [1] FALSE

    ##   age          job marital education default balance housing loan contact
    ## 1  58   management married  tertiary      no    2143     yes   no unknown
    ## 2  44   technician  single secondary      no      29     yes   no unknown
    ## 3  33 entrepreneur married secondary      no       2     yes  yes unknown
    ## 4  47  blue-collar married   unknown      no    1506     yes   no unknown
    ## 5  33      unknown  single   unknown      no       1      no   no unknown
    ## 6  35   management married  tertiary      no     231     yes   no unknown
    ##   day month duration campaign pdays previous poutcome  y
    ## 1   5   may      261        1    -1        0  unknown no
    ## 2   5   may      151        1    -1        0  unknown no
    ## 3   5   may       76        1    -1        0  unknown no
    ## 4   5   may       92        1    -1        0  unknown no
    ## 5   5   may      198        1    -1        0  unknown no
    ## 6   5   may      139        1    -1        0  unknown no

We also wanna check how many 'unknown's' if any exist under each column.

    ##       age                 job           marital          education    
    ##  Min.   :18.00   blue-collar:9732   divorced: 5207   primary  : 6851  
    ##  1st Qu.:33.00   management :9458   married :27214   secondary:23202  
    ##  Median :39.00   technician :7597   single  :12790   tertiary :13301  
    ##  Mean   :40.94   admin.     :5171                    unknown  : 1857  
    ##  3rd Qu.:48.00   services   :4154                                     
    ##  Max.   :95.00   retired    :2264                                     
    ##                  (Other)    :6835                                     
    ##  default        balance       housing      loan            contact     
    ##  no :44396   Min.   : -8019   no :20081   no :37967   cellular :29285  
    ##  yes:  815   1st Qu.:    72   yes:25130   yes: 7244   telephone: 2906  
    ##              Median :   448                           unknown  :13020  
    ##              Mean   :  1362                                            
    ##              3rd Qu.:  1428                                            
    ##              Max.   :102127                                            
    ##                                                                        
    ##       day            month          duration         campaign     
    ##  Min.   : 1.00   may    :13766   Min.   :   0.0   Min.   : 1.000  
    ##  1st Qu.: 8.00   jul    : 6895   1st Qu.: 103.0   1st Qu.: 1.000  
    ##  Median :16.00   aug    : 6247   Median : 180.0   Median : 2.000  
    ##  Mean   :15.81   jun    : 5341   Mean   : 258.2   Mean   : 2.764  
    ##  3rd Qu.:21.00   nov    : 3970   3rd Qu.: 319.0   3rd Qu.: 3.000  
    ##  Max.   :31.00   apr    : 2932   Max.   :4918.0   Max.   :63.000  
    ##                  (Other): 6060                                    
    ##      pdays          previous           poutcome       y        
    ##  Min.   : -1.0   Min.   :  0.0000   failure: 4901   no :39922  
    ##  1st Qu.: -1.0   1st Qu.:  0.0000   other  : 1840   yes: 5289  
    ##  Median : -1.0   Median :  0.0000   success: 1511              
    ##  Mean   : 40.2   Mean   :  0.5803   unknown:36959              
    ##  3rd Qu.: -1.0   3rd Qu.:  0.0000                              
    ##  Max.   :871.0   Max.   :275.0000                              
    ## 

We can notice that 2 columns `education` and `poutcome(determining the outcome of previous marketing campaign)` have a considerable number of unknown's + Under Education we have:

    ## # A tibble: 2 x 2
    ##        y Number_of_Unkowns
    ##   <fctr>             <int>
    ## 1     no              1605
    ## 2    yes               252

THe percentage of unknown's being 4.1074075

-   Under Poutcome we have:

<!-- -->

    ## # A tibble: 2 x 2
    ##        y Number_of_Unkowns
    ##   <fctr>             <int>
    ## 1     no             33573
    ## 2    yes              3386

The percentage of unknown's being 81.7478047

### How do we deal with 'unknown' data?

*Decision with respect to Unknown* We know that the education,contact and day columns have unknown's, we remove those columns from the dataset. The Poutcome columns represents the results of the previous marketing campaign and has 81.7478047%. As this columns doesnt really help in identification of attributes for our future marketing campaign. We remove the row from the dataset.

    ##       age                 job           marital          education    
    ##  Min.   :18.00   blue-collar:9732   divorced: 5207   primary  : 6851  
    ##  1st Qu.:33.00   management :9458   married :27214   secondary:23202  
    ##  Median :39.00   technician :7597   single  :12790   tertiary :13301  
    ##  Mean   :40.94   admin.     :5171                    unknown  : 1857  
    ##  3rd Qu.:48.00   services   :4154                                     
    ##  Max.   :95.00   retired    :2264                                     
    ##                  (Other)    :6835                                     
    ##  default        balance       housing      loan            contact     
    ##  no :44396   Min.   : -8019   no :20081   no :37967   cellular :29285  
    ##  yes:  815   1st Qu.:    72   yes:25130   yes: 7244   telephone: 2906  
    ##              Median :   448                           unknown  :13020  
    ##              Mean   :  1362                                            
    ##              3rd Qu.:  1428                                            
    ##              Max.   :102127                                            
    ##                                                                        
    ##       day            month          duration         campaign     
    ##  Min.   : 1.00   may    :13766   Min.   :   0.0   Min.   : 1.000  
    ##  1st Qu.: 8.00   jul    : 6895   1st Qu.: 103.0   1st Qu.: 1.000  
    ##  Median :16.00   aug    : 6247   Median : 180.0   Median : 2.000  
    ##  Mean   :15.81   jun    : 5341   Mean   : 258.2   Mean   : 2.764  
    ##  3rd Qu.:21.00   nov    : 3970   3rd Qu.: 319.0   3rd Qu.: 3.000  
    ##  Max.   :31.00   apr    : 2932   Max.   :4918.0   Max.   :63.000  
    ##                  (Other): 6060                                    
    ##      pdays          previous           poutcome       y        
    ##  Min.   : -1.0   Min.   :  0.0000   failure: 4901   no :39922  
    ##  1st Qu.: -1.0   1st Qu.:  0.0000   other  : 1840   yes: 5289  
    ##  Median : -1.0   Median :  0.0000   success: 1511              
    ##  Mean   : 40.2   Mean   :  0.5803   unknown:36959              
    ##  3rd Qu.: -1.0   3rd Qu.:  0.0000                              
    ##  Max.   :871.0   Max.   :275.0000                              
    ## 

Our dataset now consists of 16 variables and 31011 rows.

**Measurement Guides**

To increase accuracy ,most of the alogrithm's will fit the 'no' class which is the majority better than the 'yes' class. However our requirement, is a model which will identify the 'yes' class or minority class. So, we will use different parameters of measurement:

-   True Positive Rate : When it's actual 'Yes' , how often does it predict 'Yes.

-   ROC and AUC :ROC stands for 'Receiver Operating Characteristics'and AUC for 'Area under Curve' This is the most widely used measurement methodology for a binary classifier. Here mainly, the FPR is plotted VS the TPR.

Classification Models
=====================

**Split the dataset into Training and Test** Prior to the application of classification models to the dataset, the data set is first split into "Training" and "Test" . Our Training Set contains 70% of the original dataset and Test Set the remenant.

**All the models are first run on the training data and then the test data, to ensure 'overfitting' and 'underfitting' doesnt occur**

1. Decision - Tree Model :
--------------------------

The most common of all classification methodologies , is the decision tree. It works for both categorical and continous input and output variables.

**Model Performance with Training Set**

    ## Confusion Matrix and Statistics
    ## 
    ##           Reference
    ## Prediction    no   yes
    ##        no  17667  1913
    ##        yes   832  1295
    ##                                          
    ##                Accuracy : 0.8735         
    ##                  95% CI : (0.869, 0.8779)
    ##     No Information Rate : 0.8522         
    ##     P-Value [Acc > NIR] : < 2.2e-16      
    ##                                          
    ##                   Kappa : 0.4167         
    ##  Mcnemar's Test P-Value : < 2.2e-16      
    ##                                          
    ##             Sensitivity : 0.9550         
    ##             Specificity : 0.4037         
    ##          Pos Pred Value : 0.9023         
    ##          Neg Pred Value : 0.6088         
    ##              Prevalence : 0.8522         
    ##          Detection Rate : 0.8139         
    ##    Detection Prevalence : 0.9020         
    ##       Balanced Accuracy : 0.6794         
    ##                                          
    ##        'Positive' Class : no             
    ## 

![](Bank_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-9-1.png)

    ## Area under the curve (AUC): 0.679

**Model Performance with Testing Set**

    ## Confusion Matrix and Statistics
    ## 
    ##           Reference
    ## Prediction   no  yes
    ##        no  7640  795
    ##        yes  344  525
    ##                                           
    ##                Accuracy : 0.8776          
    ##                  95% CI : (0.8707, 0.8842)
    ##     No Information Rate : 0.8581          
    ##     P-Value [Acc > NIR] : 2.273e-08       
    ##                                           
    ##                   Kappa : 0.4136          
    ##  Mcnemar's Test P-Value : < 2.2e-16       
    ##                                           
    ##             Sensitivity : 0.9569          
    ##             Specificity : 0.3977          
    ##          Pos Pred Value : 0.9057          
    ##          Neg Pred Value : 0.6041          
    ##              Prevalence : 0.8581          
    ##          Detection Rate : 0.8212          
    ##    Detection Prevalence : 0.9066          
    ##       Balanced Accuracy : 0.6773          
    ##                                           
    ##        'Positive' Class : no              
    ## 

![](Bank_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-10-1.png)

    ## Area under the curve (AUC): 0.677

**Observations:**

From the above graphs:
1. The AUC is 0.695, when the model is run on the Test Set.
2. The TRUE positive Rate is 0.6041427.
3. The important attributes observed are as shown in the chart below.

![](Bank_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-11-1.png)

2. Random Forest
================

In this mode, multiple trees are grown as opposed to a single tree. The tree with the most votes is chosen by the model.

    ## randomForest 4.6-12

    ## Type rfNews() to see new features/changes/bug fixes.

    ## 
    ## Attaching package: 'randomForest'

    ## The following object is masked from 'package:ggplot2':
    ## 
    ##     margin

    ## The following object is masked from 'package:dplyr':
    ## 
    ##     combine

    ## Confusion Matrix and Statistics
    ## 
    ##           Reference
    ## Prediction    no   yes
    ##        no  18499    50
    ##        yes     0  3158
    ##                                          
    ##                Accuracy : 0.9977         
    ##                  95% CI : (0.997, 0.9983)
    ##     No Information Rate : 0.8522         
    ##     P-Value [Acc > NIR] : < 2.2e-16      
    ##                                          
    ##                   Kappa : 0.9908         
    ##  Mcnemar's Test P-Value : 4.219e-12      
    ##                                          
    ##             Sensitivity : 1.0000         
    ##             Specificity : 0.9844         
    ##          Pos Pred Value : 0.9973         
    ##          Neg Pred Value : 1.0000         
    ##              Prevalence : 0.8522         
    ##          Detection Rate : 0.8522         
    ##    Detection Prevalence : 0.8545         
    ##       Balanced Accuracy : 0.9922         
    ##                                          
    ##        'Positive' Class : no             
    ## 

![](Bank_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-12-1.png)

    ## Area under the curve (AUC): 0.992

    ## Confusion Matrix and Statistics
    ## 
    ##           Reference
    ## Prediction   no  yes
    ##        no  7623  709
    ##        yes  361  611
    ##                                           
    ##                Accuracy : 0.885           
    ##                  95% CI : (0.8783, 0.8914)
    ##     No Information Rate : 0.8581          
    ##     P-Value [Acc > NIR] : 1.241e-14       
    ##                                           
    ##                   Kappa : 0.4693          
    ##  Mcnemar's Test P-Value : < 2.2e-16       
    ##                                           
    ##             Sensitivity : 0.9548          
    ##             Specificity : 0.4629          
    ##          Pos Pred Value : 0.9149          
    ##          Neg Pred Value : 0.6286          
    ##              Prevalence : 0.8581          
    ##          Detection Rate : 0.8193          
    ##    Detection Prevalence : 0.8955          
    ##       Balanced Accuracy : 0.7088          
    ##                                           
    ##        'Positive' Class : no              
    ## 

![](Bank_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-12-2.png)

    ## Area under the curve (AUC): 0.709

**Observations:**

From the above graphs:
1. The AUC is 0.712, when the model is run on the Test Set.
2. The TRUE positive Rate is 0.6286008.
3. The important attributes observed are as shown in the chart below.

![](Bank_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-13-1.png)

3. Support Vector Machines
==========================

In this algorithm, we plot each data item as a point in n-dimensional space (where n is number of features you have) with the value of each feature being the value of a particular coordinate. Then, we perform classification by finding the hyper-plane that differentiate the two classes very well. Support Vectors are simply the co-ordinates of individual observation. Support Vector Machine is a frontier which best segregates the two classes (hyper-plane/ line).

    ## Confusion Matrix and Statistics
    ## 
    ##           Reference
    ## Prediction    no   yes
    ##        no  18072  1947
    ##        yes   427  1261
    ##                                           
    ##                Accuracy : 0.8906          
    ##                  95% CI : (0.8864, 0.8948)
    ##     No Information Rate : 0.8522          
    ##     P-Value [Acc > NIR] : < 2.2e-16       
    ##                                           
    ##                   Kappa : 0.4601          
    ##  Mcnemar's Test P-Value : < 2.2e-16       
    ##                                           
    ##             Sensitivity : 0.9769          
    ##             Specificity : 0.3931          
    ##          Pos Pred Value : 0.9027          
    ##          Neg Pred Value : 0.7470          
    ##              Prevalence : 0.8522          
    ##          Detection Rate : 0.8325          
    ##    Detection Prevalence : 0.9222          
    ##       Balanced Accuracy : 0.6850          
    ##                                           
    ##        'Positive' Class : no              
    ## 

![](Bank_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-14-1.png)

    ## Area under the curve (AUC): 0.685

    ## Confusion Matrix and Statistics
    ## 
    ##           Reference
    ## Prediction   no  yes
    ##        no  7753  888
    ##        yes  231  432
    ##                                           
    ##                Accuracy : 0.8797          
    ##                  95% CI : (0.8729, 0.8863)
    ##     No Information Rate : 0.8581          
    ##     P-Value [Acc > NIR] : 5.686e-10       
    ##                                           
    ##                   Kappa : 0.3766          
    ##  Mcnemar's Test P-Value : < 2.2e-16       
    ##                                           
    ##             Sensitivity : 0.9711          
    ##             Specificity : 0.3273          
    ##          Pos Pred Value : 0.8972          
    ##          Neg Pred Value : 0.6516          
    ##              Prevalence : 0.8581          
    ##          Detection Rate : 0.8333          
    ##    Detection Prevalence : 0.9287          
    ##       Balanced Accuracy : 0.6492          
    ##                                           
    ##        'Positive' Class : no              
    ## 

![](Bank_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-14-2.png)

    ## Area under the curve (AUC): 0.649

**Observations:**

From the above graphs:
1. The AUC is 0.650, when the model is run on the Test Set.
2. The TRUE positive Rate is 0.6515837.
3. The important attributes observed are as shown in the chart below.

![](Bank_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-15-1.png)

4. Logistic Regression
======================

Logistic Regression is a special case of Linear Regression , where outcome is categorical binary outcome

    ## 
    ## Call:
    ## glm(formula = y ~ ., family = binomial, data = Training_Set)
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -5.5640  -0.4566  -0.3170  -0.2046   2.9724  
    ## 
    ## Coefficients:
    ##                      Estimate Std. Error z value Pr(>|z|)    
    ## (Intercept)        -2.368e+00  2.028e-01 -11.676  < 2e-16 ***
    ## age                 1.589e-03  2.770e-03   0.574 0.566030    
    ## jobblue-collar     -3.713e-01  9.367e-02  -3.964 7.38e-05 ***
    ## jobentrepreneur    -4.208e-01  1.638e-01  -2.570 0.010184 *  
    ## jobhousemaid       -5.451e-01  1.776e-01  -3.070 0.002143 ** 
    ## jobmanagement      -2.300e-01  9.137e-02  -2.517 0.011827 *  
    ## jobretired          1.901e-01  1.223e-01   1.555 0.119967    
    ## jobself-employed   -2.944e-01  1.383e-01  -2.128 0.033303 *  
    ## jobservices        -2.298e-01  1.065e-01  -2.157 0.031031 *  
    ## jobstudent          5.241e-01  1.361e-01   3.850 0.000118 ***
    ## jobtechnician      -1.930e-01  8.565e-02  -2.253 0.024281 *  
    ## jobunemployed      -2.222e-01  1.364e-01  -1.629 0.103353    
    ## jobunknown         -6.059e-01  4.011e-01  -1.511 0.130906    
    ## maritalmarried     -4.938e-02  7.569e-02  -0.652 0.514121    
    ## maritalsingle       1.463e-01  8.634e-02   1.695 0.090116 .  
    ## educationsecondary  1.750e-01  8.204e-02   2.133 0.032941 *  
    ## educationtertiary   4.079e-01  9.467e-02   4.308 1.65e-05 ***
    ## defaultyes         -3.505e-01  2.356e-01  -1.488 0.136869    
    ## balance             9.280e-06  6.113e-06   1.518 0.129007    
    ## housingyes         -9.219e-01  5.528e-02 -16.677  < 2e-16 ***
    ## loanyes            -4.883e-01  7.541e-02  -6.475 9.50e-11 ***
    ## contacttelephone   -2.681e-01  9.077e-02  -2.954 0.003141 ** 
    ## day                 4.715e-03  3.174e-03   1.486 0.137338    
    ## monthaug           -7.416e-01  9.478e-02  -7.825 5.09e-15 ***
    ## monthdec            1.066e+00  2.007e-01   5.311 1.09e-07 ***
    ## monthfeb           -1.452e-01  1.067e-01  -1.361 0.173664    
    ## monthjan           -1.225e+00  1.474e-01  -8.311  < 2e-16 ***
    ## monthjul           -7.674e-01  9.263e-02  -8.284  < 2e-16 ***
    ## monthjun            1.022e+00  1.219e-01   8.384  < 2e-16 ***
    ## monthmar            1.646e+00  1.403e-01  11.732  < 2e-16 ***
    ## monthmay           -3.985e-01  8.807e-02  -4.525 6.05e-06 ***
    ## monthnov           -7.977e-01  9.977e-02  -7.996 1.29e-15 ***
    ## monthoct            9.180e-01  1.273e-01   7.208 5.66e-13 ***
    ## monthsep            1.062e+00  1.380e-01   7.693 1.43e-14 ***
    ## duration            3.981e-03  8.634e-05  46.112  < 2e-16 ***
    ## campaign           -1.119e-01  1.394e-02  -8.028 9.88e-16 ***
    ## pdays               1.557e-03  2.230e-04   6.982 2.91e-12 ***
    ## previous            4.822e-02  1.026e-02   4.701 2.59e-06 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 18184  on 21706  degrees of freedom
    ## Residual deviance: 13225  on 21669  degrees of freedom
    ## AIC: 13301
    ## 
    ## Number of Fisher Scoring iterations: 6

    ## Confusion Matrix and Statistics
    ## 
    ##           Reference
    ## Prediction    no   yes
    ##        no  17898  2251
    ##        yes   601   957
    ##                                          
    ##                Accuracy : 0.8686         
    ##                  95% CI : (0.864, 0.8731)
    ##     No Information Rate : 0.8522         
    ##     P-Value [Acc > NIR] : 2.492e-12      
    ##                                          
    ##                   Kappa : 0.3376         
    ##  Mcnemar's Test P-Value : < 2.2e-16      
    ##                                          
    ##             Sensitivity : 0.9675         
    ##             Specificity : 0.2983         
    ##          Pos Pred Value : 0.8883         
    ##          Neg Pred Value : 0.6142         
    ##              Prevalence : 0.8522         
    ##          Detection Rate : 0.8245         
    ##    Detection Prevalence : 0.9282         
    ##       Balanced Accuracy : 0.6329         
    ##                                          
    ##        'Positive' Class : no             
    ## 

![](Bank_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-16-1.png)

    ## Area under the curve (AUC): 0.633

    ## Confusion Matrix and Statistics
    ## 
    ##           Reference
    ## Prediction   no  yes
    ##        no  7734  917
    ##        yes  250  403
    ##                                           
    ##                Accuracy : 0.8746          
    ##                  95% CI : (0.8677, 0.8812)
    ##     No Information Rate : 0.8581          
    ##     P-Value [Acc > NIR] : 2.069e-06       
    ##                                           
    ##                   Kappa : 0.3472          
    ##  Mcnemar's Test P-Value : < 2.2e-16       
    ##                                           
    ##             Sensitivity : 0.9687          
    ##             Specificity : 0.3053          
    ##          Pos Pred Value : 0.8940          
    ##          Neg Pred Value : 0.6172          
    ##              Prevalence : 0.8581          
    ##          Detection Rate : 0.8313          
    ##    Detection Prevalence : 0.9298          
    ##       Balanced Accuracy : 0.6370          
    ##                                           
    ##        'Positive' Class : no              
    ## 

![](Bank_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-16-2.png)

    ## Area under the curve (AUC): 0.637

**Observations:**

From the above graphs:
1. The AUC is 0.650, when the model is run on the Test Set.
2. The TRUE positive Rate is 0.6171516.
3. The important attributes observed are as shown in the chart below.

![](Bank_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-17-1.png)

Conclusions:
============

In all the four classifications models ,we can see that :
\* The duration of the call is very important.
\* The SVM shows only 2 important variables - pdays and duration \* The important common variables in the other 3 classification models are - age,housing,month and pdays.
