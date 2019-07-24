/*  lrsprph04.eq

    scips.com

    October 18, 2001

    claim count of reported claim for a given year - closed w/

    sorted by A/S LOB, reported year/loss_date 
*/
                                                                    
description Claims Closed With Payment - Count ;

include "startend.inc"
define string l_prog_number="LRSPRPH04 - Version 5.00"

define unsigned ascii number l_year_1 = year(lrssetup:reported_date)
define unsigned ascii number l_year_2 = year(lrssetup:loss_date)

define string l_status = switch(lrssetup:status_2)
case 1 : "Closed With Payment"
case 2 : "Closed Without Payment"
default : "Closed Without Payment"

define unsigned ascii number l_lob = switch(sfsline_alias:stmt_lob)
    case 3,4                : 1
    case 5                  : 2
    case 17                 : 3
    case 1,2,9,25,26        : 4
    case 21                 : 5

define string l_lob_str = switch(l_lob)
    case 1                  : "Ho/Fo"
    case 2                  : "CMP"
    case 3                  : "Other Liab"
    case 4                  : "Spec Prop" 
    case 5                  : "Auto PD"

define unsigned ascii number l_days_to_settle  = ((lrssetup:status_date - lrssetup:reported_date ) 
div 30)

define string l_closed = switch(lrssetup:status_2)
case 1 : "Closed With Payment   "
case 2 : "Closed Without Payment"
default : "Still Open"

define file sfscausea = access sfscause, set sfscause:company_id= lrssetup:company_id,
                                             sfscause:line_of_business= lrssetup:line_of_business,
                                             sfscause:lob_subline= lrssetup:lob_subline,
                                             sfscause:cause_of_loss= lrssetup:cause_of_loss,
                                             sfscause:cause_loss_subline= lrssetup:cause_loss_subline 

where lrssetup:status_date >= l_starting_date and 
      lrssetup:status_date <= l_ending_date
and lrssetup:Line_of_business one of 1,4,14,24,44
and lrssetup:litigation one of "Y"
and lrssetup:status_2 one of 1,2
and lrssetup:status_date <> 00.00.0000

list
/nobanner
/domain="lrssetup"
/title="Homeowners Claims Closed With Payment - Count"
/pagelength=0

lrssetup:claim_no 
L_days_to_settle 
lrssetup:status_date 
lrssetup:reported_date 

sorted by sfscausea:line_type/newlines /total /heading="TOTAL for @"
          lrssetup:claim_no
