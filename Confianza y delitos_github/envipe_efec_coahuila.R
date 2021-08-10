#remove everything
rm (list = ls())

#Debo cargar (activar) los paquetes:
library(ggplot2)
library(dplyr)
library(tidyverse)
library(lubridate)
library(dplyr)

#Ya instalé esto --> install.packages("devtools")
#Esto también --> devtools::install_github("slowkow/ggrepel")
#Debo abrir ggrepel:
library(ggrepel)

# Import CSV files
envipe2 <- read_csv("C:/Users/Dell/Documents/UAdeC/diplomadoseguridad/envipe_coahuila/efec_coahuila.csv")
attach(envipe2)
View(envipe2)
str(envipe2)
summary(envipe2)

chart_efec <- ggplot(envipe2, aes(x=Periodo, y=Efectividad, group=Policias, color=Policias)) +
  geom_line() + geom_point() + 
  geom_text_repel(label=(envipe2$Efectividad), fontface="bold", nudge_x = 0.25, nudge_y = 0.30,
                  check_overlap = T, size=3, color="black") +
  labs(title="Efectividad de las policías en Coahuila\n(% que reporta algo o mucho)") + 
  theme(plot.title = element_text(face = "bold", hjust = 0.5)) +
  theme(axis.text.x = element_text(face="bold")) +
  theme(axis.text.y = element_text(face="bold")) + xlab("Año") +
  scale_y_continuous(breaks=c(30,40,50,60,70),limits=c(25,75)) +
  scale_x_continuous(breaks=c(2012,2013,2014,2015,2016,2017,2018,2019),limits=c(2012,2020))

chart_efec

chart_efec + theme(
  panel.background = element_rect(fill = "white", #Relleno del grid
                                  colour = "lightgray", #Contorno de todo el grid
                                  size = 0.5, linetype = "solid"),
  panel.grid.major = element_line(size = 0.5, linetype = 'solid',
                                  colour = "lightgray"), #líneas dentro del grid 
  panel.grid.minor = element_line(size = 0.25, linetype = 'solid',
                                  colour = "lightgray")) #líneas dentro del grid

################################################

