/* lrspr302.eq
 
   SCIPS.com, Inc.

   January 6, 2011

   report that lists the payment codes and the amounts paid - summary

*/

description report that lists the payment codes and the amounts paid - summary ;

include "startend.inc"

where lrscheck:payment_code_1 <> 0 and
      lrscheck:trans_date => l_starting_date and
      lrscheck:trans_date <= l_ending_date
list
/domain="lrscheck"
/nobanner
/title="Payment Codes and Amounts Paid"
/nodetail

lrscheck:payment_code_1/heading="Payment Code"/column=1
apspaycode:description/noheading/column=5
lrscheck:line_of_business/heading="LOB"/column=40
year(lrssetup:loss_date)/heading="Loss Year"/column=45
lrscheck:check_amount/heading="Check Amount"/column=55

sorted by lrscheck:payment_code_1/newline
          lrscheck:line_of_business

end of lrscheck:line_of_business
lrscheck:payment_code_1/noheading/column=1
apspaycode:description/noheading/column=5
lrscheck:line_of_business/noheading/column=40
year(lrssetup:loss_date)/noheading/column=45
total[lrscheck:check_amount]/noheading/column=55

;
