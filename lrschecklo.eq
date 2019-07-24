/*  lrschecklo

    scips.com

    august 9, 2001

    report to print the check register for a given date range
*/

description 

Claims checks register, enter a starting and ending date, will not print voided checks, output in Excel;

include "startend.inc"
                         
define string l_type = if lrscheck:loss_payment = 1 then
"Case Loss" else
if lrscheck:alae_payment = 1 then
"Expense" else
"Expense"

--define unsigned ascii number l_check_no[6] = val(lrscheck:check_no)

where lrscheck:check_date => l_starting_date and
      lrscheck:check_date <= l_ending_date and
      lrscheck:status_after_check <> "V"

list
/nobanner
/domain="lrscheck"
/nodefaults

    l_type /heading="Type"
    claim_no/heading="Policy-Number" 
    lrscheck:payee_name[1]/heading="Payee"
    check_draft/heading="Check-Draft" 
    checK_cleared/heading="Cleared" 
    check_cleared_date/heading="Check Cleared-Date"
    val(lrscheck:check_no[10,20])/mask="Z(20)"/heading="ChkNum"  
    check_date/heading="Check-Date" 
    check_amount/heading="Check-Amount"/total 

sorted by lrscheck:account/newpage 
          l_type/newpage/total/heading="Check Type"
          lrscheck:check_no 
