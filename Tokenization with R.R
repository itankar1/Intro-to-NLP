# Install packages

install.packages("tidytext")
install.packages("dplyr")
installed.packages("tidyverse")

# Load the packages

library(dplyr)
library(tidytext)
library(tidyverse)

# Load the animal_farm dataset

animal_farm <- read_csv("animal_farm.csv")

## Tokenization: sentences

# Split the text_column into sentences
animal_farm %>%
  unnest_tokens(output = "sentences", input = text_column, token = "sentences") %>%
  # Count sentences, per chapter
  count(chapter)

# Split the text_column using regular expressions
animal_farm %>%
  unnest_tokens(output = "sentences", input = text_column,
                token = 'regex', pattern = '\\.') %>%
  count(chapter)

## Text preprocessing: remove stop words

# Tokenize animal farm's text_column column
tidy_animal_farm <- animal_farm %>%
  unnest_tokens(word, text_column) 

# Print the word frequencies
tidy_animal_farm %>%
  count(word, sort = TRUE)

# Remove stop words, using stop_words from tidytext
tidy_animal_farm %>%
  anti_join(stop_words)

## Text preprocessing: Stemming

install.packages("SnowballC")

# Load the wordStem function
library(SnowballC)

# Perform stemming on tidy_animal_farm
stemmed_animal_farm <- tidy_animal_farm %>%
  mutate(word = wordStem(word))

# Print the old word frequencies 
tidy_animal_farm %>%
  count(word, sort = TRUE)

# Print the new word frequencies
stemmed_animal_farm %>%
  count(word, sort = TRUE)


