header <- dashboardHeader(title = tagList(
  tags$span(
    class = "logo-mini", "App"
  ),
  tags$span(
    class = "logo-lg", "Student"
  )
),
                          dropdownMenu(type = "messages", badgeStatus = "success",
                                       messageItem("Support",
                                                   "This is the content of a message.",
                                                   time = "5 mins"
                                       ),
                                       messageItem("Support Team",
                                                   "This is the content of another message.",
                                                   time = "2 hours"
                                       ),
                                       messageItem("New User",
                                                   "Can I get some help?",
                                                   time = "Today"
                                       )
                          ),

                          # Dropdown menu for notifications
                          dropdownMenu(type = "notifications", badgeStatus = "warning",
                                       notificationItem(icon = icon("users"), status = "info",
                                                        "5 new members joined today"
                                       ),
                                       notificationItem(icon = icon("warning"), status = "danger",
                                                        "Resource usage near limit."
                                       ),
                                       notificationItem(icon = icon("shopping-cart", lib = "glyphicon"),
                                                        status = "success", "25 sales made"
                                       ),
                                       notificationItem(icon = icon("user", lib = "glyphicon"),
                                                        status = "danger", "You changed your username"
                                       )
                          )
)
# header <- dashboardHeader(title = "This is Header",
#                       dropdownMenuOutput("msgOut"))