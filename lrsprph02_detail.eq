
/*  lrsprph02_DETAIL.eq

    scips.com

    October 18, 2001

    claim count of reported claim for a given year - closed w/

    sorted by A/S LOB, reported year/loss_date 
*/
                                                                    
description Claims Closed With Payment and without payment and still open - Count ;

include "startend.inc"

define file sfscausea = access sfscause, set sfscause:company_id= lrssetup:company_id,
                                             sfscause:line_of_business= lrssetup:line_of_business,
                                             sfscause:lob_subline= lrssetup:lob_subline,
                                             sfscause:cause_of_loss= lrssetup:cause_of_loss,
                                             sfscause:cause_loss_subline= lrssetup:cause_loss_subline 

where (lrssetup:loss_date >= l_starting_date and 
       lrssetup:loss_date <= l_ending_date and 
       lrssetup:Line_of_business one of 3,4,14 and 
       year(lrssetup:reported_date) = year(l_starting_date)) or

    --this section is to not miss claim that where reported in the next year but the loss actually accurred this year
    --reported date of 2009 but the loss date was in 2008.  these will not show up on the 2008 run because they did not
    --know about these until after the 12/31/2008 run,but need to be counted as closed or open claim in 2009

      (year(lrssetup:reported_date) = year(l_starting_date) and
       year(loss_date) = year(l_starting_date - 1) and 
       lrssetup:loss_date <= l_starting_date and 
       lrssetup:Line_of_business one of 3,4,14) 

list
/domain="lrssetup"
/nodetail
/hold="claimcollection"

lrssetup:status_2 
lrssetup:claim_no  
sfscausea:line_type/heading="Property_liability"
total[lrsdetail:loss_paid]/heading="Loss_paid"
lrssetup:reported_date
lrssetup:loss_date
lrssetup:status_date
policy_no
prem_no 
build_no
line_of_business 
lob_subline
l_starting_date/heading="starting_date" 
l_ending_date/heading="end_date"
lrsSetup:LITIGATION

sorted by sfscausea:line_type lrssetup:claim_no

end of lrssetup:claim_no
lrssetup:status_2 
lrssetup:claim_no  
sfscausea:line_type/heading="Property_liability"
total[lrsdetail:loss_paid]/heading="Loss_paid"
lrssetup:reported_date
lrssetup:loss_date
lrssetup:status_date
lrssetup:policy_no
lrssetup:prem_no 
lrssetup:build_no
lrssetup:line_of_business 
lrssetup:lob_subline
l_starting_date/heading="starting_date" 
l_ending_date/heading="end_date"
lrsSetup:LITIGATION
