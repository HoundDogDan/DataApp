library(shiny)

shinyUI(
  fluidPage(
    
    # Application title
    titlePanel("Titanic Prediction - Would you have survived?"),
    
    sidebarPanel(
      radioButtons("radioSex",   label = h4("Sex"), choices = list("Male" = 1, "Female" = 2), selected = 1),
      radioButtons("radioClass", label = h4("Passenger Class"), choices = list("1st" = 1, "2nd" = 2, "3rd" = 3), selected = 3),
      sliderInput("sliderFare",  label = h4("Fare in USD"), min = 0, max = 512, value = 35),
      sliderInput('sliderAge',   label = h4("Age in years"), 24, min = 0.1, max = 80.0 ),
      
      helpText("Would you survive the Titanic? Pick the informaion that makes sense to you then hit submit to see if you would have survived.",
               " Try Male, 2nd Class, $430 and 6 years of age.",
               " Try Female, 3rd Class $73 and 54 years of age"),
     
      submitButton('Submit')
    ),
    mainPanel(
      h3('Results for your prediction:'),
      h4('You entered'),
      textOutput("text1"),
      textOutput("text2"),
      textOutput("text3"),
      textOutput("text4"),
       h4('Which resulted in your prediction of ...'),
      textOutput("pred")
     
    )
  )
)