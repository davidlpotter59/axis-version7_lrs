
/*  lrsprph12.eq

    scips.com

    april 23, 2009

    Number of claims settled greater then 90 days and less then a year the range of the group is 180 days.

*/
                                                                    
description Claims Closed With Payment Count within the following bands 365+ days;

define unsigned ascii number l_days_to_settle  = ((claimcollection:status_date - claimcollection:reported_date) div 366)

where claimcollection:loss_paid <> 0 and 
      claimcollection:status_date <= claimcollection:l_ending_date and 
      claimcollection:status_2 one of 1,2 AND 
     (claimcollection:status_date - claimcollection:reported_date) > 365 
                                                                                                                                   
sum
/nobanner
/domain="claimcollection"
/title="Homeowners Claims Closed With Payment settled beyond 365 days"

units/heading="Claim-Count" 

across switch(l_days_to_settle)
         case 0 : "91-180 days"
         case 1 : "180-365 days"         

by claimcollection:line_type/newlines 
   year(claimcollection:reported_date)/heading="Reported-Year"
   year(claimcollection:loss_date)/heading="Loss Date-Year"
   year(claimcollection:status_date)/heading="Date Closed"
