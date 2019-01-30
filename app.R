#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)
source('Header.R')
source('Body.R')
source('Slide.R')
source('Modules.R')
library(mongolite)
library(shinyjs)
library(shinyalert)


add_fields <- c("std_roll","std_name","std_fname","std_email","std_ph")
upd_fields <- c("upd_std_roll","upd_std_name","upd_std_fname","upd_std_email","upd_std_ph")



    
loadData <- function(){
    data <- db$find()
    if (db$count()>0) {
        colnames(data) <- c( "Roll No", "Student Name","Father Name", "Email", "Phone")
    }
    data
}

# update fields after update and delete of record
update_first_fields <- function(session){
    updateSelectInput(session,"upd_std_roll",choices = loadData()[['Roll No']])
    updateSelectInput(session,"del_std_roll",choices = loadData()[['Roll No']])
    val <- as.numeric(max(loadData()[['Roll No']]))+1
    updateNumericInput(session,"std_roll",value = val)
}

update_all_fields_excpt_first <- function(session){
    
}



ui <- shinyUI(
    dashboardPage(skin = "purple", header, slide ,body)
)


# Define server logic required to draw a histogram
server <- function(input, output,session) {
    
    output$verb <- renderPlot({
        dat <- read.csv('student-mat.csv', sep=';')
        plot(dat$sex,dat$age)
    })
    
    
    connectdb()
    
    formData <- reactive({
        data <- sapply(add_fields, function(x) input[[x]])
        data
        print(data)
    })
    
    
    Upd_formData <- reactive({
        upd_data <- sapply(upd_fields, function(x) input[[x]])
        colnames(upd_data) <- c("std_roll","std_name","std_fname","std_email","std_ph")
        upd_data
    })
    
    observeEvent(input$clk_add, {
        for (variable in formData()) {
            if (variable=="") {
                shinyalert("Oops!", "Missing fields", type = "error")
            }
            req(variable)
        }
        saveData(formData())
        
        shinyalert("Done", "Successfully added record", type = "success")
        ## Method in File Modules.R
        clearFields(session)
        update_first_fields(session)
        
    })
    
    output$std_rec_view <- renderDataTable({
        input$clk_add
        loadData()
    })
    
    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2] 
        bins <- seq(min(x), max(x), length.out = input$bins + 1)
        
        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white')
    })
    
    observeEvent(input$sidebarid,{
        update_first_fields(session)
        disable("std_roll")
    })
    
    observeEvent(input$upd_std_roll,{
        # dataa <- loadData()
        # colnames(dataa) <- c("std_name","std_fname","std_roll","std_email","std_ph")
        if (!is.null(loadData())) {
            x <- loadData()[loadData()[['Roll No']]   %in% input$upd_std_roll,]
            #print(x)
            updateTextInput(session,"upd_std_fname",value = x[['Father Name']])
            updateTextInput(session,"upd_std_name",value = x[['Student Name']])
            updateTextInput(session,"upd_std_email",value = x[['Email']])
            updateTextInput(session,"upd_std_ph",value = x[['Phone']])
        }
    })
    
    observeEvent(input$del_std_roll,{
        if (!is.null(loadData())) {
            x <- loadData()[loadData()[['Roll No']]   %in% input$del_std_roll,]
            #print(x)
            updateTextInput(session,"del_std_fname",value = x[['Father Name']])
            updateTextInput(session,"del_std_name",value = x[['Student Name']])
            updateTextInput(session,"del_std_email",value = x[['Email']])
            updateTextInput(session,"del_std_ph",value = x[['Phone']])
        }
    })
    
    observeEvent(input$clk_del,{
        db$remove(sprintf('{"std_roll":"%s"}',input$del_std_roll))
        shinyalert("Done!", "successfully deleted record", type = "success")
        update_first_fields(session)
        output$std_rec_view <- renderDataTable({
            input$clk_add
            loadData()
        })
    })
    
    observeEvent(input$clk_upd,{
        # dat <- data.frame(c(input$upd_std_roll,input$upd_std_name,input$upd_std_fname,input$upd_std_email,input$upd_std_ph), row.names = add_fields)
        # colnames(dat) <- NULL
        # print(t(dat))
        # x <- as.data.frame(t(dat))
        db$update(query = sprintf('{"std_roll":"%s"}',input$upd_std_roll),
                update = sprintf('{"$set": {"std_name" : "%s"},
                                   "$set": {"std_fname" : "%s"},
                                   "$set": {"std_email" : "%s"},
                                   "$set": {"std_ph" : "%s"}}',input$upd_std_name,input$upd_std_fname,input$upd_std_email,input$upd_std_ph))
        shinyalert("Done!", "successfully Update record", type = "success")
        output$std_rec_view <- renderDataTable({
            input$clk_add
            loadData()
        })
        
    })
    
}

# Run the application 
shinyApp(ui = ui, server = server)

