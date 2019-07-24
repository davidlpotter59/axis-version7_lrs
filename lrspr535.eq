/*  LRSPR535

    Losses by Claim Number - Ceded - by Treaty (Reinsco)

    Date Written : October 21, 2002

    SCIPS.com */

description Loss By Claim Number - Ceded - By Treaty (Reinsurance Company);
             
define string l_name[10] = lrssetup:name[1]
Define String l_prog_number = "LRSPR535 - Rev 4.00"       

define string l_claim_no = str(lrsdetail:claim_no) + trun(sfsline_alias:claim_alpha)

Include "lrs63cal.inc"

include "lrscollect.inc"  

and   lrsdetail:trans_date <= l_ending_date and
      lrsdetail:trans_code => 50

list
/nobanner
/domain="lrsdetail" 
/title="Losses By Claim Number - Ceded (Treaty and Facultative) - By Treaty"
--/pagewidth=220
/duplicates
/nodetail
/nopageheadings
/noreporttotals 

box/duplicates 
l_claim_no/heading="Claim-No"/column=1
lrssetup:policy_no/heading="Policy-No"/column=13
lrssetup:name[1,1,40]/heading="Name"/column=25
sfpname:eff_date/heading="Effective-Date"/column=60/duplicates 
lrsdetail:cause_of_loss/heading="Cause"/column=72/duplicates 
lrsdetail:cause_loss_subline/noheading/column=77
lrssetup:loss_date/heading="Loss-Date"/column=82
lrsdetail:line_of_business/heading="LOB-Subline"/column=94 
lrsdetail:lob_subline/noheading/column=98
l_status/heading="Open/Closed"/width=12/column=101
l_loss_paid/heading="Period-Losses-Paid"/width=15/column=117
l_curr_adj_exp/heading="Period-LAE-Paid"/width=15/column=137
l_curr_resv/heading="Current-Loss-Reserves"/width=15/column=157
l_curr_adj_resv/heading="Current-LAE Reserves"/width=15/column=177
l_prior_resv/heading="Prior-Loss-Reserves"/width=15/column=197
l_prior_adj_resv/heading="Prior-LAE Reserves"/width=15/column=217
l_incurred/heading="Current Period-Incurred Losses-Without LAE"/width=15/column=237
l_incurred_lae/heading="Current Period-Incurred LAE"/width=15/column=257
l_incurred_total/heading="Current Period-Net Losses &-LAE Incurred"/width=15/column=277
end box

sorted by lrsdetail:reins_co/newpage 
          lrsdetail:claim_no
          lrsdetail:cause_of_loss 
          lrsdetail:cause_loss_subline 
           
top of lrsdetail:reins_co 
""/newline
lrsdetail:reins_co/heading="  Claims for Reinsurance Treaty "/newline=2

end of lrsdetail:reins_co                         
""/newline 
lrsdetail:reins_co/heading="Totals for Treaty "/column=30
total[l_loss_paid,lrsdetail:reins_co]/noheading/align=l_loss_paid
total[l_curr_adj_exp,lrsdetail:reins_co]/noheading/align=l_curr_adj_exp
total[l_curr_resv,lrsdetail:reins_co]/noheading/align=l_curr_resv
total[l_curr_adj_resv,lrsdetail:reins_co]/noheading/align=l_curr_adj_resv
total[l_prior_resv,lrsdetail:reins_co]/noheading/align=l_prior_resv
total[l_prior_adj_resv,lrsdetail:reins_co]/noheading/align=l_prior_adj_resv
total[l_incurred,lrsdetail:reins_co]/align=l_incurred/noheading
total[l_incurred_lae,lrsdetail:reins_co]/align=l_incurred_lae/noheading
total[l_incurred_total,lrsdetail:reins_co]/align=l_incurred_total/noheading  
 
end of lrsdetail:claim_no 
l_claim_no/noheading
lrssetup:policy_no/noheading/column=13
lrssetup:name[1,1,40]/noheading/column=25
sfpname:eff_date/noheading/column=60
lrsdetail:cause_of_loss/noheading/column=72
lrsdetail:cause_loss_subline/noheading/column=77
lrssetup:loss_date/noheading/column=82
lrsdetail:line_of_business/noheading/column=94
lrsdetail:lob_subline/noheading/column=98
l_status/noheading/width=12/column=101
total[l_loss_paid,lrsdetail:claim_no]/noheading/align=l_loss_paid/column=117
total[l_curr_adj_exp,lrsdetail:claim_no]/noheading/align=l_curr_adj_exp/column=137
total[l_curr_resv,lrsdetail:claim_no]/noheading/align=l_curr_resv/column=157
total[l_curr_adj_resv,lrsdetail:claim_no]/noheading/align=l_curr_adj_resv/column=177
total[l_prior_resv,lrsdetail:claim_no]/noheading/align=l_prior_resv/column=197
total[l_prior_adj_resv,lrsdetail:claim_no]/noheading/align=l_prior_adj_resv/column=217
total[l_incurred,lrsdetail:claim_no]/align=l_incurred/noheading/column=237
total[l_incurred_lae,lrsdetail:claim_no]/align=l_incurred_lae/noheading/column=257
total[l_incurred_total,lrsdetail:claim_no]/align=l_incurred_total/noheading/column=277

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
