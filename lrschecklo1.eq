/*  lrschecklo1

    scips.com

    august 9, 2001

    report to print the check register for a given date range
*/

description 

Claims checks register, enter a starting and ending date, will not print voided checks, output in Excel;

include "startend.inc"
                         
define unsigned ascii number l_check_no[6] = val(lrscheck:check_no)

where (lrscheck:check_date => l_starting_date and
      lrscheck:check_date <= l_ending_date and
      lrscheck:status_after_check <> "V" and
      (lrscheck:alae_payment = 1 or
      lrscheck:ulae_payment = 1))

list
/nobanner
/domain="lrscheck"
/nototals
/wk1

    claim_no/heading="Policy-Number" 
    lrscheck:payee_name[1]/heading="Payee"
    l_check_no/heading="Check-Number"/nototal 
    check_date/heading="Check-Date" 
    check_amount/heading="Check-Amount"/total 

sorted by lrscheck:payee_name[1]
          lrscheck:check_no 
