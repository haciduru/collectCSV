
#!/usr/bin/env Rscript
args = commandArgs(trailingOnly = TRUE)

# ******************************************************************************
# One argument
# 1. output file name
# ******************************************************************************
vargs = c('--help', '-h')
if (length(args) == 0) {
  cat('\nPlease enter the output file name...\n\n')
} else {
  if (args[1] %in% vargs) {
    cat('\nThis script does not have documentation yet...\nComing soon...\n\n')
  } else {
    files = list.files()
    if (args[1] %in% files) {
      cat('\nOutput file already exists. Please enter another file name...\n\n')
    } else {
      files = files[grep('[.]csv', files)]
      
      nams = c()
      for (f in files) {
        df = read.csv(f)
        nams = unique(c(nams, names(df)))
      }
      rm(f, df)
      
      df = as.data.frame(matrix(rep(NA, length(nams)), nrow = 1))
      names(df) = nams
      for (f in files) {
        dum = read.csv(f)
        add = nams[!(nams %in% names(dum))]
        addf = as.data.frame(matrix(rep(NA, length(add)*nrow(dum)), ncol = length(add)))
        names(addf) = add
        dum = cbind(dum, addf)
        df = rbind(df, dum)
      }
      rm(addf, add, dum, f)
      df = df[-1,]
      df = df[!duplicated(df), ]
      
      write.csv(df, args[1], row.names = F)
    }
  }
}
