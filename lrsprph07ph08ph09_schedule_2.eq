
/*  lrsprph007ph08ph09.eq

    scips.com

    april 23, 2009

    Number of claims settled less then 90 days.

*/
                                                                    
description Claims Closed With Payment within the following bands  0-30,31-60,61-90 days ;

define unsigned ascii number l_days_to_settle  = ((claimcollection:status_date - claimcollection:reported_date) div 30)

where claimcollection:loss_paid <> 0 and 
      claimcollection:status_date <= claimcollection:l_ending_date and 
      claimcollection:status_2 one of 1,2 AND 
     (claimcollection:status_date - claimcollection:reported_date) <= 90 
                                                                                                                                   
sum
/nobanner
/domain="claimcollection"
/title="Homeowners Claims Closed With Payment Closed without payment and Still Open- Count"

units/heading="Claim-Count" 

across switch(l_days_to_settle)
         case 0 : "0-30 days"
         case 1 : "31-60 days"
         CASE 2 : "61-90 days"

by claimcollection:line_type/newlines 
   year(claimcollection:reported_date)/heading="Reported-Year"
   year(claimcollection:loss_date)/heading="Loss Date-Year"
   year(claimcollection:status_date)/heading="Date Closed"
