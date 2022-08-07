library(shiny)
library(shinythemes)
library(RColorBrewer)

data = read.csv("../data/raw/gdp_investment_data.csv", sep = ";")

# Define UI for application
ui = fluidPage(
    theme = shinytheme("paper"),
    
    # Application title
    titlePanel("Visually Exploring Brazilian Cities GDPs and Public Investments"),
    
    fluidRow(
        column(2, align = "center", h3(textOutput("textInvestmentID")),
               tableOutput("tableInvestmentID")),
        column(4, plotOutput("histInvestmentID")),
        column(2, align = "center", h3(textOutput("textGDPID")),
               tableOutput("tableGDPID")),
        column(4, plotOutput("histGDPID"))
    ),
    fluidRow(
        column(3, plotOutput("boxplotInvestmentID")),
        column(3, plotOutput("boxplotGDPID")),
        column(6, plotOutput("scatterPlotID"))
    ),
    fluidRow(
        column(4, plotOutput("largestInvestmentID")),
        column(4, plotOutput("largestGDPID")),
        column(4, plotOutput("largestProportionID"))
    )
)

# Define server logic
server = function(input, output) {
    output$textInvestmentID = renderText({"Investment Descriptive Stats"})
    output$tableInvestmentID = renderTable({as.array(summary(data$INVESTMENT))})
    output$textGDPID = renderText({"GDP Descriptive Stats"})
    output$tableGDPID = renderTable({as.array(summary(data$GDP))})
    
    output$histInvestmentID = renderPlot({
        hist(data$INVESTMENT, main = "Investment Values", col = brewer.pal(n = 3, name = "Paired"), xlab = "Investment")
    })
    
    output$histGDPID = renderPlot({
        hist(data$GDP, main = "GDP Values", col = brewer.pal(n = 3, name = "Pastel1"), xlab = "GDP")
    })
    
    output$boxplotInvestmentID = renderPlot({
        boxplot(data$INVESTMENT, main = "Investment Values", col = brewer.pal(n = 3, name = "Paired"), outline = F, horizontal = T)
    })
    
    output$boxplotGDPID = renderPlot({
        boxplot(data$GDP, main = "GDP Values", col = brewer.pal(n = 3, name = "Pastel1"), outline = F, horizontal = T)
    })
    
    output$scatterPlotID = renderPlot({
        plot(data$INVESTMENT, data$GDP, main = "Investment vs. GDP", xlab = "Investment", ylab = "GDP", pch = 19, col = "blue")
    })
    
    topInvestments = head(data[order(-data$INVESTMENT),], 10)
    output$largestInvestmentID = renderPlot({
        barplot(topInvestments$INVESTMENT, col = brewer.pal(n = 10, name = "RdBu"), las = 2, main = "Largest Investments", xlab = "Investments")
        legend("topright", legend = topInvestments$CITY, col = brewer.pal(n = 10, name = "RdBu"), cex = 0.8, ncol = 2, lwd = 4)
        box()
    })
    
    topGDPs = head(data[order(-data$GDP), ], 10)
    output$largestGDPID = renderPlot({
        pie(topGDPs$GDP, col = brewer.pal(n = 10, name = "Spectral"), labels = topGDPs$CITY, main = "Largest GDPs", xlab = "GDPs")
    })
    
    data$PROPORTION = data$INVESTMENT / data$GDP
    topProportions = head(data[order(-data$PROPORTION), ], 10)
    output$largestProportionID = renderPlot({
        barplot(topProportions$PROPORTION, col = brewer.pal(n = 10, name = "Set3"), las = 2, main = "Largest Investments/GDP Ratio", xlab = "Proportion")
        legend("topright", legend = topProportions$CITY, col = brewer.pal(n = 10, name = "Set3"), cex = 0.8, ncol = 2, lwd = 4)
        box()
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
