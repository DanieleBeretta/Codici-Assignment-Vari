## LAB 8
rm(list=ls())
library(tidyverse)

# Set the vorking directory and import the dataset
setwd("C:/Users/dapaf/OneDrive/Desktop/ML LABS/lab 8")
dev <- read.csv("C:/Users/dapaf/OneDrive/Desktop/ML LABS/lab 8/development-indicators (1).csv")
glimpse(dev)

#Observe the names of the rows and set it according to the country's name
rownames(dev)
rownames(dev)=dev$countryname

#Compute the mean vector and the var vector
dev%>%
  select(is.numeric)%>%
  summarise_all(mean)

dev%>%
  select(is.numeric)%>%
  summarise_all(var)

library(ggcorrplot)
dev%>%
  select_if(is.numeric)%>%
  cor()%>%
  ggcorrplot(hc.order=TRUE, type="lower",
             lab=TRUE)

# PRINCIPAL COMPONENT ANALYSIS
pca=dev%>%select_if(is.numeric)%>%prcomp(center=T, scale=T)
names(pca)
pca$rotation
pca$x

summary(pca)

screeplot(pca)

var_explained_df=data.frame(PC=1:length(pca$sdev),
                            var_explained=(cumsum(pca$sdev^2))/sum((pca$sdev)^2))
var_explained_df

var_explained_df%>%ggplot()+
  geom_point(aes(x=PC, y=var_explained), size=4)+
  geom_line(aes(x=PC, y=var_explained))+
  geom_line(aes(x=PC, y=var_explained))+
  ggtitle("Scree plot: PCA on sclaed data")

#Observe the first two principal components
pca$rotation[, 1:2]

#Observe the variable correlation in the first PCA
data.frame(select_if(dev, is.numeric), PC1=pca$x[,1])%>%
  cor()%>%
  ggcorrplot(hc.order=TRUE,
             type="lower",
             lab=TRUE)

#Observe the variable correlation in the 2nd PCA
data.frame(select_if(dev, is.numeric), PC2=pca$x[,2])%>%
  cor()%>%
  ggcorrplot(hc.order=TRUE,
             type="lower",
             lab=TRUE)
#So PC2 is basically uncorrelated with all the variables except Population TOtala

#Observe the screeplot to show loadings and the scores with repspect to PC1 and PC2
biplot(pca,
       xlabs=dev$countryname,
       scale=0,
       cex=0.5)
#Improve the graphs
library(ggfortify)
autoplot(pca,
         data=dev,
         scale=0,
         label=T,
         loadings=T,
         loadings.colour="blue",
         loadings.label=T,
         loadings.label.size=3)

#PC2 is negatively with PopulationTotal
#PC1 is explaining the WGI and wealth of country

## CLUSTERING
scaledevnum=dev%>%
  select_if(is.numeric)%>%scale()

library(factoextra)

fviz_dist(get_dist(scaledevnum))

## HIERARCHICAL CLUSTERING
Hclusters=hclust(dist(scaledevnum),
                 method="average")
#Plot the dendogram
plot(Hclusters, cex=0.7, hang=1)

#We have to decide where to cut the dendogram tree
HclustersCut=cutree(Hclusters, h=4)
HclustersCut

table(HclustersCut)

data.frame(HclustersCut)%>%arrange(HclustersCut)

#Add the rectangles to the dendogram
plot(Hclusters, cex=0.7, hang=1)
rect.hclust(Hclusters, h=4, border=c("red", "blue", "green"))
#First cluster contains 13 countries (green)
#Second cluster contatins 25 countries(blue)
#third cluster is only RUssian Federation

## HIERARCHICAL CLUSTERING with COMPLETE METHOD
Hclusters2=hclust(dist(scaledevnum),
                 method="complete")
#Plot the dendogram
plot(Hclusters2, cex=0.7, hang=1)

#We have to decide where to cut the dendogram tree
HclustersCut2=cutree(Hclusters2, k=3)
HclustersCut2

table(HclustersCut2)

data.frame(HclustersCut2)%>%arrange(HclustersCut2)

#Add the rectangles to the dendogram
plot(Hclusters2, cex=0.7, hang=1)
rect.hclust(Hclusters2, k=3, border=c("red", "blue", "green"))

#third cluster is more than one country

## K-Means clustering
set.seed(44)
cl3=kmeans(scaledevnum,
           centers=3,
           iter.max=1000,
           nstart=25)
cl3

data.frame(cl3$cluster)%>%arrange(cl3.cluster)
table(cl3$cluster)

autoplot(cl3,
         data=scaledevnum,
         scale=0,
         label=TRUE,
         frame=TRUE,
         frame.type="norm")
cl3

#observe a plot for the optimal number of clusters
fviz_nbclust(scaledevnum,
             kmeans, method="wss")

#Increase the k means to 5
set.seed(44)
cl5=kmeans(scaledevnum,
           centers=5,
           iter.max=1000,
           nstart=25)
cl5

data.frame(cl5$cluster)%>%arrange(cl5.cluster)
table(cl5$cluster)

autoplot(cl5,
         data=scaledevnum,
         scale=0,
         label=TRUE,
         frame=TRUE,
         frame.type="norm")
