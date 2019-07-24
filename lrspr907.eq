/* lrspr907.eq

   January 20, 1997

   white hall mutual insurance company

   program to count the number of ALL claims
   for closed with payment, closed without payment
   and open claims */

description Count Open Claims by Date ;

include "startend.inc"

define string l_status = switch(lrsdetail:trans_code)
case 12,14      : "Closed With Payment"
case 13         : "Closed Without Payment"
default         : "OPEN "   

Define String l_stmt = switch(sfsline_alias:stmt_lob)
case 03, 04     : "Homeowners - Farmowners "
case 05         : "Commercial Multiperil "
case 17, 18     : "Other Liability "
default         : "All Other "

where lrsdetail:trans_date >= l_starting_date and 
      lrsdetail:trans_date <= l_ending_date 
sum
/title="Claim Count - Property & Liability"
/nobanner    


units/heading="Claim-Counts"/mask="ZZZZZ"

across l_status/noheading

by
l_stmt/newpage/count/total/heading="Statement LOB : "
lrssetup:loss_date/year/heading="Incured Date : "
                                            
;
