library(shiny)
options("shiny.reactlog" = TRUE)

shinyApp(
  fluidPage(
    actionButton("button", "Click me!"),
    plotOutput("badpattern"),
    plotOutput("goodpattern"),
  ),
  function(input, output) {

    ### BAD
    observeEvent(input$button, {
      output$badpattern <- renderPlot({
        hist(runif(input$button))
      })
    })

    ### Good
    click_count <- eventReactive(input$button, {
      # requires a non-zero (Truthy) value
      # Prevents the image from appearing until button is clicked
      req(input$button)
      input$button
    })
    output$goodpattern <- renderPlot({
      hist(runif(click_count()))
    })

})
