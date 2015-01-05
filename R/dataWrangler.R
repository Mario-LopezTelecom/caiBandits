#dataWrangler
#parameters:

read <- TRUE
num_samples <- 1e7
plot <- FALSE

if (read == TRUE){
  rm(list=setdiff(ls(),c("read","num_samples","plot")))
  data <- read.table(gzfile("train.gz"),header=T,sep=",",nrows=num_samples)
} else {
  rm(list=setdiff(ls(),c("data","read","num_samples","plot")))
}
test_field <- "device_model" #field to use as actions for the bandits 
# id            click             hour               C1       banner_pos 
# site_id      site_domain    site_category           app_id       app_domain 
# app_category        device_id        device_ip     device_model      device_type 
# device_conn_type              C14              C15              C16              C17 
# C18              C19              C20              C21 



num_fields <- length(data)
names_fields <- colnames(data)
num_diff_elem_fields <- rep(NA,num_fields)
names(num_diff_elem_fields) <- names_fields
for (i in 1:num_fields){
  num_diff_elem_fields[i] <- length(unique(data[,i]))
}
print(num_diff_elem_fields)
test_field_vals <- factor(data[,test_field],labels=1:num_diff_elem_fields[test_field])
freq_vals <- table(test_field_vals)
if(plot==TRUE){
  plot(freq_vals,main=test_field,type="h",xaxt="n")
  at <- pretty(1:length(freq_vals))
  axis(side=1, at=at)
} else{
  #Ramas potenciales (bien muestreadas) con 300.000
  #"banner_pos": 2c
  #"site_id": 2
  #"site_domain": 2
  #"site_category": 3 - 4
  #"app_id": 1
  #"app_domain": 1 - 2
  #"app_category": 1 - 2
  #"device_id": 1
  #"device_ip": many
  #"device_model": 3 (+ multiples con en torno a 5000 muestras)
  #"device_type": 1
  #"device_conn_type": 1
  
  num_selected_vals <- 4
  freq_vals<-unname(freq_vals)
  click_vs_test_field_vals <- matrix(ncol = num_selected_vals, nrow = num_samples) 
  for (i in 1:num_selected_vals){
    high_freq_val <- which.max(freq_vals)
    click_ind <- which(test_field_vals == high_freq_val)
    click_vs_test_field_vals[1:freq_vals[high_freq_val],i] <- data[click_ind,"click"]
    freq_vals[high_freq_val] <- 0
  }
  click_vs_test_field_vals<-click_vs_test_field_vals[1:length(click_ind),]
  ctr <- colSums(click_vs_test_field_vals)
  save("click_vs_test_field_vals","ctr",file = "dataBandits")
  write.csv(click_vs_test_field_vals, file = "ctr_data",row.names=FALSE, col.names=FALSE)
}