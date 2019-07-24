/* lrspr904.eq

   January 20, 1997

   white hall mutual insurance company

   program to count the number of liability claims
   for closed with payment, closed without payment
   and open claims */

description Count of Open Bodily Injry Claims ;

define string l_status = switch(lrsdetail:trans_code)
case 12,14      : "Closed With Payment"
case 13         : "Closed Without Payment"
default         : "OPEN "   

Define String l_stmt = switch(sfsline_alias:stmt_lob)
case 03, 04     : "Homeowners - Farmowners "
case 05         : "Commercial Multiperil "
case 17, 18     : "Other Liability "
default         : "All Other "

where sfscause:line_type = "L" 

sum
/title="Claim Count - Liability"
/nobanner    

units/heading="Claim-Counts"/mask="ZZZZZ"

across l_status/noheading

by
l_stmt/newpage/count/total/heading="Statement LOB : "
lrssetup:loss_date/year/heading="Incured Date : "

;
