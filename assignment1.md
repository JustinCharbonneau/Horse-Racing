# Preprocessing and Building a Classifier
## Machine Learning Assignment 1

### Abstract

This paper will go over many preprocessing tasks, followed by building a classifier in
the first time I will be using the R language, but I have done my best to keep it simple. As I wish
to become a data scientist one day, I wanted this paper to follow a “story telling” approach, with
a mix of information with the code and their output.

### Loading the necessary libraries

```{r include = TRUE}
library(knitr)
library(chron)
library(ggplot2)
theme_set(theme_gray())
library(splitstackshape)
set.seed(1) # so we can resample later to double check!
library(RWeka)
```

### Introduction
