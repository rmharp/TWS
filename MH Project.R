#' ---
#' title: "MH Project"
#' output: html_document
#' date: "2023-10-28"
#' ---
#' 
## ----setup, include=FALSE--------------------------------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
if(!require(MASS)) { install.packages("MASS", repos = "http://cran.us.r-project.org"); library(MASS) }
if(!require(dplyr)) { install.packages("dplyr", repos = "http://cran.us.r-project.org"); library(dplyr) }
if(!require(readr)) { install.packages("readr", repos = "http://cran.us.r-project.org"); library(readr) }
if(!require(ppsr)) { install.packages("ppsr", repos = "http://cran.us.r-project.org"); library(ppsr) }
if(!require(likert)) { install.packages("likert", repos = "http://cran.us.r-project.org"); library(likert) }

#' 
## --------------------------------------------------------------------------------------------------------------------
#Rename to your filename
filename <- "Survey on Student Mental Health Outcomes"
#Create a data file within the same wd and put the data you'd like to read into it
data <- suppressMessages(read_csv(paste0("./data/", filename, ".csv"), show_col_types = F))
names(data) <- data[1,]
data <- data[c(7:58,60:nrow(data)), c(7, 9, 18, 19, 21:(ncol(data)-4))]
data <- data %>%
  filter(Finished == "True") %>%
  select(-Finished)
names(data) <- sub("\\?.*$", "", names(data))
names(data) <- gsub(" ", "_", names(data))
names(data) <- sapply(names(data), function(name) substr(name, 1, 30))
data <- data.frame(lapply(data, function(x) gsub("Neither agree nor disagree", "Neutral", x)))
data <- data.frame(lapply(data, function(x) gsub("Neither agree or disagree", "Neutral", x)))
data$What_is_your_class_standing_at <- as.integer(factor(data$What_is_your_class_standing_at, levels = c("First year undergraduate", "Second year undergraduate", "Third year undergraduate", "Fourth year undergraduate", "Fifth year undergraduate")))
# Identify rows where "Other (please explain):" is present in any column
data <- data.frame(apply(data, 2, function(x) gsub(";", ":", x)))
for (i in c(4, 6, 8, 16, 18, 20, 22)) {
  rows_to_replace <- apply(data, 1, function(row) any(grepl("Other \\(please explain\\):", row)))

  # Remove "Other (please explain):" from the current column and replace with the value from the next column
  for (j in which(rows_to_replace)) {
    if (rows_to_replace[j]) {
      data[j, i] <- ifelse(!is.na(data[j, i + 1]), data[j, i + 1], data[j, i])
    }
  }
}
data <- data[, -c(5, 7, 9, 17, 19, 21, 23)]
data$What_is_your_age <- as.integer(data$What_is_your_age)
data$Think_of_this_ladder_as_repres <- as.integer(data$Think_of_this_ladder_as_repres)
data$What_is_your_class_standing_at <- as.integer(data$What_is_your_class_standing_at)
data <- data[, -c(14, 15, 16)]
columns_to_factor <- c(4:6, 8:ncol(data))

# Factor the selected columns
for (col_index in columns_to_factor) {
  column_name <- colnames(data)[col_index]
  data[[column_name]] <- factor(data[[column_name]])
}
suppressWarnings(visualize_pps(df = data))
visualize_correlations(df = data)

#' 
## --------------------------------------------------------------------------------------------------------------------
names(data) <- gsub("_", " ", names(data))
levs <- c("Completely disagree", "Disagree", "Neutral", "Agree", "Completely agree")
data[8:12] <- data.frame(lapply(data[8:12], function (x) factor(x, levels = levs)))
lik.plot <- plot(likert(data[8:12]), text.size = 4) + 
  theme_bw(base_size = 8) + 
  theme(legend.position = "bottom") + 
  labs(title = "MH Data")
lik.plot

