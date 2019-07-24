
/*  lrsprph04.eq

    scips.com

    October 18, 2001

    claim count of reported claim for a given year - closed w/

    sorted by A/S LOB, reported year/loss_date 
*/
                                                                    
description Claims Closed With Payment Count ;

define unsigned ascii number l_days_to_settle  = claimcollection:status_date - claimcollection:reported_date
define unsigned ascii number l_days_to_report  = claimcollection:reported_date - claimcollection:loss_date

where claimcollection:loss_paid <> 0 and 
      claimcollection:status_date <= claimcollection:l_ending_date and 
      claimcollection:status_2 one of 1,2 
                                                                                                                                   
list
/nobanner
/domain="claimcollection"
/title="Homeowners Claims Closed With Payment Closed"

claimcollection:line_type 
claimcollection:line_of_business 
Claimcollection:claim_no
claimcollection:loss_date  
claimcollection:reported_date
claimcollection:status_date
l_days_to_settle/heading="days to settle"
l_days_to_report/heading="days to report"

sorted by claimcollection:line_type /newlines
          l_days_to_settle
          line_of_business  
--   year(claimcollection:reported_date)/heading="Reported-Year"
--   year(claimcollection:loss_date)/heading="Loss Date-Year"
--   year(claimcollection:status_date)/heading="Date Closed"
