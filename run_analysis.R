run_analysis<-function(){
#reading all the data
	train<-read.table("train/X_train.txt")
	test<-read.table("test/X_test.txt")
	trainy<-read.table("train/y_train.txt")
	testy<-read.table("test/y_test.txt")
	trainsub<-read.table("train/subject_train.txt")
	testsub<-read.table("test/subject_test.txt")
	feat<-read.table("features.txt")
	actlabels<-read.table("activity_labels.txt")
#binding the test and train data separately
	testfull<-cbind(testsub,testy,test)
	trainfull<-cbind(trainsub,trainy,train)
#binding the two datasets together
	full<-rbind(trainfull,testfull)
#renaming the columns referring to the measured data using the features data set
	names(full)[3:563]<-t(feat[2])
#renaming the first two columns (Subject and Activity)
	names(full)[1]<-"Subject"
	names(full)[2]<-"Activity"
#selecting only those columns that contain mean or std
	require(sqldf)
	selected<-full[,grep(paste(c("mean()","std()"),collapse="|"),names(full),value=TRUE)]
#inserting Subject and Activity columns back to front
	selected<-cbind(full[1:2],selected)
#inserting the activity labels columns to the back, then substituting the activity numbers with the labels
#then rearranging the columns and column labels
	merged<-merge(selected,actlabels,by.x="Activity",by.y="V1")
	merged[1]<-merged[82]
	merged[1:2]<-merged[2:1]
	names(merged)[1:2]<-names(merged)[2:1]
#cutting down the last column
	merged<-merged[1:81]
#rearranging by Subject and Activity 
	library(dplyr)
	arrd<-arrange(merged,Subject,Activity)
#melting the table according to the ids Subject and Activity
	library(reshape2)
	arrdMelt<-melt(arrd,id=c("Subject","Activity"),measure.vars=names(arrd[3:81]))
#dcasting according to the Subject and Activity and taking the mean
	arrd5<-dcast(arrdMelt,Subject+Activity~variable,mean)
#writing the table as output
	write.table(arrd5,"output.txt",row.name=FALSE)
	arrd5
}

	
	