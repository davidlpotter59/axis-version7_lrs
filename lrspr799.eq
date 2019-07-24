/*  lrspr799

    December 15, 2006
     
    scips.com, inc

    Unreleased/issued claims check report 
*/

description Unreleased/issued claims check report ;
    
include "startend.inc"

define string l_prog_number = "XXXX"

where ((lrscheck:trans_date => l_starting_date and 
       (lrscheck:dont_print_check = 0 and
       lrscheck:company_id = "LEBINS") and
       lrscheck:trans_date <= l_ending_date ) or
       lrscheck:trans_date = 00.00.0000) and
       lrscheck:release not one of "Y"

list
/nobanner
/domain="lrscheck"
/title="Claims Cash Requirement Report"

lrscheck:claim_no 
lrscheck:trans_date 
lrscheck:release 
lrscheck:payee_name[1]
lrscheck:check_amount 

sorted by lrschECK:claim_no 

include "reporttop.inc"
