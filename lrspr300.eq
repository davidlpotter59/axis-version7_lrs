/* lrspr300.eq
 
   SCIPS.com, Inc.

   January 6, 2011

   report that lists the payment codes and the amounts paid

*/

description report that lists the payment codes and the amounts paid ;

include "startend.inc"

where lrscheck:payment_code_1 <> 0 and
      lrscheck:trans_date => l_starting_date and
      lrscheck:trans_date <= l_ending_date
list
/domain="lrscheck"
/nobanner
/title="Payment Codes and Amounts Paid"

lrscheck:claim_no
lrscheck:check_amount

sorted by lrscheck:payment_code_1
          lrscheck:claim_no

top of lrscheck:payment_code_1
lrscheck:payment_code_1/noheading
apspaycode:description/noheading/newline
;
