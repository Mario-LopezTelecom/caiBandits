load("dataBandits")
library("zoo")
library("Rlab")
windowedMeans <- apply(click_vs_test_field_vals,2,rollmean,k=10000)
matplot(windowedMeans,
        type="l",
        xlab="Muestra",ylab="",
        ylim=c(0,0.3),
        main="CTR medio con ventana de 1000 muestras",
        col=grey(c(0,0.3,0.6,0.9)))
test = rbern(length(click_vs_test_field_vals[,3]),0.25)
lines(rollmean(test,k=1000),type="l",col="red")
# load("dataBandits")
# library("Rlab")
# plot(cumsum(click_vs_test_field_vals[,1])/1:length(click_vs_test_field_vals[,3]),
#      type="l",
#      col=grey(0),
#      ylim=c(0,0.3),
#      xlab="Muestras",
#      ylab="CTR")
# lines(cumsum(click_vs_test_field_vals[,2])/1:length(click_vs_test_field_vals[,3]),col=grey(0.3))
# lines(cumsum(click_vs_test_field_vals[,3])/1:length(click_vs_test_field_vals[,3]),col=grey(0.6))
# lines(cumsum(click_vs_test_field_vals[,4])/1:length(click_vs_test_field_vals[,3]),col=grey(0.9))
# test = rbern(length(click_vs_test_field_vals[,3]),0.25)
# lines(cumsum(test)/1:length(click_vs_test_field_vals[,3]),type="l",col="red")
# 
# legend("bottomright", 
#        c("Bernoulli(p=0.25)","rama 1","rama 2","rama 3","rama 4"),
#        cex=0.7,
#        lty=c(1,1,1,1,1), 
#        lwd=c(2.5,2.5,2.5,2.5,2.5), 
#        col=c("red",grey(0),grey(0.3),grey(0.6),grey(0.9))) 