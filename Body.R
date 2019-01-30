body <- dashboardBody(
  
  tabItems(
    
    ###---------------ONE
    
    tabItem(tabName = "one",
            h1("Dash"),
            fluidPage(
              useShinyjs(),
              
              useShinyalert(),
              
              valueBox(value = 1000,subtitle = "count",icon = icon("th"),color = "aqua",width = 4 ),
              # Application title
              titlePanel("Student Record System"),
              
              # Sidebar with a slider input for number of bins 
                
                # Show a plot of the generated distribution
              mainPanel(
                img(src='student.png', align = "right")
                ### the rest of your code
              )
            )
            ),
    
    
    ####---------------TWO---
    
    tabItem(tabName = "two",
            mainPanel(width = "100%",
              tabsetPanel(id = "tabsetpanel",
                
                ###-------------TWO.View
                
                tabPanel(
                  title = "View Students",icon = icon("th"),
                  div(style='height:550px; overflow-y: scroll',
                      dataTableOutput(outputId = "std_rec_view"))
                ),
                
                ###-------------TWO.Add
                
                
                tabPanel(
                  title = "Add Student",icon = icon("plus"),
                  box(collapsible = T,solidHeader = T,
                      
                    numericInput(inputId = "std_roll",value = 0, label = "Student Roll No."),
                    
                    textInput(inputId = "std_name",label = "Student Name"),
                    
                    textInput(inputId = "std_fname",label = "Father Name"),
                    
                    textInput(inputId = "std_email",label = "Student Email"),
                    
                    textInput(inputId = "std_ph",label = "Student Phone"),
                    
                    actionButton(inputId = "clk_add",label = "Submit")
                  )
                ),
                
                ###-------------TWO.Update
                
                tabPanel(
                  title = "Update",icon = icon("edit"),
                  box(width = 6,  collapsible = T,solidHeader = T,footer = "let empty not req textBox",
                      
                      
                      selectInput(inputId = "upd_std_roll",label = "Student Roll No.",choices = c("") ),
                      
                      textInput(inputId = "upd_std_name",label = "Student Name"),
                      
                      textInput(inputId = "upd_std_fname",label = "Father Name"),
                      
                      textInput(inputId = "upd_std_email",label = "Student Email"),
                      
                      textInput(inputId = "upd_std_ph",label = "Student Phone"),
                      
                      actionButton(inputId = "clk_upd",label = "Update")
                  )
                  
                ),
                
                ###-------------------TWo.Delete
                
                tabPanel(
                  title = "Delete Student",icon = icon("user-times"),
                  box(collapsible = T,solidHeader = T,
                      
                      selectInput(inputId = "del_std_roll",choices = c(""), label = "Student Roll No."),
                      
                      textInput(inputId = "del_std_name",label = "Student Name"),
                      
                      textInput(inputId = "del_std_fname",label = "Father Name"),
                      
                      textInput(inputId = "del_std_email",label = "Student Email"),
                      
                      textInput(inputId = "del_std_ph",label = "Student Phone"),
                      
                      actionButton(inputId = "clk_del",label = "Delete")
                  )
                )
                
            ))
            ),
    tabItem(h2("Insights"),tabName = "thr",
            
            plotOutput(outputId = "verb")
            ),
    
    tabItem(h1("Bye"),tabName = "four")
    
    )
  )
