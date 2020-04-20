library(shiny)
library(ggplot2)

shinyServer(
    
    function(input, output){
        # Bar
        output$scatter <- renderPlotly({
            ######
           
                data_x <- data.CoD %>%  
                    filter(Reported.Year == input$scatter_year) %>% 
                    arrange(desc(total)) %>% 
                    head(15)
                
                p1 <- data_x %>% 
                    ggplot(aes(x = Cause.of.Death %>% reorder(total) , y = total,
                               text = glue("Cause of Death: {Cause.of.Death}
                       Number of Death: {total}
                       Year of Accident: {Reported.Year}")
                    )) + 
                    geom_col(mapping = aes(fill= total), col= "pink") +
                    coord_flip()+
                    labs(title = glue("Accident in {data_x$Reported.Year[1]}"),
                         subtitle = "Cause of Death",
                         x = "",
                         y = "Dead of Count")
                
                ggplotly(p1, tooltip = "text")
            
            
            
        })
        # Pie
        output$scatter2 <- renderPlotly({
            ######
            
            
            data.2 <- data %>% 
                group_by(Cause.of.Death) %>% 
                summarise(total = n()) %>% 
                arrange(desc(total))
            
            
            data.xx <- data.2 %>% 
                head(5) %>%
                bind_rows(data.frame(Cause.of.Death = "Others",
                                     total = sum(data.2$total[-c(1:10)])))
            
            plot_ly(data.xx, labels = ~Cause.of.Death , values = ~total, type= "pie") %>% 
                layout(xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                       yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
            
            
        })
        # Maps
        output$scatter3 <- renderLeaflet({
            #####
            leaflet() %>% 
                addTiles() %>% 
                addMarkers(data = data,
                           lat = ~longitude,
                           lng = ~latitude,
                           popup = paste("Area:", data$Location.Description,"<br>",
                                         "Time Accident:", data$Reported.Date,"<br>",
                                         "Number of Death:", data$Number.Dead, "<br>",
                                         "<a href =", data$URL,">", "Link for the News", "</a>"),
                           clusterOptions = markerClusterOptions())
            
            
        })
        
        
        output$dataset <- renderDataTable({
            #######
            DT::datatable(data, options = list(
                    pageLengeth = 20,
                    scrollX= T,
                    scrollCollapse=T
                
            ))
            
            
        })
            
            
            
        })
        
        
      