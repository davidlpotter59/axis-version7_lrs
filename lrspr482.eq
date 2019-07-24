/* lrspr482.eq

   January 25, 2005

   scips.com, Inc.

   claim counts by Annual Statement Line of Business, Date of Loss
*/

description Claims Counts by Annual Statement Line of Business, Date of Loss;

include "startend.inc"

define string l_status = if
lrssetup:status = "C" and lrssetup:status_2 one of 0,1 then "CLOSED With"
else if lrssetup:status = "C" and lrssetup:status_2 one of 2 then "CLOSED Without"
else if lrssetup:status = "O" then "O - OPEN             " 
else if lrssetup:status = "R" then "R - REOPEN           "
else if lrssetup:status = "Z" then "Z - Policy Cancelled "
else if lrssetup:status = "X" then "X - Invalid Policy   "
else                               lrssetup:status 

define file sfslinea = access sfsline, set sfsline:company_id= lrssetup:company_id, 
                                           sfsline:line_of_business= lrssetup:line_of_business,
                                           sfsline:lob_subline= lrssetup:lob_subline 

where  lrssetup:loss_date <= l_ending_date and 
      (lrssetup:reported_date => l_starting_date and 
       lrssetup:reported_date <= l_ending_date)

sum
/nobanner
/domain="lrssetup"
/xls="lrspr482"
/title="Claim Counts by A/S Line - Date of Loss"

lrssetup:units/heading="Count" 

across l_status/heading="Claim Status"

by sfslinea:stmt_lob/heading="A/S LOB"/newlines /total 
   year(lrssetup:loss_Date)
