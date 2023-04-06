#' SYRI list of activities
SYRI_ACTIVITIES <- c(
  "koordinace projektových aktivit / coordination of project activities",
  "konzultace, porady, schůzky / consultations, meetings",
  "administrativní činnost / administrative activities",
  "zpracování průběžné (závěrečné) zprávy / reporting interim (final) report",
  "příprava podkladů pro průběžnou (závěrečnou) zprávu / document preparation for monitoring report",
  "finanční řízení projektu / financial management",
  "příprava podkladů pro finanční řízení projektu / document preparation for financial management",
  "koordinace odborných (vědeckých) aktivit projektu / coordination of research activities",

  "koordinace výzkumné skupiny / coordination of the research team",
  "příprava odborné akce (workshop, školení, konference) / planning of an event (workshop, training, conference)",
  "účast na odborné akci (workshop, školení, konference) / participation at the event (workshop, training, conference)",
  "účast v mentoringovém programu / participation at the mentoring programme",
  "studium literatury / study of literature",
  "zahraniční pracovní cesta / business trip abroad",
  "realizace výzkumných aktivit / research activities"
)

#' Check if total sum matches the hours
#'
#' @param df Data.frame to check
#' @param total_hours Total number of hours that should be allocated
check_total_sum <- function(df, total_hours){
  if(sum(df$hours) != total_hours){
    difference <- total_hours - sum(df$hours)
    df$hours[nrow(df)] <- df$hours[nrow(df)] + difference
    df
  }else{
    df
  }
}

#' Generate random timesheet of work hours spend on specified project activities
#'
#' @param activities Vector with activity names
#' @param n_hours Total number of hours spent on activities
#' @param specified_activities list with named integer containing
#' name of activity and hours spent doing the activity
#'
#' @export
get_timesheet <- function(activities, n_hours, specified_activities = NULL){

  if(!is.null(specified_activities)){
    specified_activities_df <- data.frame(
      activity = names(unlist(specified_activities)),
      hours = unname(unlist(specified_activities))
    )
    allocate_hours <- n_hours - sum(specified_activities_df$hours)
  }else{
    allocate_hours <- n_hours
  }

  timespent <- stats::rnorm(length(activities), mean = 100, sd = 30)
  timespent <- timespent / sum(timespent)
  hours <- timespent * allocate_hours

  out <- data.frame(
    activity = activities,
    hours = round(hours, 1)
  )

  if(!is.null(specified_activities)){
    out <- rbind(
      out, specified_activities_df
    )
  }

  check_total_sum(out, n_hours)
}
