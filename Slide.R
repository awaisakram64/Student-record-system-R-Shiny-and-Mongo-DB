slide <- dashboardSidebar(

  uiOutput("a"),
  sidebarMenu(id = "sidebarid",
    menuItem(text = "Dashboard", tabName = "one", icon = icon("dashboard")),
    menuItem("Student",tabName = "two", icon = icon("graduation-cap")),
    menuItem("Insights",tabName = "thr", icon = icon("bar-chart-o")),
    menuItem("Exit",tabName = "four", icon = icon("share-square"))
  ))