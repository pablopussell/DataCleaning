setwd("C:/Users/a9alumno/Documents/DataCleaning")
person = c("Matteo", "Jhon", "Alica", "Maria")
age = c(18, NA, 22, 15)
gender = c("M", "M", "F", "F")
df1 = data.frame(person, age, gender)

head(df1)
summary(df1)

person = c("Matteo", "Jhon", "Alica", "Maria")
country = c("IT", "US", "US", "SP")
df2 = data.frame(person, country)
head(df2)
summary(df2)
df = merge(df1, df2, by = "person")
head(df)
df$person
table(df$gender)
head(df)
df$age[is.na(df$age)] = mean(df$age, na.rm = TRUE)
head(df)
df$age = round(df$age,0)
head(df)
df[1:2,]
df[c(1,3),]
df[c(1,3),c(1,2)]
df[which(df$gender=='F'),]
df[df$gender=='F',]
write.csv(df, file = "test_df.csv")


powerdf = read.csv("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = '?')
head(powerdf, 10)
summary(powerdf)
dim(powerdf)
names(powerdf)
boxplot(powerdf$Global_active_power)
names(powerdf) = c("date","time","active_power","reactive_power","voltage", "intensity","sub_met_1","sub_met_2","sub_met_3")
head(powerdf)
length(unique(powerdf$date))
dim(powerdf[duplicated(powerdf),])
dup_df = powerdf[duplicated(powerdf),]
write.csv(dup_df, file="duplicates.csv")
powerdf = powerdf[!duplicated(powerdf),]
dim(powerdf)
?complete.cases
head(complete.cases(powerdf))
dim(powerdf[!complete.cases(powerdf),])
powerdf_withoutna = powerdf[complete.cases(powerdf),]
dim(powerdf)
dim(powerdf_withoutna)
powerdf_withoutna$date = as.POSIXct(powerdf_withoutna$date, format = "%d/%m/%Y")
powerdf_withoutna$month = format(as.POSIXlt(powerdf_withoutna$date), "%Y-%m")
head(powerdf_withoutna)
avg_active_power_xmonth = aggregate(active_power ~ month , powerdf_withoutna, FUN=mean)
head(avg_active_power_xmonth)
meas_xmonth = aggregate(active_power ~ month , powerdf_withoutna, FUN = length)
names(meas_xmonth) = c("month","meas_count")
head(meas_xmonth)
avg_active_power_xmonth = avg_active_power_xmonth[order(avg_active_power_xmonth$active_power),]
head(avg_active_power_xmonth)
