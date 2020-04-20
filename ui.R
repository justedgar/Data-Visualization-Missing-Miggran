library(shiny)
library(ggplot2)


shinyUI(
    
    dashboardPage(skin = "yellow", 
        
        dashboardHeader(title = "Missing Migrants Global" ),
        dashboardSidebar(
            sidebarMenu(
                menuItem(text = "Analysis", icon = icon("eye"),
                         tabName = "analysis"),
                menuItem(text = "Maps and Info",icon = icon("map-signs"),
                         tabName = "maps"),
                menuItem(text = "Dataset", icon = icon("database"),
                         tabName = "dataset")
                
                
            )
            
            
        ),
        dashboardBody( 
            
            tabItems(
                
                tabItem(tabName = "analysis",
                        align = "center",
                        h2("Accident on Years"),
                        fluidRow(
                            valueBox(value = n_distinct(data$Reported.Year),
                                     subtitle = "Data Collected Years", icon = icon("calendar-alt")),
                            valueBox(value = n_distinct(data$Cause.of.Death),
                                     subtitle = "Cause of The Accident", icon = icon("car-crash")),
                            valueBox(value = n_distinct(data$Web.ID),
                                     subtitle = "Total News", icon = icon("headset"))
                        ),
                        
                        tabsetPanel(
                            
                            tabPanel(title= "Cause of Death Bar",
                                     sliderInput(inputId= "scatter_year", label = "Insert Year"
                                                 ,min = min(data$Reported.Year),max =max(data$Reported.Year) ,
                                                 value = min(data$Reported.Year), step = 1 ),
                                     
                                     plotlyOutput(outputId = "scatter")
                                     
                            ),
                            tabPanel(title= "Cause of Death Pie",
                                     # sliderInput(inputId= "scatter2_year", label = "Insert Year"
                                     #             ,min = min(data$Reported.Year),max =max(data$Reported.Year) ,
                                     #             value = min(data$Reported.Year), step = 1 ),
                                     
                                     plotlyOutput(outputId = "scatter2"),
                                     h3("On this Pie diagram concludes from 2014 to 2020. the events that took the most victims were drowning, sickness and lack of access to medicines, and many more combined with The Others.")
                            
                            )
                            
                            )
                            
                             
                             
                        ),
                tabItem(tabName = "maps",
                        align = "center",
                        h3("Maps and Link News"),
                        
                        tabPanel(title = "Maps and Link News",
                            leafletOutput(outputId = "scatter3"),
                        h4("This is World Map, you can choose one of the accident events in each country, there can be seen the news, the scene, and others.")
                                 
                                 )
                        
                        
                        ),
                tabItem(tabName = "dataset", align = "center",
                        
                        h2("Missing Migrants Dataset"),
                        h4("Collected by  International Organization for Migration (IOM)"),
                        dataTableOutput("dataset")
           
                                          
                                 )
                                 
                             
                             
            
                
                
                
            
                        
                        
                        
                        
                        
                )
                
            )
            
)
)
