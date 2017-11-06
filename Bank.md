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
    ##        no  17770  1945
    ##        yes   771  1221
    ##                                           
    ##                Accuracy : 0.8749          
    ##                  95% CI : (0.8704, 0.8793)
    ##     No Information Rate : 0.8541          
    ##     P-Value [Acc > NIR] : < 2.2e-16       
    ##                                           
    ##                   Kappa : 0.4066          
    ##  Mcnemar's Test P-Value : < 2.2e-16       
    ##                                           
    ##             Sensitivity : 0.9584          
    ##             Specificity : 0.3857          
    ##          Pos Pred Value : 0.9013          
    ##          Neg Pred Value : 0.6130          
    ##              Prevalence : 0.8541          
    ##          Detection Rate : 0.8186          
    ##    Detection Prevalence : 0.9082          
    ##       Balanced Accuracy : 0.6720          
    ##                                           
    ##        'Positive' Class : no              
    ## 

![](Bank_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-9-1.png)

    ## Area under the curve (AUC): 0.672

**Model Performance with Testing Set**

    ## Confusion Matrix and Statistics
    ## 
    ##           Reference
    ## Prediction   no  yes
    ##        no  7609  826
    ##        yes  333  536
    ##                                           
    ##                Accuracy : 0.8754          
    ##                  95% CI : (0.8685, 0.8821)
    ##     No Information Rate : 0.8536          
    ##     P-Value [Acc > NIR] : 6.552e-10       
    ##                                           
    ##                   Kappa : 0.4136          
    ##  Mcnemar's Test P-Value : < 2.2e-16       
    ##                                           
    ##             Sensitivity : 0.9581          
    ##             Specificity : 0.3935          
    ##          Pos Pred Value : 0.9021          
    ##          Neg Pred Value : 0.6168          
    ##              Prevalence : 0.8536          
    ##          Detection Rate : 0.8178          
    ##    Detection Prevalence : 0.9066          
    ##       Balanced Accuracy : 0.6758          
    ##                                           
    ##        'Positive' Class : no              
    ## 

![](Bank_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-10-1.png)

    ## Area under the curve (AUC): 0.676

**Observations:**

From the above graphs:
1. The AUC is 0.695, when the model is run on the Test Set.
2. The TRUE positive Rate is 0.6168009.
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
    ##        no  18541    68
    ##        yes     0  3098
    ##                                          
    ##                Accuracy : 0.9969         
    ##                  95% CI : (0.996, 0.9976)
    ##     No Information Rate : 0.8541         
    ##     P-Value [Acc > NIR] : < 2.2e-16      
    ##                                          
    ##                   Kappa : 0.9873         
    ##  Mcnemar's Test P-Value : 4.476e-16      
    ##                                          
    ##             Sensitivity : 1.0000         
    ##             Specificity : 0.9785         
    ##          Pos Pred Value : 0.9963         
    ##          Neg Pred Value : 1.0000         
    ##              Prevalence : 0.8541         
    ##          Detection Rate : 0.8541         
    ##    Detection Prevalence : 0.8573         
    ##       Balanced Accuracy : 0.9893         
    ##                                          
    ##        'Positive' Class : no             
    ## 

![](Bank_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-12-1.png)

    ## Area under the curve (AUC): 0.989

    ## Confusion Matrix and Statistics
    ## 
    ##           Reference
    ## Prediction   no  yes
    ##        no  7565  713
    ##        yes  377  649
    ##                                           
    ##                Accuracy : 0.8828          
    ##                  95% CI : (0.8761, 0.8893)
    ##     No Information Rate : 0.8536          
    ##     P-Value [Acc > NIR] : < 2.2e-16       
    ##                                           
    ##                   Kappa : 0.4779          
    ##  Mcnemar's Test P-Value : < 2.2e-16       
    ##                                           
    ##             Sensitivity : 0.9525          
    ##             Specificity : 0.4765          
    ##          Pos Pred Value : 0.9139          
    ##          Neg Pred Value : 0.6326          
    ##              Prevalence : 0.8536          
    ##          Detection Rate : 0.8131          
    ##    Detection Prevalence : 0.8897          
    ##       Balanced Accuracy : 0.7145          
    ##                                           
    ##        'Positive' Class : no              
    ## 

![](Bank_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-12-2.png)

    ## Area under the curve (AUC): 0.715

**Observations:**

From the above graphs:
1. The AUC is 0.712, when the model is run on the Test Set.
2. The TRUE positive Rate is 0.6325536.
3. The important attributes observed are as shown in the chart below.

![](Bank_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-13-1.png)

3. Support Vector Machines
==========================

In this algorithm, we plot each data item as a point in n-dimensional space (where n is number of features you have) with the value of each feature being the value of a particular coordinate. Then, we perform classification by finding the hyper-plane that differentiate the two classes very well. Support Vectors are simply the co-ordinates of individual observation. Support Vector Machine is a frontier which best segregates the two classes (hyper-plane/ line).

    ## Confusion Matrix and Statistics
    ## 
    ##           Reference
    ## Prediction    no   yes
    ##        no  18120  1931
    ##        yes   421  1235
    ##                                           
    ##                Accuracy : 0.8916          
    ##                  95% CI : (0.8874, 0.8958)
    ##     No Information Rate : 0.8541          
    ##     P-Value [Acc > NIR] : < 2.2e-16       
    ##                                           
    ##                   Kappa : 0.4579          
    ##  Mcnemar's Test P-Value : < 2.2e-16       
    ##                                           
    ##             Sensitivity : 0.9773          
    ##             Specificity : 0.3901          
    ##          Pos Pred Value : 0.9037          
    ##          Neg Pred Value : 0.7458          
    ##              Prevalence : 0.8541          
    ##          Detection Rate : 0.8348          
    ##    Detection Prevalence : 0.9237          
    ##       Balanced Accuracy : 0.6837          
    ##                                           
    ##        'Positive' Class : no              
    ## 

![](Bank_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-14-1.png)

    ## Area under the curve (AUC): 0.684

    ## Confusion Matrix and Statistics
    ## 
    ##           Reference
    ## Prediction   no  yes
    ##        no  7706  910
    ##        yes  236  452
    ##                                         
    ##                Accuracy : 0.8768        
    ##                  95% CI : (0.87, 0.8834)
    ##     No Information Rate : 0.8536        
    ##     P-Value [Acc > NIR] : 5.051e-11     
    ##                                         
    ##                   Kappa : 0.3801        
    ##  Mcnemar's Test P-Value : < 2.2e-16     
    ##                                         
    ##             Sensitivity : 0.9703        
    ##             Specificity : 0.3319        
    ##          Pos Pred Value : 0.8944        
    ##          Neg Pred Value : 0.6570        
    ##              Prevalence : 0.8536        
    ##          Detection Rate : 0.8282        
    ##    Detection Prevalence : 0.9261        
    ##       Balanced Accuracy : 0.6511        
    ##                                         
    ##        'Positive' Class : no            
    ## 

![](Bank_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-14-2.png)

    ## Area under the curve (AUC): 0.651

**Observations:**

From the above graphs:
1. The AUC is 0.650, when the model is run on the Test Set.
2. The TRUE positive Rate is 0.6569767.
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
    ## -5.5240  -0.4545  -0.3114  -0.1989   3.0112  
    ## 
    ## Coefficients:
    ##                      Estimate Std. Error z value Pr(>|z|)    
    ## (Intercept)        -2.616e+00  2.048e-01 -12.777  < 2e-16 ***
    ## age                 3.348e-03  2.798e-03   1.197 0.231468    
    ## jobblue-collar     -3.040e-01  9.518e-02  -3.194 0.001402 ** 
    ## jobentrepreneur    -3.932e-01  1.600e-01  -2.457 0.013993 *  
    ## jobhousemaid       -3.769e-01  1.691e-01  -2.229 0.025788 *  
    ## jobmanagement      -2.014e-01  9.254e-02  -2.176 0.029522 *  
    ## jobretired          3.265e-01  1.224e-01   2.667 0.007657 ** 
    ## jobself-employed   -2.594e-01  1.421e-01  -1.825 0.067961 .  
    ## jobservices        -1.083e-01  1.063e-01  -1.019 0.308435    
    ## jobstudent          5.206e-01  1.392e-01   3.740 0.000184 ***
    ## jobtechnician      -1.906e-01  8.709e-02  -2.189 0.028608 *  
    ## jobunemployed      -9.629e-02  1.369e-01  -0.703 0.481853    
    ## jobunknown         -4.355e-01  3.889e-01  -1.120 0.262846    
    ## maritalmarried     -1.072e-01  7.549e-02  -1.420 0.155468    
    ## maritalsingle       1.925e-01  8.598e-02   2.239 0.025165 *  
    ## educationsecondary  2.391e-01  8.324e-02   2.872 0.004081 ** 
    ## educationtertiary   4.818e-01  9.588e-02   5.025 5.05e-07 ***
    ## defaultyes         -3.551e-01  2.437e-01  -1.458 0.144971    
    ## balance             2.426e-05  6.223e-06   3.899 9.66e-05 ***
    ## housingyes         -8.976e-01  5.578e-02 -16.092  < 2e-16 ***
    ## loanyes            -5.021e-01  7.650e-02  -6.563 5.27e-11 ***
    ## contacttelephone   -3.437e-01  9.283e-02  -3.703 0.000213 ***
    ## day                 1.009e-02  3.201e-03   3.151 0.001626 ** 
    ## monthaug           -6.874e-01  9.380e-02  -7.329 2.33e-13 ***
    ## monthdec            7.909e-01  2.056e-01   3.847 0.000120 ***
    ## monthfeb           -1.423e-01  1.073e-01  -1.326 0.184731    
    ## monthjan           -1.279e+00  1.462e-01  -8.753  < 2e-16 ***
    ## monthjul           -7.879e-01  9.237e-02  -8.530  < 2e-16 ***
    ## monthjun            1.065e+00  1.206e-01   8.831  < 2e-16 ***
    ## monthmar            1.709e+00  1.422e-01  12.019  < 2e-16 ***
    ## monthmay           -4.377e-01  8.803e-02  -4.973 6.61e-07 ***
    ## monthnov           -9.504e-01  1.013e-01  -9.379  < 2e-16 ***
    ## monthoct            8.824e-01  1.277e-01   6.909 4.86e-12 ***
    ## monthsep            9.967e-01  1.411e-01   7.065 1.61e-12 ***
    ## duration            3.974e-03  8.638e-05  46.009  < 2e-16 ***
    ## campaign           -1.210e-01  1.410e-02  -8.585  < 2e-16 ***
    ## pdays               1.697e-03  2.251e-04   7.537 4.80e-14 ***
    ## previous            4.044e-02  1.041e-02   3.884 0.000103 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 18036  on 21706  degrees of freedom
    ## Residual deviance: 13071  on 21669  degrees of freedom
    ## AIC: 13147
    ## 
    ## Number of Fisher Scoring iterations: 6

    ## Confusion Matrix and Statistics
    ## 
    ##           Reference
    ## Prediction    no   yes
    ##        no  17946  2226
    ##        yes   595   940
    ##                                           
    ##                Accuracy : 0.87            
    ##                  95% CI : (0.8655, 0.8745)
    ##     No Information Rate : 0.8541          
    ##     P-Value [Acc > NIR] : 8.649e-12       
    ##                                           
    ##                   Kappa : 0.3367          
    ##  Mcnemar's Test P-Value : < 2.2e-16       
    ##                                           
    ##             Sensitivity : 0.9679          
    ##             Specificity : 0.2969          
    ##          Pos Pred Value : 0.8896          
    ##          Neg Pred Value : 0.6124          
    ##              Prevalence : 0.8541          
    ##          Detection Rate : 0.8267          
    ##    Detection Prevalence : 0.9293          
    ##       Balanced Accuracy : 0.6324          
    ##                                           
    ##        'Positive' Class : no              
    ## 

![](Bank_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-16-1.png)

    ## Area under the curve (AUC): 0.632

    ## Confusion Matrix and Statistics
    ## 
    ##           Reference
    ## Prediction   no  yes
    ##        no  7686  935
    ##        yes  256  427
    ##                                          
    ##                Accuracy : 0.872          
    ##                  95% CI : (0.865, 0.8787)
    ##     No Information Rate : 0.8536         
    ##     P-Value [Acc > NIR] : 1.805e-07      
    ##                                          
    ##                   Kappa : 0.3545         
    ##  Mcnemar's Test P-Value : < 2.2e-16      
    ##                                          
    ##             Sensitivity : 0.9678         
    ##             Specificity : 0.3135         
    ##          Pos Pred Value : 0.8915         
    ##          Neg Pred Value : 0.6252         
    ##              Prevalence : 0.8536         
    ##          Detection Rate : 0.8261         
    ##    Detection Prevalence : 0.9266         
    ##       Balanced Accuracy : 0.6406         
    ##                                          
    ##        'Positive' Class : no             
    ## 

![](Bank_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-16-2.png)

    ## Area under the curve (AUC): 0.641

**Observations:**

From the above graphs:
1. The AUC is 0.650, when the model is run on the Test Set.
2. The TRUE positive Rate is 0.625183.
3. The important attributes observed are as shown in the chart below.

![](Bank_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-17-1.png)

Conclusions:
============

In all the four classifications models ,we can see that :
\* The duration of the call is very important.
\* The SVM shows only 2 important variables - pdays and duration \* The important common variables in the other 3 classification models are - age,housing,month and pdays.
