library(shiny)
library(ggplot2)
library(shinythemes)

mental_health <- read.csv("data/mental_health_in_tech/survey.csv")

intro_page <- tabPanel(
  titlePanel(h2("Introduction")),
  includeCSS("styles.css"),
  tags$h1("About the Topic"),
  br(),
  sidebarLayout(
    mainPanel(
      tags$img(src = "mind.jfif"),
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
      br(),
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
  titlePanel(h2("Company Size Effects")),
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput(
        inputId = "prop",
        choices = c(
          "Have Family History of Mental Illness",
          "Have Received Mental Illness Treatment",
          "Receive Mental Health Benefits from Work",
          "Are Comfortable Discussing\nMental Health with Coworkers",
          "Are Comfortable Discussing\nMental Health with Supervisor"),
        label = p("Proportion of Respondents That:"),
        selected = c("Receive Mental Health Benefits from Work",
                    "Are Comfortable Discussing\nMental Health with Coworkers") 
      )
    ),
    mainPanel(
      plotlyOutput(outputId = "props_plot"),
    )
  )
)

age_page <- tabPanel(
  titlePanel(h2("Age Effects")),
  sidebarLayout(
    sidebarPanel(
      x_var <- selectInput(
        inputId = "x_var",
        label = p("Choose a Variable"),
        choices = c(
          "Mental Health Intereference with Work" = "work_interfere",
          "Number of Employees" = "no_employees",
          "Difficulty Taking Medical Leave" = "leave"
        )
      ),
      sliderInput(
        inputId = "age_range",
        label = p("Age Range"),
        min = 14, max = 118, value = c(14, 118)
      )
    ),
    mainPanel(
      plotlyOutput(outputId = "plot")
    )
  )
)

comp_page <- tabPanel(
  titlePanel(h2("Company Type Effects")),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "axis",
        label = p("Choose a Proportion"),
        choices = c(
          "Easily Able to Take Medical Leave\nDue to Mental Health",
          "Provided Mental Health Benefits",
          "Comfortable Discussing Mental Health With Coworkers",
          "Effected at Work by Mental Health"
        )
      )
    ),
    mainPanel(
      plotlyOutput(outputId = "comp_plot")
    )
  )
)
conclusion_page <- tabPanel(
  titlePanel(h2("Conclusion")),
  tags$h1("Findings"),
  br(),
  tags$div (class = "content", tags$img(src = "team.png"), 
  p("After evaluating the impact of the size of a tech company that one 
    works for on mental health, we can see a few trends. A trend that was 
    expected was a positive relationship between company size and 
    the probability that the company would offer mental health benefits. 
    However, this directly contrasts with many of the other trends 
    demonstrated in regards to company size. Respondents working at 
    larger companies were less comfortable discussing mental health with 
    both their coworkers and supervisors. This was shown in the 19.2% 
    difference in the proportion of respondents working at 1000+ 
    employee companies that were comfortable discussing their mental 
    with their coworkers and those working at 1-5 employee companies. 
    They were also less likely to have received mental health treatment 
    before. This shows that despite companies offering mental health 
    benefits, and thus acknowledging that mental health struggles are 
    normal and worthy of being treated, workplace culture doesn't 
    necessarily follow suit with that acknowledgement.")),
  br(),
  tags$div (class = "content", tags$img(src = "age.png"), 
  p("In examining the relationships between age and the mental health
  of those who work in the tech industry, we were able to determine
  that younger individuals are more likely to be distracted from work
  because of their mental wellbeing. While many people expressed that
  it was fairly easy to take medical leave for their mental health, for
  those who responded yes, most were below the age of 40. After 
  comparing age to company size, we found that most employees in tech
  are around the age of 30, regardless of the size of the company.
  Consequently, there is a higher risk for younger people who are fairly
  new in the tech workplace to suffer from mental health conditions.")),
  br(),
  br(),
  tags$div (class = "content", tags$img(src = "tech.png"), 
  p("From analysis of responses comparing those in the tech industry with
  those in other fields, it is clear that those working for tech
  companies find taking leave easier, most likely due to company
  resources allowing for flexibility. Those working in tech also found
  conversations about mental health much more approachable with coworkers.
  It is interesting to note that more respondents employed at non-tech
  companies knew of mental health benefits provided by their employers,
  and also showed a slightly lower proportion of people finding that
  mental health regularly interfered with their work. This indicates
  that competitiveness of the tech environment may prove detrimental to
  the health of its contributors, despite the success of the company.")),
  br(),
  tags$div (class = "content", tags$img(src = "data.png"),
  p("After comparing each of the graphs' insights, it is hard to decipher
  an obvious conclusion about the tech industry's culture around mental
  health. While some of our statistics point to the idea that those in
  the tech industry have less mental health resources than in other
  industries, many individuals responded that they felt the workplace
  moderated discussion about their wellbeing. Sadly, through the mere
  analyzation of data, many individual experiences are omitted which
  are often significantly more powerful than numbers themselves. In
  order to dig deeper into the culture around mental health within the
  tech industry, we must open the conversation with those who work for
  tech companies and understand their experiences on a personal level.")),
)
ui <- navbarPage(theme = shinytheme("superhero"),
  h2("Mental Health in the Tech Industry"),
  intro_page,
  props_page,
  age_page,
  comp_page,
  conclusion_page
)
