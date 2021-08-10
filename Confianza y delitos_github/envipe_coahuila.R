#Debo cargar (activar) los paquetes:
library(ggplot2)
library(dplyr)
library(tidyverse)
library(lubridate)
library(dplyr)
#remove everything
rm (list = ls())

# Import CSV files
envipe <- read_csv("C:/Users/Dell/Documents/UAdeC/diplomadoseguridad/envipe_coahuila/cpp_coahuila2.csv")
attach(envipe)
View(envipe)
str(envipe)
summary(envipe)

#Para transformar las variables a formato numérico, si es necesario:
envipe$Periodo <- as.numeric(envipe$Periodo)
envipe$Confianza <- as.numeric(envipe$Confianza)

#En este caso ya no es necesario, porque ya están en numérico.

#Ahora debo transformar a formato de fecha la variable "Año":
#(Checar esta página: https://www.r-graph-gallery.com/time-series.html)
View(envipe)

#Voy a intentar la gráfica de líneas, para no batallar con series de tiempo:
#Esta es la buena, solo que antes instalé ggrepel, para evitar 
#solapamiento de etiquetas:
install.packages("devtools")
devtools::install_github("slowkow/ggrepel")
library(ggrepel)

chart_cpp <- ggplot(envipe, aes(x=Periodo, y=Confianza, group=Policia, color=Policia)) +
  geom_line() + geom_point() + 
  geom_text_repel(label=(envipe$Confianza), fontface="bold", nudge_x = 0.25, nudge_y = 0.30,
            check_overlap = T, size=3, color="black") +
  labs(title="Confianza en las policías en Coahuila\n(% que reporta algo o mucho)") +
  theme(plot.title = element_text(face = "bold", hjust = 0.5)) +
  theme(axis.text.x = element_text(face="bold")) +
  theme(axis.text.y = element_text(face="bold")) + xlab("Año") +
  scale_y_continuous(breaks=c(30,40,50,60,70),limits=c(25,75)) +
  scale_x_continuous(breaks=c(2012,2013,2014,2015,2016,2017,2018,2019),limits=c(2012,2020))
  
chart_cpp

chart_cpp + theme(
  panel.background = element_rect(fill = "white", #Relleno del grid
                                  colour = "lightgray", #Contorno de todo el grid
                                  size = 0.5, linetype = "solid"),
  panel.grid.major = element_line(size = 0.5, linetype = 'solid',
                                  colour = "lightgray"), #líneas dentro del grid 
  panel.grid.minor = element_line(size = 0.25, linetype = 'solid',
                                  colour = "lightgray")) #líneas dentro del grid

################################################
#Para usar labels, también puedo usar "labs()":
chart + labs(title="Confianza en policía estatal de Coahuila\n(% que reporta algo o mucho)") + 
  theme(plot.title = element_text(face = "bold", hjust = 0.5)) +
  scale_y_continuous(breaks=c(35,40,45,50,55,60,65,70),limits=c(25,75)) +
  scale_x_continuous(breaks=c(2012,2013,2014,2015,2016,2017,2018,2019),limits=c(2012,2019))

#Voy a tratar una gráfica dinámica con base de datos original:
envipe2 <- read_csv("C:/Users/Dell/Documents/UAdeC/diplomadoseguridad/cpp_coahuila.csv")
attach(envipe2)
View(envipe2)
str(envipe2)
chart2 <- dygraph(envipe2)
chart2

chart2 + labs(title="Confianza en policía estatal de Coahuila\n(% que reporta algo o mucho)") + 
  theme(plot.title = element_text(face = "bold",hjust = 0.5)) +
  scale_y_continuous(breaks=c(30,35,40,45,50,55,60,65,70),limits=c(25,70)) +
  scale_x_continuous(breaks=c(2012,2013,2014,2015,2016,2017,2018,2019),limits=c(2012,2019))


#Traté todo lo que viene a continuación, pero no jaló bien:
#The following is for converting into date format (only year):
Año <- c(2012,2013,2014,2015,2016,2017,2018,2019)
Periodo <- as.Date(as.character(Año), format = "%Y")
y <- year(Periodo)
y

cpp_coahuila <- c(50.8,51.3,50.1,60.9,57.5,58.6,60.6,63.6)
as.numeric(cpp_coahuila)

data <- data.frame(Año = y, Confianza = cpp_coahuila)
data

chart <- ggplot(data, aes(x=Año, y=Confianza)) +
  geom_line() + geom_point() +geom_label(label=(data$Confianza), 
    nudge_x = 0.25, nudge_y = 0.25) + xlab("Año") 
chart  

chart + labs(title="Confianza en policía estatal de Coahuila\n(% que reporta algo o mucho)") + 
  theme(plot.title = element_text(face = "bold", hjust = 0.5)) +
  scale_y_continuous(breaks=c(45,50,55,60,65,70),limits=c(40,70)) +
  scale_x_continuous(breaks=c(2012,2013,2014,2015,2016,2017,2018,2019),limits=c(2012,2019))

#dygraphs jalan bien, pero no puedo incluir los títulos. Esto
#es algo que puedo incluir directamente en el word doc, o en
#mi entrada del blog.
library(dygraphs)
Año2 <- as.numeric(Año)
data2 <- data.frame(Año = Año2, Confianza = cpp_coahuila)
data2
str(data2)

chart2 <- dygraph(data2)
chart2
