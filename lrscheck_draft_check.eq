/* lrscheck_draft_check.eq

   scips.com

   June 17, 2011 

   report to print the checks by check date - if dont print check selected
*/

description 
Claims check register, enter starting and ending dates, will print draft checks only ; 

include "startend.inc"

where lrscheck:trans_date => l_starting_date and
      lrscheck:trans_date <= l_ending_date and
      lrscheck:dont_print_check = 1

list
/nobanner
/domain="lrscheck"
/title = "Claim Checks Register - Draft Checks Only"   
/pagewidth=132
/duplicates 

lrscheck:company_id 
lrscheck:claim_no 
sfsline:claim_alpha/noheading
if lrscheck:loss_payment = 1 then
"L"
else if lrscheck:alae_payment = 1 then
"AE"
else "UE"/heading="TYPE"

lrscheck:payee_name[1]
lrscheck:check_no/heading="Check-No"
lrscheck:check_date 
lrscheck:check_amount 
apsaccount:tpa 

sorted by lrscheck:account/newpage 
          lrscheck:check_no 

top of page                             

"lrscheck draft"/left/newline   
trun("Check Date Range")/center/newline 
trun(str(l_starting_date,"MM/DD/YYYY")+" - "+str(l_ending_date,"MM/DD/YYYY"))
/center/newline       
