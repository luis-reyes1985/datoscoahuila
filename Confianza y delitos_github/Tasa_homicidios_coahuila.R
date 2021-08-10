rm (list = ls())

#Debo cargar (activar) los paquetes:
library(ggplot2)
library(dplyr)
library(tidyverse)
library(lubridate)
library(dplyr)
library(ggrepel)

homicidios <- read_csv("C:/Users/Dell/Documents/UAdeC/diplomadoseguridad/envipe_coahuila/tasahomicidios.csv")
attach(homicidios)
View(homicidios)
str(homicidios)
summary(homicidios)

chart_homicidios <- ggplot(homicidios, aes(x=Periodo, y=Tasa)) +
  geom_line() + geom_point() + 
  geom_text_repel(label=(homicidios$Tasa), fontface="bold", nudge_x = 0.15, nudge_y = 0.30,
                  check_overlap = T, size=3, color="black") +
  labs(title="Tasa de homicidios dolosos en Coahuila\n(cada 100,000 habitantes)") + 
  theme(plot.title = element_text(face = "bold", hjust = 0.5)) +
  theme(axis.text.x = element_text(face="bold")) +
  theme(axis.text.y = element_text(face="bold")) + xlab("Año") +
  scale_y_continuous(breaks=c(0,5,10,15,20,25,30,35),limits=c(0,35)) +
  scale_x_continuous(breaks=c(1997,1999,2001,2003,2005,2007,2010,
                              2012,2014,2016,2018,2020),limits=c(1997,2020))

chart_homicidios

chart_homicidios + theme(
  panel.background = element_rect(fill = "white", #Relleno del grid
                                  colour = "lightgray", #Contorno de todo el grid
                                  size = 0.5, linetype = "solid"),
  panel.grid.major = element_line(size = 0.5, linetype = 'solid',
                                  colour = "lightgray"), #líneas dentro del grid 
  panel.grid.minor = element_line(size = 0.25, linetype = 'solid',
                                  colour = "lightgray")) #líneas dentro del grid


