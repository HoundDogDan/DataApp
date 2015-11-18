library(shiny)
library(randomForest)

# The RandomForest model built from the Kaggle Titanic tutorial, the final model was built as follows:
#  fit <- randomForest(as.factor(Survived) ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked  
#           data=train, importance=TRUE, ntree=2000)
#
#https://github.com/trevorstephens/titanic/blob/master/Tutorial5.R
#

#Run once to load the saved model 
modrf <- readRDS("data/modrf_titanic5.rds")

fixSex <- function(s){ if(s==1) "male" else "female"};

createTest <- function(a,f,s,c) {       #age, fare, sex, class
  #factor levels 
  sLevels <- c("female","male")  #Sex 
  eLevels <- c("C","Q","S")      #Embarked
  
  PassengerId <- as.integer(  3000 )
  Pclass <- as.integer( c )         #1st class passanger
  Name <- as.character("passenger X")
  Sex <- s
  Age <- as.numeric(a)
  SibSp <- as.integer( 0)  
  Parch <- as.integer( 0 )  
  Ticket <- as.character("113000")
  Fare  <- as.numeric(f )          #numeric
  Embarked <- as.character("S")
  
  
  test <- data.frame(PassengerId, Pclass, Sex, Age, SibSp, Parch, Fare, Embarked, stringsAsFactors=FALSE )
  
  #fix for factors
  test$Sex <-  factor(test$Sex, levels=sLevels)
  test$Embarked <- factor(test$Embarked, levels=eLevels)
  
  return(test);
};


SurvivalRisk <- function(a,f,s,c){         #age, fare, sex, class

    totest <- createTest(a,f,fixSex(s),c);

    survived <- predict(modrf, totest)
    
    return( if(survived == 0) "Survived" else "Notify the next of kin" )
  
  
};


#The async
shinyServer(
  function(input, output) {
    output$text3 <- renderPrint( { fixSex(input$radioSex) } )
    output$text4 <- renderPrint( { input$radioClass } )
    output$text2 <- renderPrint( { input$sliderFare} )
    output$text1 <- renderPrint( { input$sliderAge } )
    
    
    output$pred  <- renderPrint( { SurvivalRisk(input$sliderAge, input$sliderFare, input$radioSex, input$radioClass) })
    
  
  }
)