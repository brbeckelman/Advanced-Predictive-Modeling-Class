library(shiny)
library(datasets)

# Define User Interface
ui = shinyUI(fluidPage(
  
  # Give the page a title
  titlePanel("World Telephones by Region/Year"),
  
  # Generate sidebar
  sidebarLayout(      
    
    # Define sidebar
    sidebarPanel(
      
      # Define checkboxes
      checkboxGroupInput(inputId="check", label="Filter", c('Region', 'Year'), selected='Region'),
      
      # Define dropdowns
      selectInput(inputId="region", label="Region:", 
                  choices=colnames(WorldPhones)),
      selectInput(inputId="year", label="Year:",
                  choices=rownames(WorldPhones)),
      
      hr(),
      helpText("Data from AT&T (1961) The World's Telephones.")
    ),
    
    # Create a spot for the barplot
    mainPanel(
      plotOutput("phonePlot")  
    )
  )
))

# Define Server
server = shinyServer(function(input, output){
  
  # Fill in the spot we created for a plot
  output$phonePlot <- renderPlot({
    
    # Define plot parameters
    if (input$check == 'Region'){
      data = WorldPhones[,input$region]
      xlabel = 'Year'
      title = input$region}
    
    else if(input$check == 'Year'){
      data = WorldPhones[input$year,]
      xlabel = 'Region'
      title = input$year}
    
    else {
      data = WorldPhones[,input$region]
      xlabel = 'Year'
      title = input$region}
    
    # Render a barplot
    barplot(data, 
            main=title,
            ylab="Number of Telephones",
            xlab=xlabel,
            col='blue')
  })
})

# Run shiny app
shinyApp(ui=ui, server=server)