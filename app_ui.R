library(shiny)
library(ggplot2)

mental_health <- read.csv("https://raw.githubusercontent.com/info201a-w21/project-victoriathegr8/main/data/mental_health_in_tech/survey.csv?token=ASLIDHBRHUKBMN2U5RGAKW3AJF3YK")

intro_page <- tabPanel(
  titlePanel("Introduction"),
  includeCSS("styles.css"),
  tags$h1("Introduction"),
  sidebarLayout(
    mainPanel(
      tags$p("The domain we are aiming to explore with this project is
        the intersection between mental health and the tech industry.
        Mental health awareness and advocacy has only risen over the
        past few years, making this a relevant topic. Constraining
        our demographic to the tech industry allowed us to obtain more
        specific data, plus it felt more relevant in an informatics
        course. However, this project could also give us insight into
        a broader domain-how our professional lives impact our personal
        ones. The data set we will be analyzing is a 2014 survey done by
        Open Sourcing Mental Illness, a nonprofit aimed at educating and
        providing resources to support mental health, about mental
        health in the tech workplace. We found this data set to have a
        large enough reach and enough respondents to be able to draw
        conclusions from it."),
      br(),
      tags$img(src = "working.jpg"),
      tags$strong("For more information about Seattle mental health resources,
                  click"),
      tags$a(
        href = "https://www.namiwa.org/index.php/resources",
        "here."
      )
    ),
    sidebarPanel(
      tags$h2("By utilizing this data set, we hope to find answers to the
        following questions:"),
      tags$ul(
        tags$li("How does company size within the tech industry affect
                mental health resource access and usage?"),
        tags$li("Are there any correlations between age and mental health
                statistics?"),
        tags$li("How does the workplace culture around mental health in
                the tech industry differ from other industries?")
      ),
    ),
  )
)

props_page <- tabPanel(
  titlePanel("Statistics based on Company Size"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "prop",
        choices = c(
          "Have Family History of Mental Illness",
          "Have Received Mental Illness Treatment",
          "Receive Mental Health Benefits from Work",
          "Are Comfortable Discussing\nMental Health with Coworkers",
          "Are Comfortable Discussing\nMental Health with
                    Supervisor"
        ),
        label = "Proportion of Respondents That:"
      )
    ),
    mainPanel(
      plotlyOutput(outputId = "props_plot"),
    )
  )
)

age_page <- tabPanel(
  titlePanel("Comparing Age and Responses to Mental Health"),
  sidebarLayout(
    sidebarPanel(
      x_var <- selectInput(
        inputId = "x_var",
        label = "Choose an X Variable",
        choices = c(
          "Mental Health Intereference with Work" = "work_interfere",
          "Number of Employees" = "no_employees",
          "Difficulty Taking Medical Leave" = "leave"
        )
      )
    ),
    mainPanel(
      plotlyOutput(outputId = "plot")
    )
  )
)

comp_page <- tabPanel(
  titlePanel("Comparing Type of Company and Responses to Mental Health"),
  sidebarLayout(
    sidebarPanel(
      x_var <- selectInput(
        inputId = "axis",
        label = "Choose a Proportion",
        choices = c(
          "Easy Taking Medical Leave" = "leave_provided_prop",
          "Provided Mental Health Benefits" = "benefits_provided_prop",
          "Comfortable Discussing Mental Health With Coworkers"
          = "comfortable_prop",
          "Mental Health Effects Work" = "effects_work_prop"
        )
      )
    ),
    mainPanel(
      plotlyOutput(outputId = "comp_plot")
    )
  )
)
conclusion_page <- tabPanel(
  titlePanel("Conclusion"),
  p("test"),
)
ui <- navbarPage(
  "Mental Health in the Tech Industry",
  intro_page,
  props_page,
  age_page,
  comp_page,
  conclusion_page
)
