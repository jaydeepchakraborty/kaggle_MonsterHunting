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




