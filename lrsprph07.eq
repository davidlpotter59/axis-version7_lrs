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

where lrssetup:reported_date >= l_starting_date and 
      lrssetup:reported_date <= l_ending_date 
and year(lrssetup:status_date) = year(l_ending_date) 
and lrssetup:status_2 one of 1, 2
and lrssetup:litigation one of "Y"
and lrssetup:line_of_business one of 1,4,14,24,44

sum
/nobanner
/domain="lrssetup"
/title="Homeowners Claims Closed With Payment - Count"

units/heading="Claim-Count" 

across l_days_to_settle  /heading="Days to-Settle (Months)"

by year(lrssetup:reported_date)/heading="Reported-Year"
   year(lrssetup:loss_date)/heading="Loss Date-Year"
   year(lrssetup:status_date)/heading="Date Closed"
