library(shiny)
library(shinythemes)
library(RColorBrewer)

data = read.csv("gdp_committed_cost_data.csv", sep = ";")

# Define UI for application.
ui = fluidPage(
    theme = shinytheme("paper"),
    
    # Application title.
    titlePanel("Visually Exploring Brazilian Cities' Gross Domestic Products
               (GDPs) and Committed Costs"),
    helpText("Committed costs are budgeted payments to be made in the future for
             goods or services yet to be taken."),
    
    fluidRow(
        column(2, align = "center", 
               h3(textOutput("textCostID")), tableOutput("tableCostID")),
        column(4, plotOutput("histCostID")),
        column(2, align = "center",
               h3(textOutput("textGDPID")), tableOutput("tableGDPID")),
        column(4, plotOutput("histGDPID"))
    ),
    fluidRow(
        column(3, plotOutput("boxplotCostID")),
        column(3, plotOutput("boxplotGDPID")),
        column(6, plotOutput("scatterPlotID"))
    ),
    fluidRow(
        column(4, plotOutput("largestCostID")),
        column(4, plotOutput("largestGDPID")),
        column(4, plotOutput("largestProportionID"))
    )
)

# Define server logic.
server = function(input, output) {
    output$textCostID = renderText({
        "Committed Cost Descriptive Stats"
    })
    output$tableCostID = renderTable({
        as.array(summary(data$COMMITTEDCOST))
    })
    output$textGDPID = renderText({
        "GDP Descriptive Stats"
    })
    output$tableGDPID = renderTable({
        as.array(summary(data$GDP))
    })
    output$histCostID = renderPlot({
        hist(data$COMMITTEDCOST, main = "Committed Cost Values",
             col = brewer.pal(n = 3, name = "Paired"), xlab = "Committed Cost")
    })
    output$histGDPID = renderPlot({
        hist(data$GDP, main = "GDP Values",
             col = brewer.pal(n = 3, name = "Pastel1"), xlab = "GDP")
    })
    
    
    output$boxplotCostID = renderPlot({
        boxplot(data$COMMITTEDCOST, main = "Committed Cost Values",
                col = brewer.pal(n = 3, name = "Paired"), outline = F, horizontal = T)
    })
    output$boxplotGDPID = renderPlot({
        boxplot(data$GDP, main = "GDP Values",
                col = brewer.pal(n = 3, name = "Pastel1"), outline = F, horizontal = T)
    })
    
    
    output$scatterPlotID = renderPlot({
        plot(data$COMMITTEDCOST, data$GDP, main = "Committed Cost vs. GDP",
             col = "blue", xlab = "Committed Cost", ylab = "GDP", pch = 19)
    })
    
    
    topCosts = head(data[order(-data$COMMITTEDCOST), ], 10)
    output$largestCostID = renderPlot({
        barplot(topCosts$COMMITTEDCOST, main = "Largest Committed Costs",
                col = brewer.pal(n = 10, name = "RdBu"), xlab = "Committed Cost", las = 2)
        legend("topright", legend = topCosts$CITY,
               col = brewer.pal(n = 10, name = "RdBu"), ncol = 2, cex = 0.8, lwd = 4)
        box()
    })
    topGDPs = head(data[order(-data$GDP), ], 10)
    output$largestGDPID = renderPlot({
        pie(topGDPs$GDP, main = "Largest GDPs", labels = topGDPs$CITY,
            col = brewer.pal(n = 10, name = "Spectral"), xlab = "GDPs")
    })
    
    
    data$PROPORTION = data$COMMITTEDCOST / data$GDP
    topProportions = head(data[order(-data$PROPORTION), ], 10)
    output$largestProportionID = renderPlot({
        barplot(topProportions$PROPORTION, main = "Largest Committed Cost/GDP Ratio",
                col = brewer.pal(n = 10, name = "Set3"), xlab = "Proportion", las = 2)
        legend("topright", legend = topProportions$CITY,
               col = brewer.pal(n = 10, name = "Set3"), ncol = 2, cex = 0.8, lwd = 4)
        box()
    })
}

# Run the application.
shinyApp(ui = ui, server = server)
