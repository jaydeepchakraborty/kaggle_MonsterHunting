Monster Hunting (https://www.kaggle.com/c/ghouls-goblins-and-ghosts-boo)
================

DataSet:
--------
The dataset contains 5 feautures of three different ghosts.

Goal:
-----
Findout the the kind of ghost.

Monsterhunting.csv
id || bone_length || rotting_flesh || hair_length || has_soul || color || type

id - id of the creature
bone_length - average length of bone in the creature, normalized between 0 and 1
rotting_flesh - percentage of rotting flesh in the creature
hair_length - average hair length, normalized between 0 and 1
has_soul - percentage of soul in the creature
color - dominant color of the creature: 'white','black','clear','blue','green','blood'
type - target variable: 'Ghost', 'Goblin', and 'Ghoul' (Target)

Project Modules:

Module1:
------------------------------
a) Data Analysis
--There are total 371 obs(row) of 7 variables(cols)</br>
--We have removed 'id' column.
--From the data, all the features are in int format but if we look closely then color and type(Target) should be categorical. After the changes, the dataset looks like this

<img width="400" height="400" alt="dataset" src="https://github.com/jaydeepchakraborty/kaggle_MonsterHunting/blob/master/img/dataset.png"/>

--Following is the corelation matrix, here we can see 'has_soul' is positively co related with 'bone_length' and 'hair_length' but as we have very less features, we are keeping all the features.

<img width="400" height="400" alt="dataset" src="https://github.com/jaydeepchakraborty/kaggle_MonsterHunting/blob/master/img/corr_.jpeg"/>

--From the below figure, we can see the data does not have any outliers and from histogram we can observe each feature is following normal distribution.

<table>
  <tr>
  <td>bone_length</td>
  <td>hair_length</td>
  <td>has_soul</td>
  <td>rotting_flesh</td>
  </tr>
  <tr>
  <td><img width="400" height="300" alt="hist_plot" src="https://github.com/jaydeepchakraborty/kaggle_MonsterHunting/blob/master/img/hist_bone_length.jpeg"></td>
  <td><img width="400" height="300" alt="hist_plot" src="https://github.com/jaydeepchakraborty/kaggle_MonsterHunting/blob/master/img/hist_hair_length.jpeg"></td>
  <td><img width="400" height="300" alt="hist_plot" src="https://github.com/jaydeepchakraborty/kaggle_MonsterHunting/blob/master/img/hist_has_soul.jpeg"></td>
  <td><img width="400" height="300" alt="hist_plot" src="https://github.com/jaydeepchakraborty/kaggle_MonsterHunting/blob/master/img/hist_rotting_flesh.jpeg"></td>
  </tr>
</table>


<table>
  <tr>
  <td>bone_length</td>
  <td>hair_length</td>
  <td>has_soul</td>
  <td>rotting_flesh</td>
  </tr>
  <tr>
  <td><img width="400" height="300" alt="box_plot" src="https://github.com/jaydeepchakraborty/kaggle_MonsterHunting/blob/master/img/box_bone_length.jpeg"></td>
  <td><img width="400" height="300" alt="box_plot" src="https://github.com/jaydeepchakraborty/kaggle_MonsterHunting/blob/master/img/box_hair_length.jpeg"></td>
  <td><img width="400" height="300" alt="box_plot" src="https://github.com/jaydeepchakraborty/kaggle_MonsterHunting/blob/master/img/box_has_soul.jpeg"></td>
  <td><img width="400" height="300" alt="box_plot" src="https://github.com/jaydeepchakraborty/kaggle_MonsterHunting/blob/master/img/box_rotting_flesh.jpeg"></td>
  </tr>
</table>

--Follwing is the scatter plot of primary component-1 vs type <br>
<img width="400" height="400" alt="pca_plot" src="https://github.com/jaydeepchakraborty/kaggle_MonsterHunting/blob/master/img/pca_.jpeg"/>

--The following is the frequency of each class. It is a balanced data, we do not have to use SMOTE here.<br>
<img width="400" height="400" alt="sd_bar_plot" src="https://github.com/jaydeepchakraborty/kaggle_MonsterHunting/blob/master/img/df_.jpeg"/>

Module2:
------------------------------
a) Data split:

train:70%
test:30%

We have used 10 fold cross fold validation to find out the best hyper parameter for SVM algo.<br>

<b>
Parameter tuning of ‘svm’:

- sampling method: 10-fold cross validation 

- best parameters:
 gamma cost
   0.1    1

- best performance: 0.2448718 </b>

Module3:
------------------------------
a) Evaluation:

<b>
Confusion Matrix and Statistics
         
  <table>
    <tr>
      <td colspan=4 align="right">Reference</td>
    </tr>
    <tr>
      <td>Prediction</td>
      <td>1</td>
      <td>2</td>
      <td>3</td>
    </tr>
  <tr>
      <td>1</td>
      <td>34</td>
      <td>0</td>
      <td>2</td>
    </tr>
  <tr>
      <td>2</td>
      <td>0</td>
      <td>28</td>
      <td>12</td>
    </tr>
  <tr>
      <td>3</td>
      <td>1</td>
      <td>10</td>
      <td>23</td>
    </tr>
  
  </table>

Overall Statistics
                                         
               Accuracy : 0.7727         
                 95% CI : (0.683, 0.8472)
    No Information Rate : 0.3455         
    P-Value [Acc > NIR] : < 2.2e-16      
                                         
                  Kappa : 0.6589         
 Mcnemar's Test P-Value : NA             

Statistics by Class:


<table>
    <tr>
      <td></td>
      <td>Class: 1</td>
      <td>Class: 2</td>
      <td>Class: 3</td>
    </tr>
    <tr>
      <td>Sensitivity</td>
      <td>0.9714</td>
      <td>0.7368</td>
      <td>0.6216</td>
    </tr>
   <tr>
      <td>Specificity</td>
      <td>0.9733</td>
      <td>0.8333</td>
      <td>0.8493</td>
    </tr>
   <tr>
      <td>Pos Pred Value</td>
      <td>0.9444</td>
      <td>0.7000</td>
      <td>0.6765</td>
    </tr> <tr>
      <td>Neg Pred Value</td>
      <td>0.9865</td>
      <td>0.8571</td>
      <td>0.8158</td>
    </tr> <tr>
      <td>Prevalence</td>
      <td>0.3182 </td>
      <td>0.3455</td>
      <td>0.3364</td>
    </tr> <tr>
      <td>Detection Rate</td>
      <td>0.3091</td>
      <td>0.2545</td>
      <td>0.2091</td>
    </tr> <tr>
      <td>Detection Prevalence</td>
      <td>0.3273</td>
      <td>0.3636</td>
      <td>0.3091</td>
    </tr> <tr>
      <td>Balanced Accuracy</td>
      <td>0.9724</td>
      <td>0.7851</td>
      <td>0.7355</td>
    </tr>
  
  </table>

