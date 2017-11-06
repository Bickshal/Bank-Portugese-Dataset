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
    ##        no  17590  1764
    ##        yes   966  1387
    ##                                           
    ##                Accuracy : 0.8742          
    ##                  95% CI : (0.8697, 0.8786)
    ##     No Information Rate : 0.8548          
    ##     P-Value [Acc > NIR] : < 2.2e-16       
    ##                                           
    ##                   Kappa : 0.4337          
    ##  Mcnemar's Test P-Value : < 2.2e-16       
    ##                                           
    ##             Sensitivity : 0.9479          
    ##             Specificity : 0.4402          
    ##          Pos Pred Value : 0.9089          
    ##          Neg Pred Value : 0.5895          
    ##              Prevalence : 0.8548          
    ##          Detection Rate : 0.8103          
    ##    Detection Prevalence : 0.8916          
    ##       Balanced Accuracy : 0.6941          
    ##                                           
    ##        'Positive' Class : no              
    ## 

![](Bank_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-9-1.png)

    ## Area under the curve (AUC): 0.694

**Model Performance with Testing Set**

    ## Confusion Matrix and Statistics
    ## 
    ##           Reference
    ## Prediction   no  yes
    ##        no  7518  818
    ##        yes  409  559
    ##                                           
    ##                Accuracy : 0.8681          
    ##                  95% CI : (0.8611, 0.8749)
    ##     No Information Rate : 0.852           
    ##     P-Value [Acc > NIR] : 4.715e-06       
    ##                                           
    ##                   Kappa : 0.4039          
    ##  Mcnemar's Test P-Value : < 2.2e-16       
    ##                                           
    ##             Sensitivity : 0.9484          
    ##             Specificity : 0.4060          
    ##          Pos Pred Value : 0.9019          
    ##          Neg Pred Value : 0.5775          
    ##              Prevalence : 0.8520          
    ##          Detection Rate : 0.8080          
    ##    Detection Prevalence : 0.8960          
    ##       Balanced Accuracy : 0.6772          
    ##                                           
    ##        'Positive' Class : no              
    ## 

![](Bank_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-10-1.png)

    ## Area under the curve (AUC): 0.677

**Observations:**

From the above graphs:
1. The AUC is 0.695, when the model is run on the Test Set.
2. The TRUE positive Rate is 0.5774793.
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
    ##        no  18556    60
    ##        yes     0  3091
    ##                                           
    ##                Accuracy : 0.9972          
    ##                  95% CI : (0.9964, 0.9979)
    ##     No Information Rate : 0.8548          
    ##     P-Value [Acc > NIR] : < 2.2e-16       
    ##                                           
    ##                   Kappa : 0.9888          
    ##  Mcnemar's Test P-Value : 2.599e-14       
    ##                                           
    ##             Sensitivity : 1.0000          
    ##             Specificity : 0.9810          
    ##          Pos Pred Value : 0.9968          
    ##          Neg Pred Value : 1.0000          
    ##              Prevalence : 0.8548          
    ##          Detection Rate : 0.8548          
    ##    Detection Prevalence : 0.8576          
    ##       Balanced Accuracy : 0.9905          
    ##                                           
    ##        'Positive' Class : no              
    ## 

![](Bank_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-12-1.png)

    ## Area under the curve (AUC): 0.990

    ## Confusion Matrix and Statistics
    ## 
    ##           Reference
    ## Prediction   no  yes
    ##        no  7551  737
    ##        yes  376  640
    ##                                           
    ##                Accuracy : 0.8804          
    ##                  95% CI : (0.8736, 0.8869)
    ##     No Information Rate : 0.852           
    ##     P-Value [Acc > NIR] : 1.27e-15        
    ##                                           
    ##                   Kappa : 0.468           
    ##  Mcnemar's Test P-Value : < 2.2e-16       
    ##                                           
    ##             Sensitivity : 0.9526          
    ##             Specificity : 0.4648          
    ##          Pos Pred Value : 0.9111          
    ##          Neg Pred Value : 0.6299          
    ##              Prevalence : 0.8520          
    ##          Detection Rate : 0.8116          
    ##    Detection Prevalence : 0.8908          
    ##       Balanced Accuracy : 0.7087          
    ##                                           
    ##        'Positive' Class : no              
    ## 

![](Bank_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-12-2.png)

    ## Area under the curve (AUC): 0.709

**Observations:**

From the above graphs:
1. The AUC is 0.712, when the model is run on the Test Set.
2. The TRUE positive Rate is 0.6299213.
3. The important attributes observed are as shown in the chart below.

![](Bank_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-13-1.png)

3. Support Vector Machines
==========================

In this algorithm, we plot each data item as a point in n-dimensional space (where n is number of features you have) with the value of each feature being the value of a particular coordinate. Then, we perform classification by finding the hyper-plane that differentiate the two classes very well. Support Vectors are simply the co-ordinates of individual observation. Support Vector Machine is a frontier which best segregates the two classes (hyper-plane/ line).

    ## Confusion Matrix and Statistics
    ## 
    ##           Reference
    ## Prediction    no   yes
    ##        no  18121  1903
    ##        yes   435  1248
    ##                                           
    ##                Accuracy : 0.8923          
    ##                  95% CI : (0.8881, 0.8964)
    ##     No Information Rate : 0.8548          
    ##     P-Value [Acc > NIR] : < 2.2e-16       
    ##                                           
    ##                   Kappa : 0.462           
    ##  Mcnemar's Test P-Value : < 2.2e-16       
    ##                                           
    ##             Sensitivity : 0.9766          
    ##             Specificity : 0.3961          
    ##          Pos Pred Value : 0.9050          
    ##          Neg Pred Value : 0.7415          
    ##              Prevalence : 0.8548          
    ##          Detection Rate : 0.8348          
    ##    Detection Prevalence : 0.9225          
    ##       Balanced Accuracy : 0.6863          
    ##                                           
    ##        'Positive' Class : no              
    ## 

![](Bank_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-14-1.png)

    ## Area under the curve (AUC): 0.686

    ## Confusion Matrix and Statistics
    ## 
    ##           Reference
    ## Prediction   no  yes
    ##        no  7698  935
    ##        yes  229  442
    ##                                          
    ##                Accuracy : 0.8749         
    ##                  95% CI : (0.868, 0.8816)
    ##     No Information Rate : 0.852          
    ##     P-Value [Acc > NIR] : 1.132e-10      
    ##                                          
    ##                   Kappa : 0.3706         
    ##  Mcnemar's Test P-Value : < 2.2e-16      
    ##                                          
    ##             Sensitivity : 0.9711         
    ##             Specificity : 0.3210         
    ##          Pos Pred Value : 0.8917         
    ##          Neg Pred Value : 0.6587         
    ##              Prevalence : 0.8520         
    ##          Detection Rate : 0.8274         
    ##    Detection Prevalence : 0.9279         
    ##       Balanced Accuracy : 0.6460         
    ##                                          
    ##        'Positive' Class : no             
    ## 

![](Bank_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-14-2.png)

    ## Area under the curve (AUC): 0.646

**Observations:**

From the above graphs:
1. The AUC is 0.650, when the model is run on the Test Set.
2. The TRUE positive Rate is 0.6587183.
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
    ## -5.5957  -0.4494  -0.3060  -0.1959   2.9989  
    ## 
    ## Coefficients:
    ##                      Estimate Std. Error z value Pr(>|z|)    
    ## (Intercept)        -2.505e+00  2.045e-01 -12.246  < 2e-16 ***
    ## age                 3.095e-03  2.795e-03   1.107  0.26819    
    ## jobblue-collar     -3.762e-01  9.576e-02  -3.928 8.56e-05 ***
    ## jobentrepreneur    -2.414e-01  1.544e-01  -1.564  0.11790    
    ## jobhousemaid       -3.012e-01  1.684e-01  -1.789  0.07366 .  
    ## jobmanagement      -1.839e-01  9.208e-02  -1.997  0.04583 *  
    ## jobretired          3.477e-01  1.228e-01   2.832  0.00463 ** 
    ## jobself-employed   -3.218e-01  1.435e-01  -2.243  0.02487 *  
    ## jobservices        -2.228e-01  1.079e-01  -2.064  0.03901 *  
    ## jobstudent          6.405e-01  1.384e-01   4.629 3.67e-06 ***
    ## jobtechnician      -1.994e-01  8.675e-02  -2.298  0.02157 *  
    ## jobunemployed      -2.471e-01  1.413e-01  -1.748  0.08039 .  
    ## jobunknown         -6.675e-01  4.127e-01  -1.617  0.10582    
    ## maritalmarried     -1.230e-01  7.624e-02  -1.614  0.10661    
    ## maritalsingle       1.794e-01  8.684e-02   2.066  0.03885 *  
    ## educationsecondary  1.815e-01  8.287e-02   2.190  0.02849 *  
    ## educationtertiary   3.981e-01  9.584e-02   4.154 3.27e-05 ***
    ## defaultyes         -5.532e-01  2.589e-01  -2.136  0.03266 *  
    ## balance             1.368e-05  6.236e-06   2.194  0.02826 *  
    ## housingyes         -9.075e-01  5.621e-02 -16.145  < 2e-16 ***
    ## loanyes            -5.945e-01  7.859e-02  -7.564 3.89e-14 ***
    ## contacttelephone   -2.525e-01  9.063e-02  -2.786  0.00534 ** 
    ## day                 8.918e-03  3.198e-03   2.789  0.00529 ** 
    ## monthaug           -7.231e-01  9.449e-02  -7.653 1.96e-14 ***
    ## monthdec            8.576e-01  2.047e-01   4.190 2.79e-05 ***
    ## monthfeb           -1.008e-01  1.063e-01  -0.948  0.34294    
    ## monthjan           -1.163e+00  1.440e-01  -8.079 6.52e-16 ***
    ## monthjul           -7.717e-01  9.284e-02  -8.311  < 2e-16 ***
    ## monthjun            1.039e+00  1.213e-01   8.570  < 2e-16 ***
    ## monthmar            1.592e+00  1.438e-01  11.067  < 2e-16 ***
    ## monthmay           -4.325e-01  8.965e-02  -4.824 1.41e-06 ***
    ## monthnov           -8.616e-01  1.012e-01  -8.511  < 2e-16 ***
    ## monthoct            7.523e-01  1.284e-01   5.857 4.71e-09 ***
    ## monthsep            1.210e+00  1.410e-01   8.581  < 2e-16 ***
    ## duration            4.040e-03  8.676e-05  46.568  < 2e-16 ***
    ## campaign           -1.248e-01  1.424e-02  -8.767  < 2e-16 ***
    ## pdays               1.465e-03  2.270e-04   6.456 1.08e-10 ***
    ## previous            4.759e-02  9.969e-03   4.774 1.81e-06 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 17983  on 21706  degrees of freedom
    ## Residual deviance: 12907  on 21669  degrees of freedom
    ## AIC: 12983
    ## 
    ## Number of Fisher Scoring iterations: 6

    ## Confusion Matrix and Statistics
    ## 
    ##           Reference
    ## Prediction    no   yes
    ##        no  17951  2172
    ##        yes   605   979
    ##                                           
    ##                Accuracy : 0.8721          
    ##                  95% CI : (0.8676, 0.8765)
    ##     No Information Rate : 0.8548          
    ##     P-Value [Acc > NIR] : 1.25e-13        
    ##                                           
    ##                   Kappa : 0.3504          
    ##  Mcnemar's Test P-Value : < 2.2e-16       
    ##                                           
    ##             Sensitivity : 0.9674          
    ##             Specificity : 0.3107          
    ##          Pos Pred Value : 0.8921          
    ##          Neg Pred Value : 0.6181          
    ##              Prevalence : 0.8548          
    ##          Detection Rate : 0.8270          
    ##    Detection Prevalence : 0.9270          
    ##       Balanced Accuracy : 0.6390          
    ##                                           
    ##        'Positive' Class : no              
    ## 

![](Bank_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-16-1.png)

    ## Area under the curve (AUC): 0.639

    ## Confusion Matrix and Statistics
    ## 
    ##           Reference
    ## Prediction   no  yes
    ##        no  7674  994
    ##        yes  253  383
    ##                                           
    ##                Accuracy : 0.866           
    ##                  95% CI : (0.8589, 0.8728)
    ##     No Information Rate : 0.852           
    ##     P-Value [Acc > NIR] : 6.448e-05       
    ##                                           
    ##                   Kappa : 0.3166          
    ##  Mcnemar's Test P-Value : < 2.2e-16       
    ##                                           
    ##             Sensitivity : 0.9681          
    ##             Specificity : 0.2781          
    ##          Pos Pred Value : 0.8853          
    ##          Neg Pred Value : 0.6022          
    ##              Prevalence : 0.8520          
    ##          Detection Rate : 0.8248          
    ##    Detection Prevalence : 0.9316          
    ##       Balanced Accuracy : 0.6231          
    ##                                           
    ##        'Positive' Class : no              
    ## 

![](Bank_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-16-2.png)

    ## Area under the curve (AUC): 0.623

**Observations:**

From the above graphs:
1. The AUC is 0.650, when the model is run on the Test Set.
2. The TRUE positive Rate is 0.6022013.
3. The important attributes observed are as shown in the chart below.

![](Bank_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-17-1.png)

Conclusions:
============

In all the four classifications models ,we can see that :
\* The duration of the call is very important.
\* The SVM shows only 2 important variables - pdays and duration \* The important common variables in the other 3 classification models are - age,housing,month and pdays.
