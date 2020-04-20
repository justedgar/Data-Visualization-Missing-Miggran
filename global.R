library(scales)
library(glue)
library(ggplot2)
library(plotly)
library(leaflet)

#aplikasii
library(shiny)
library(shinydashboard)
library(DT)


#pengolahan data

library(dplyr)
library(readr)
library(tidyr)
library(stringr)

data <- read.csv("MissingMigrants-Global-2020-01-28T17-08-10.csv")

data <- data %>% 
  replace_na(list(Number.Dead = 0, 
                  Minimum.Estimated.Number.of.Missing = 0,
                  Total.Dead.and.Missing = 0,
                  Number.of.Survivors = 0,
                  Number.of.Females=0,
                  Number.of.Males=0,
                  Number.of.Children = 0))
data[,c("Region.of.Incident","Cause.of.Death","Location.Description","UNSD.Geographical.Grouping")] <- lapply(data[,c("Region.of.Incident","Cause.of.Death","Location.Description","UNSD.Geographical.Grouping")],as.character)

data <- data %>% 
  separate(Location.Coordinates, c("longitude","latitude"),",")

data[,c("longitude","latitude")] <- lapply(data[,c("longitude","latitude")],as.numeric)

data.CoD <- data %>% 
  group_by(Cause.of.Death,Reported.Year) %>% 
  summarise(total = n()) %>% 
  arrange(desc(total)) 
