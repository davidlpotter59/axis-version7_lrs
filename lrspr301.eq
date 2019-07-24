/*  lrspr301.eq

    scips.com

    January 11, 2011 

    report to print ulae or alae payments with no vendors 
*/

description report to print ulae or alae payments with no vendors for 1099's ;

include "startend.inc"
                         
define string l_type = if lrscheck:loss_payment = 1 then
"Case Loss" else
if lrscheck:alae_payment = 1 then
"Expense" else
"Expense"

define unsigned ascii number l_Vendor[5] = lrscheck:vendor_no[1]

define file alt_sfsvendor = access sfsvendor, set
sfsvendor:company_id = lrscheck:company_id,
sfsvendor:vendor_no  = l_vendor, exact 

define unsigned ascii number l_check_no[6] = val(lrscheck:check_no)

define string l_name[50] = lrscheck:payee_name[1]

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

where (lrscheck:check_date => l_starting_date and
      lrscheck:check_date <= l_ending_date  and
      lrscheck:status_after_check <> "V" and
      lrscheck:voided_corrected = 0 and
      lrscheck:correct_return = "" and
      l_vendor = 0 and
      (lrscheck:alae_payment = 1 or
      lrscheck:ulae_payment = 1))

list
/nobanner
/domain="lrscheck"
--/nodefaults
--/wks
/nodetail

l_tax_id/heading="Tax ID"
lrscheck:payee_name[1]/heading="Payee"
check_amount/heading="Check-Amount" 
l_vendor/heading="Vendor"
l_ten99/heading="1099"

sorted by l_tax_id 
          
end of l_tax_id 
if total[lrscheck:check_amount] >= 600 then 
{ 
l_tax_id/noheading
lrscheck:payee_name[1]/noheading
total[lrscheck:check_amount]/noheading
l_Vendor/noheading
l_ten99/noheading
}

