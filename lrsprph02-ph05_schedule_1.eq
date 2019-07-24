
/*  lrsprph04.eq

    scips.com

    October 18, 2001

    claim count of reported claim for a given year - closed w/

    sorted by A/S LOB, reported year/loss_date 
*/
                                                                    
description Claims Closed With Payment Claims Closed without payment and Claims Still Open - Count ;

define string l_status = if claimcollection:loss_paid <> 0 and 
                            claimcollection:status_date <= claimcollection:l_ending_date and 
                            claimcollection:status_2 one of 1,2 then
                           "Closed With Payment" 
                         else
                           if claimcollection:loss_paid = 0 and 
                              claimcollection:status_date <= claimcollection:l_ending_date and 
                              claimcollection:status_2 one of 1,2 then
                             "Closed Without Payment"
                           else
                             if claimcollection:status_date <= claimcollection:l_ending_date and 
                                claimcollection:status_2 one of 0 then
                               "Still Open"
                             else
                               "CLOSED IN 2009 BUT STILL OPEN AT YEAR END"  
                             
                                                                         

sum
/nobanner
/domain="claimcollection"
/title="Homeowners Claims Closed With Payment Closed without payment and Still Open- Count"

units/heading="Claim-Count" 

across l_status   /heading="Closed Status"

by claimcollection:line_type /newlines 
   year(claimcollection:reported_date)/heading="Reported-Year"
   year(claimcollection:loss_date)/heading="Loss Date-Year"
   year(claimcollection:status_date)/heading="Date Closed"
