ws = "/Users/jaydeep/jaydeep_workstation/Workplace/Kaggle/ActiveCode/MovieReviewSentiment/"
ws_img = "/Users/jaydeep/jaydeep_workstation/Workplace/Kaggle/ActiveCode/MovieReviewSentiment/img/"
setwd(ws)


mons.data <- read.csv("Monsterhunting.csv", header = T)

################################################################################################
#Data Analysis
dim(mons.data)#371   7 - row col
str(mons.data)
head(mons.data)
summary(mons.data)
################################################################################################

################################################################################################
mons.data = subset(mons.data, select = -c(id))#removed id

#Changing numerical to Categorical
mons.data$color = as.numeric(mons.data$color)
mons.data$color = as.factor(mons.data$color)
mons.data$type = as.numeric(mons.data$type)
mons.data$type = as.factor(mons.data$type)
################################################################################################


################################################################################################
############ covariance analysis- corelation plot start############
any(is.na(mons.data)) #FALSE it does not contain any NA value
df1 = subset(mons.data, select = -c(color, type)) #removing Categorical columns
library(corrplot)
flnm <- paste(ws_img,"corr_",".jpeg", sep="")
jpeg(file = flnm)
M <- cor(df1)
corrplot(M, method='circle',type="upper") #method="pie","color","number"
dev.off()
##### covariance analysis- corelation plot end########
################################################################################################

################################################################################################
############## outlier analysis - histogram start#####################
cols = c('bone_length','rotting_flesh','hair_length','has_soul') #only numerical features
for (ind in cols){
  flnm <- paste(ws_img,"hist_",ind,".jpeg", sep="")
  jpeg(file = flnm)
  labnm <- paste("histogram of feature",colnm, sep=" ")
  hist(mons.data[,ind], xlab= ind, main =labnm, col = 'pink')
  dev.off()
}
############## outlier analysis - histogram end ##############
################################################################################################

################################################################################################
##### outlier analysis- boxplot using plotly start######
library(plotly)
cols = c('bone_length','rotting_flesh','hair_length','has_soul') #only numerical features
for (ind in cols){
  flnm <- paste(ws_img,"box_",ind,".jpeg", sep="")
  p <- plot_ly(type = 'box', data= mons.data, x = ~type, y = mons.data[,ind],
               marker = list(color = 'rgb(7,40,89)'),
               line = list(color = 'rgb(7,40,89)'))
  export(p, file = flnm)
}
##### outlier analysis- boxplot using plotly end######
################################################################################################


################################################################################################
###Scatter plot with PCA
library(ggplot2)
flnm <- paste(ws_img,"pca_",".jpeg", sep="")
jpeg(file = flnm)
df3 = subset(mons.data, select = -c(type,color))
mons.pca <- prcomp(df3, scale. = FALSE)
mons.data.pca <- as.data.frame(mons.pca$x)
#Adding class data for coloring
df4 = subset(mons.data, select = c(type))
mons.data.pca <- cbind(mons.data.pca, df4)
#plotting with first two principle components
ggplot(mons.data.pca, aes(x=mons.data.pca[,1],y=mons.data.pca$type))+
  geom_point(aes(color=factor(mons.data.pca$type)))+ #we need dicrete class- label color
  ggtitle("Scatter plot of Credit Data PC1 - Class")+
  xlab("PC1") + ylab("Type")
dev.off()
################################################################################################

################################################################################################
#Data imbalance
#This will show how many unique class labels are present 1 2 3
unique(mons.data$type)
#This will show fequencies of each class label
##1   2   3 
#117 129 125
#So clearly it is balanced data
table(mons.data$type)
flnm <- paste(ws_img,"df_",".jpeg", sep="")
jpeg(file = flnm)
barplot(table(mons.data$type))
dev.off()
################################################################################################


################################################################################################
library(caret)
set.seed(1234)
splitIndex <- createDataPartition(mons.data$type, p = .70,list = FALSE,times = 1)
trainSplit <- mons.data[ splitIndex,]
testSplit <- mons.data[-splitIndex,] 
################################################################################################

################################################################################################
library(e1071)
tc <- tune.control(cross = 10)
tuning <- tune.svm(type~., data = trainSplit, cost = 10^(-1:3), gamma = c(0.1,0.5,1,2,5), tunecontrol = tc)
summary(tuning)
################################################################################################

################################################################################################
#generating optimal model
model <- svm(type~., data = testSplit, cost=1, gamma = 0.1)
################################################################################################

################################################################################################
#Evaluation
test_X = subset(testSplit, select = -c(type))
y_predicted <- predict(model, test_X)
confusionMatrix(data=y_predicted, testSplit$type)
################################################################################################
