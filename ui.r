library(shinythemes)
library(shinydashboard)

#https://rstudio.github.io/shinydashboard/structure.html#message-menus


header <- dashboardHeader(title = "Pavadinimas",
                          dropdownMenuOutput('messageMenu'),
                          dropdownMenu(type = "notifications",
                                       notificationItem(
                                         text = "5 new users today",
                                         icon("users")
                                       ),
                                       notificationItem(
                                         text = "12 items delivered",
                                         icon("truck"),
                                         status = "success"
                                       ),
                                       notificationItem(
                                         text = "Server load at 86%",
                                         icon = icon("exclamation-triangle"),
                                         status = "warning"
                                       )
                          ),
                          dropdownMenu(type = "tasks", badgeStatus = "success",
                                       taskItem(value = 15, color = "green",
                                                "Documentation"
                                       ),
                                       taskItem(value = 17, color = "aqua",
                                                "Project X"
                                       ),
                                       taskItem(value = 75, color = "yellow",
                                                "Server deployment"
                                       ),
                                       taskItem(value = 10, color = "red",
                                                "Overall project"
                                       )
                          )
                          )

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
    menuItem("Widgets", 
             menuSubItem('Index1', tabName = 'widgets1'),
             menuSubItem('Index2', tabName = 'widgets2'),
             menuSubItem('Index3', tabName = 'widgets3'),
             tabName = "widgets", icon = icon("th"))

  )
)

body <- dashboardBody(
    tags$head(
      shiny::includeCSS(path = "www/custom.css")
    ),
  tabItems(
    #Pirmas
    tabItem(tabName = 'dashboard',
            fluidPage(theme = 'custom.css',
                      tags$head(includeScript("googleanalytics.js")),
                      navbarPage("2D Outlier Analysis",tabPanel("App",
                                                                sidebarPanel(
                                                                  selectInput('Model',label="Model",choices=list("Hierarchical Clustering"=12,
                                                                                                                 "Mahalanobis Distance"=2,
                                                                                                                 "EM - can be slow to converge"=17,
                                                                                                                 "Kmeans Euclidean Distance" =1,
                                                                                                                 "Kmeans Means Distance"=3,
                                                                                                                 #"Kmeans Minkowski"=4,
                                                                                                                 "Fuzzy kmeans"=9,"Fuzzy kmeans - Gustafson and Kessel"=10,"Fuzzy k-medoids"=13,"Fuzzy k-means with polynomial fuzzifier"=11,
                                                                                                                 "Local Outlier Factor"=5,
                                                                                                                 # "SVM"=16,
                                                                                                                 "RandomForest"=6,"Isolation Forest"=7,
                                                                                                                 "FBOD"=14,"SOD"=15,
                                                                                                                 "Autoencoder"=8
                                                                  ),selected = 1),
                                                                  selectInput('sample',label="Sample",choices=list("Random" =1,
                                                                                                                   "Corners"=2,"Doughnut"=3,"Smiley"=4,"Spiral"=5,"Eyes"=6,"Butterfly"=7,"Axis-Parallel Subspace"=8,"StarsCYG"=9),selected = 1),
                                                                  numericInput('clusters', 'Cluster count/Neighbors', 3,
                                                                               min = 1, max = 9),
                                                                  sliderInput("outlierper", "Outlier %:",
                                                                              min = 85, max = 99, value = 90, step= 1),
                                                                  actionButton("button", "Update Sample Data"),
                                                                  p(),
                                                                  actionButton("scalebutton", "Scale Data")
                                                                ),
                                                                mainPanel(
                                                                  plotOutput('plot1',click = "plot_click",
                                                                             brush = brushOpts(id = "plot1_brush")),
                                                                  DT::dataTableOutput("mytable1")
                                                                )),
                                 tabPanel("About" ,
                                          fluidRow(
                                            column(10,includeMarkdown("docs/introduction.md"))
                                          )),
                                 tabPanel("Tutorial" ,
                                          fluidRow(
                                            column(10,includeMarkdown("docs/tutorial.md"))
                                          ))
                                 
                      ) )
    ),
    tabItem(tabName = "widgets",
            h2("Widgets tab content")
    ),
    tabItem(tabName = 'widgets1',
            h2("Widgets tab content"),
            p('Submenu 1')
            ),
    tabItem(tabName = 'widgets2',
            h2("Widgets tab content"),
            p('Submenu 2')
    ),
    tabItem(tabName = 'widgets3',
            h2("Widgets tab content"),
            p('Submenu 3')
    )
    
  )
  # Boxes need to be put in a row (or column)
  
  )



dashboardPage(header = header, sidebar = sidebar, body = body)

  








