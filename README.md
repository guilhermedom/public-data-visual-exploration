# Public Data Visual Exploration

Using R's Shiny web app capabilities to showcase a visual exploration of Gross Domestic Products (GDPs) and public expenditures from Brazilian cities.

---

## Usage

Install the Shiny R package on your machine by running the following command on your R console:

```
install.packages("shiny")
```

Once finished installing, clone or download this repository and open the "app.R" file with Rstudio. Rstudio will automatically detect that it is a Shiny app file and a "Run App" button will appear on the top of the editor screen. Click the button to run the app.

Alternatively, with the repository cloned, open your R console and set the working directory to the absolute path where the repository was cloned:

```
setwd(path_to_cloned_repository)
```

Then, load the Shiny library and run the file "app.R":

```
library(shiny)
runApp("app/app.R")
```

The app will start on a new browser tab in your default browser.

## App Features

Cities committed costs are public expenditures budgeted for future payments of services or goods. In this app, GDPs and committed costs of Brazilian cities from Rio Grande do Sul state are compared using different plots. The objective is to show the level of financial responsibility of public money administrators. The following features are available in this app's user interface:

* Two tables having overall descriptive statistics of GDPs and committed costs, including the minimum, median, mean, max and quartiles of both values across all evaluated cities;
* Barplots showing how many cities have a given committed cost and GDP range;
* Boxplots visually reporting the committed cost and GDP of all cities;
* A scatter plot of committed cost againts GDP; one point per city;
* A barplot and a pie plot presenting, respectively, the top 10 largest committed costs and GDPs, with city names annotated;
* For last, a barplot with the top 10 committed cost per GDP ratios, showing which cities expend the most money related to how much they produce.

## User Interface Sample

![ui_public-data-visual-exploration](https://user-images.githubusercontent.com/33037020/185015146-396a0478-6301-4716-985a-9759e7c21e15.png)

*[Shiny] is a framework that allows users to develop web apps using R and embedded web languages, such as CSS and HTML. Shiny apps focus on objectiveness and simplicity: only one or two R scripts have all the code for the app.*

*This app development started with knowledge and tools discussed during the course "Data Science Bootcamp" by Fernando Amaral. The app has been upgraded and personalized, adding new functionalities.*

[//]: #

[Shiny]: <https://www.shinyapps.io>
