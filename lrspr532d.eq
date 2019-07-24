/*  LRSPR532d

    Losses by Claim Number - Ceded (Detail)

    Date Written : November 1, 2002

    SCIPS.com */

description Loss By Claim Number - Ceded - Detail Transactions;
             
define string l_name[10] = lrssetup:name[1]
Define String l_prog_number = "LRSPR532D - Rev 4.00"       

define string l_claim_no = str(lrsdetail:claim_no) + trun(sfsline_alias:claim_alpha)

Include "lrs63cal.inc"

include "lrscollect.inc"  

and   lrsdetail:trans_date <= l_ending_date and
      lrsdetail:trans_code => 50

list
/nobanner
/domain="lrsdetail" 
/title="Losses By Claim Number - Ceded (Treaty and Facultative) - Detail"
/pagewidth=220
/duplicates
/nopageheadings
/noreporttotals 

l_claim_no/heading="Claim-No"
lrssetup:policy_no/heading="Policy-No"/column=13
sfpname:eff_date/heading="Effective-Date"
lrsdetail:cause_of_loss/heading="Cause Of-Loss"
lrsdetail:cause_loss_subline/noheading
lrssetup:loss_date/heading="Date Of-Loss"
lrsdetail:line_of_business/heading="Line Of-Business" 
lrsdetail:reins_co/heading="Treaty-No."
l_loss_paid/heading="Period-Losses-Paid"/width=15/column=77
l_curr_adj_exp/heading="Period-LAE-Paid"/width=15
l_curr_resv/heading="Current-Loss-Reserves"/width=15
l_curr_adj_resv/heading="Current-LAE Reserves"/width=15
l_prior_resv/heading="Prior-Loss-Reserves"/width=15
l_prior_adj_resv/heading="Prior-LAE Reserves"/width=15
l_incurred/heading="Current Period-Incurred Losses-Without LAE"/width=15
l_incurred_lae/heading="Current Period-Incurred LAE"/width=15
l_incurred_total/heading="Current Period-Net Losses &-LAE Incurred"/width=15

sorted by lrsdetail:claim_no
          lrsdetail:reins_co/newlines  
          lrsdetail:cause_of_loss 
          lrsdetail:cause_loss_subline 

end of lrsdetail:claim_no 
"  TOTAL FOR CLAIM "/column=35
l_status/noheading/width=12
total[l_loss_paid,lrsdetail:claim_no]/noheading/align=l_loss_paid
total[l_curr_adj_exp,lrsdetail:claim_no]/noheading/align=l_curr_adj_exp
total[l_curr_resv,lrsdetail:claim_no]/noheading/align=l_curr_resv
total[l_curr_adj_resv,lrsdetail:claim_no]/noheading/align=l_curr_adj_resv
total[l_prior_resv,lrsdetail:claim_no]/noheading/align=l_prior_resv
total[l_prior_adj_resv,lrsdetail:claim_no]/noheading/align=l_prior_adj_resv
total[l_incurred,lrsdetail:claim_no]/align=l_incurred/noheading
total[l_incurred_lae,lrsdetail:claim_no]/align=l_incurred_lae/noheading
total[l_incurred_total,lrsdetail:claim_no]/align=l_incurred_total/noheading  

end of lrsdetail:reins_co             
""/newline
"  TOTAL FOR REINSURANCE "/column=35
total[l_loss_paid,lrsdetail:reins_co]/noheading/align=l_loss_paid
total[l_curr_adj_exp,lrsdetail:reins_co]/noheading/align=l_curr_adj_exp
total[l_curr_resv,lrsdetail:reins_co]/noheading/align=l_curr_resv
total[l_curr_adj_resv,lrsdetail:reins_co]/noheading/align=l_curr_adj_resv
total[l_prior_resv,lrsdetail:reins_co]/noheading/align=l_prior_resv
total[l_prior_adj_resv,lrsdetail:reins_co]/noheading/align=l_prior_adj_resv
total[l_incurred,lrsdetail:reins_co]/align=l_incurred/noheading
total[l_incurred_lae,lrsdetail:reins_co]/align=l_incurred_lae/noheading
total[l_incurred_total,lrsdetail:reins_co]/align=l_incurred_total/noheading  
 
--include "lrs53col.inc"

Include "rpttopfw.inc"

end of report 
""/newline  
"  REPORT TOTAL "
total[l_loss_paid]/noheading/align=l_loss_paid
total[l_curr_adj_exp]/noheading/align=l_curr_adj_exp
total[l_curr_resv]/noheading/align=l_curr_resv
total[l_curr_adj_resv]/noheading/align=l_curr_adj_resv
total[l_prior_resv]/noheading/align=l_prior_resv
total[l_prior_adj_resv]/noheading/align=l_prior_adj_resv
total[l_incurred]/align=l_incurred/noheading
total[l_incurred_lae]/align=l_incurred_lae/noheading
total[l_incurred_total]/align=l_incurred_total/noheading   


;
/*  END OF FILE */
