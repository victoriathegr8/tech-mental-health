library(shiny)
library(ggplot2)

intro_page <- tabPanel(
  titlePanel("Introduction"),
  p("The domain we are aiming to explore with this project is
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
  p("By utilizing this data set, we hope to find answers to the
    following questions:"),
  tags$ul(
    tags$li("What kind of workplace culture around mental health does
            the tech industry offer?"),
    tags$li("How does company size within the tech industry affect
            mental health resource access and usage?"),
    tags$li("How does age impact one's mental health knowledge? Is there
            any difference in mental health stigma between age groups?"),
  ),
  tags$img(src = "working.jpg")
)

props_page <- tabPanel(
  titlePanel("Statistics based on Company Size"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "prop",
        choices = c("Have Family History of Mental Illness",
                    "Have Received Mental Illness Treatment",
                    "Receive Mental Health Benefits from Work",
                    "Are Comfortable Discussing\nMental Health with Coworkers",
                    "Are Comfortable Discussing\nMental Health with Supervisor"),
        label = "Proportion of Respondents That:"
      )
    ),
    mainPanel(
      plotlyOutput(outputId = "props_plot"),
    )
  )
)

mental_health <- read.csv("https://raw.githubusercontent.com/info201a-w21/project-victoriathegr8/main/data/mental_health_in_tech/survey.csv?token=ASLIDHBRHUKBMN2U5RGAKW3AJF3YK")

avg_age_page <- tabPanel(
  titlePanel("Comparing Age and Responses to Mental Health"),
  sidebarLayout(
    sidebarPanel(
      x_var <- selectInput(
      inputId = "x_var",
      label = "Choose an X Variable",
      choices = c("Mental Health Intereference with Work" = "work_interfere",
                  "Number of Employees" = "no_employees",
                  "Difficulty Taking Medical Leave" = "leave")
      )
  ),
    mainPanel(
      plotOutput(outputId = "plot")
    )
  )
)
ui <- navbarPage(
  "Mental Health in the Tech Industry",
  intro_page,
  props_page,
  avg_age_page
)
