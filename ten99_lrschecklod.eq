/*  ten99_lrschecklod

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
"ALAE Expense" else
"ULAE Expense"

define unsigned ascii number l_Vendor[5] = lrscheck:vendor_no[1]

define file alt_sfsvendor = access sfsvendor, set
sfsvendor:company_id = lrscheck:company_id,
sfsvendor:vendor_no  = l_vendor, exact 

define unsigned ascii number l_check_no[6] = val(lrscheck:check_no)

define string l_tax_id[15] = if lrscheck:tin <> "" then
                             lrscheck:tin
                         else
                         if alt_sfsvendor:ident_no <> "" then
                             alt_sfsvendor:ident_no
                         else
                             ""
  
define string l_ten99_vendor = alt_sfsvendor:ten99   

define string l_ten99_lrscheck = switch(lrscheck:ten99)
                                   case 1  : "Y"
                                   default : "N"
                                 
define string l_ten99 = if l_ten99_vendor = "Y" then
                            "Y"
                        else
                        if l_ten99_lrscheck = "Y" then
                            "Y"
                        else
                            "N"  

define string l_name[50] = lrscheck:payee_name[1]

where lrscheck:check_date => l_starting_date and
      lrscheck:check_date <= l_ending_date and
      lrscheck:status_after_check <> "V" and
      lrscheck:voided_corrected = 0 and
      lrscheck:correct_return = "" and
      l_ten99 = "Y" 

list
/nobanner
/domain="lrscheck"
/pagewidth=160
--/nodefaults
--/wks

box/noblanklines/noheading/column=1
    l_tax_id/heading="Tax-ID"/column=1
    claim_no/heading="Claim-No"/column=30
    lrscheck:payee_name[1,1,30]/heading="Payee"/column=50
    check_amount/heading="Check-Amount"/column=100 
    l_ten99/heading="Ten99"/column=115
    l_type/heading="Type"/column=125
    lrscheck:bf/heading="1099B"/column=150
end box

sorted by lrscheck:payee_name[1]/total/newline 
