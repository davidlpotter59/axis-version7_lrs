/*  lrspr700.eq

    October 19, 2002

    SCIPS.com

    Report to print a selected Claim with Direct and all Treaties
*/

description 
Enter a starting and ending date range as well as a claim number and this report will list the direct details, ceded and then total (NET) the claim ;

include "startend.inc"
                                         
define string l_trans_type[1] = str(lrsdetail:trans_code)

define string l_trans_type_str[20]=switch(l_trans_type)
case "1"   : "Direct Totals     "
default    : "Reinsurance Totals"

define signed ascii number l_prior_lae_paid = if
lrsdetail:trans_date < l_starting_date then
lrsdetail:lae_paid 
else
0.00

define signed ascii number l_prior_loss_paid = if
lrsdetail:trans_date < l_starting_date then
lrsdetail:loss_paid 
else                                                         
0.00

define signed ascii number l_prior_loss_resv = if
lrsdetail:trans_date < l_starting_date then
lrsdetail:loss_resv 
else
0.00

define signed ascii number l_current_loss_paid = if
lrsdetail:trans_date >= l_starting_date and
lrsdetail:trans_date <= l_ending_date then
lrsdetail:loss_paid 
else
0.00

define signed ascii number l_current_loss_resv = if
lrsdetail:trans_date >= l_starting_date and
lrsdetail:trans_date <= l_ending_date then
lrsdetail:loss_resv
else
0.00

define signed ascii number l_current_lae_paid = if
lrsdetail:trans_date >= l_starting_date and
lrsdetail:trans_date <= l_ending_date then
lrsdetail:lae_paid 
else
0.00

define signed ascii number l_current_lae_resv = if
lrsdetail:trans_date >= l_starting_date and
lrsdetail:trans_date <= l_ending_date then
lrsdetail:lae_resv
else
0.00
    
define unsigned ascii number l_claim_no=parameter /prompt=
"Enter Claim Number<NL>"
              
where lrsdetail:trans_date <= l_ending_date 
  and lrsdetail:claim_no = l_claim_no 

list
/nobanner
/domain="lrsdetail"
/pagewidth=190
/noreporttotals  
/title="LRSDETAIL Audit Report - By Claim Number "

lrsdetail:claim_no/noduplicates/column=1
lrsdetail:trans_code/column=15
lrscode:description[1,20]/duplicates/column=20  
lrssetup:reported_date  
lrssetup:loss_date
lrsdetail:trans_date
lrsdetail:reins_co /heading="Treaty-Number"/mask="ZZZZZ"/column=95
l_current_loss_resv/total/heading="Current-Loss Reserve"/column=115
l_current_loss_paid/total/heading="Current-Loss Paid"/column=135
l_current_lae_resv/total/heading="Current-LAE Resv"/column=155
l_current_lae_paid/total/heading="Current-LAE Paid"/column=175   

sorted by lrsdetail:claim_no/newlines
          l_trans_type_str/newlines=3
          lrsdetail:reins_co/newlines=2
          lrsdetail:trans_date      
                                                 

end of lrsdetail:claim_no 
box/noheadings            
    ""/newline 
    "Net For Claim Number"/column=30
    total[l_current_loss_resv,lrsdetail:claim_no]/column=115
    total[l_current_loss_paid,lrsdetail:claim_no]/column=135
    total[l_current_lae_resv,lrsdetail:claim_no]/column=155
    total[l_current_lae_paid,lrsdetail:claim_no]/column=175
    if total[l_current_loss_resv,lrsdetail:claim_no] < 0 then
    {
        "The Above Claim is out of balance"/newline
    }
xob                                                 

end of lrsdetail:reins_co 
box/noheadings            
    if lrsdetail:reins_co <> 0 then 
    {          
        ""/newline 
        "Total For Treaty "/column=30
        total[l_current_loss_resv,lrsdetail:reins_co]/column=115
        total[l_current_loss_paid,lrsdetail:reins_co]/column=135
        total[l_current_lae_resv,lrsdetail:reins_co]/column=155
        total[l_current_lae_paid,lrsdetail:reins_co]/column=175
    }
xob                                                 

end of l_trans_type_str 
box/noheadings                                       
    ""/newline 
    l_trans_type_str/noheading/column=30
    total[l_current_loss_resv,l_trans_type_str]/column=115
    total[l_current_loss_paid,l_trans_type_str]/column=135
    total[l_current_lae_resv,l_trans_type_str]/column=155
    total[l_current_lae_paid,l_trans_type_str]/column=175
xob                                                 

end of report 
box/noheadings            
   ""/newline 
   "Total "/column=30
   total[l_current_loss_resv]/column=115
   total[l_current_loss_paid]/column=135
   total[l_current_lae_resv]/column=155
   total[l_current_lae_paid]/column=175
xob       
