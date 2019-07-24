/* lrscheck_tpa

   scips.com

   October 30, 2003

   report to print the checks by check date
*/

description 
Claims check register, enter starting and ending dates, will print VOIDED checks with totals for VOIDED and page break;

include "startend.inc"

define string l_print_voided_checks[1]=parameter/prompt="Print Voided Checks"/uppercase 
error "Only Y or N Accepted for VOIDED check printing Option" if
l_print_voided_checks not one of "Y","N","y","n"

define string l_check_type[1] = switch(lrscheck:release )
case "V" : "A"
default  : "X"

define string l_page_heading = switch(l_check_type)
case "V" : "VOIDED Claims Check"
case "X"  : "Processed Claims Check"

where (lrscheck:printed_date => l_starting_date and
       lrscheck:printed_date <= l_ending_date) or
       (lrscheck:release = "V" and 
        l_print_voided_checks not one of "Y") 

list
/nobanner
/domain="lrscheck"
/title = "Claim Checks Register"   
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
lrscheck:check_no_string/heading="Check-No"
lrscheck:printed_date 
lrscheck:check_amount 
apsaccount:tpa 

sorted by lrscheck:account/newpage 
          l_check_type/newpage/total/heading="Check Type"
          lrscheck:check_no 

top of page                             

"lrscheck"/left/newline   
trun("Check Date Range")/center/newline 
trun(str(l_starting_date,"MM/DD/YYYY")+" - "+str(l_ending_date,"MM/DD/YYYY"))
/center/newline       
"Account " + lrscheck:account/center/newlines
trun(l_page_heading)/noheading/center /newline 
"VOIDED CHECKS: " + trun(l_print_voided_checks)/noheading/center
