
vars <- list(currWk=8,
             numWks=4
            )


matchups <-  function(x){  #see line 140 for call
  rbind(data.frame(Week=x$Week,Team=x$Road,Oppn=gsub('@','',x$Home)),
        data.frame(Week=x$Week,Team=gsub('@','',x$Home),Oppn=x$Road))}

buildThisWk <- function(week,schedule){
  x <- schedule[which(schedule$Week==week),]
  
  # CREDIT: https://stackoverflow.com/questions/19297475/simplest-way-to-get-rbind-to-ignore-column-names
  x <- rbind(x[c(3,4)],setNames(rev(x[c(3,4)]),names(x[c(3,4)])))
  colnames(x) <- c('Team','Oppn')
  x <- cbind(Week=week,x)
  x
}

# wks 1 to vars$numWks
aggPriorWks <- function(weeklybox, numWks=vars$numWks){ 
  aggregate(.~Team,
            data=subset(weeklybox,weeklybox$Week %in% c((max(weeklybox$Week)-vars$numWks+1):(max(weeklybox$Week))))[c(2,6:87)],
            FUN=sum)
}

getMetric <- function(weeklyBoxAgg, team, colnum){
  sapply(team,function(x){weeklyBoxAgg[which(weeklyBoxAgg$Team==x),][colnum]})
}
