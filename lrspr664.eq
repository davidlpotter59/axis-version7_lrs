/*  LRSPR664

    Losses by Claim Number - Direct and ceded

    Date Written : February 8, 2003

    SCIPS.com, Inc. */

description Outstanding Loss / LAE - Net;

define string l_type = if
lrsdetail:reins_co = 0 then "Direct"
else
"Treaty " + str(lrsdetail:reins_co)
             
define string l_claim_no = str(lrsdetail:claim_no) + trun(sfsline_alias:claim_alpha
)

Define String l_prog_number = "LRSPR664 - Rev 4.10"

Include "lrs63cal.inc"

include "lrscollect.inc"
and   lrsdetail:trans_date <= l_ending_date

list
/nobanner
/domain="lrsdetail"
/title="Outstanding Losses By Annual Statement Line (NET)"
/pagewidth=255
/duplicates 
/nodetail                   
/nototals 

Include "lrs634prt.inc"

sorted by sfsline:stmt_lob 
          lrsdetail:line_of_business 


end of sfsline:stmt_lob  
total[l_loss_paid,     sfsline:stmt_lob]/noheading/align=l_loss_paid
total[l_curr_adj_exp,  sfsline:stmt_lob]/noheading/align=l_curr_adj_exp
total[l_curr_resv,     sfsline:stmt_lob]/noheading/align=l_curr_resv
total[l_curr_adj_resv, sfsline:stmt_lob]/noheading/align=l_curr_adj_resv
total[l_prior_resv,    sfsline:stmt_lob]/noheading/align=l_prior_resv
total[l_prior_adj_resv,sfsline:stmt_lob]/noheading/align=l_prior_adj_resv
total[l_incurred,      sfsline:stmt_lob]/align=l_incurred
total[l_incurred_lae,  sfsline:stmt_lob]/align=l_incurred_lae/noheading
total[l_incurred_total,sfsline:stmt_lob]/align=l_incurred_total/noheading

end of lrsdetail:line_of_business 
lrsdetail:line_of_business/column=20/noheading
sfsline_heading:description/noheading/column=25 
total[l_loss_paid,lrsdetail:claim_no]/noheading/align=l_loss_paid
total[l_curr_adj_exp,lrsdetail:claim_no]/noheading/align=l_curr_adj_exp
total[l_curr_resv,lrsdetail:claim_no]/noheading/align=l_curr_resv
total[l_curr_adj_resv,lrsdetail:claim_no]/noheading/align=l_curr_adj_resv
total[l_prior_resv,lrsdetail:claim_no]/noheading/align=l_prior_resv
total[l_prior_adj_resv,lrsdetail:claim_no]/noheading/align=l_prior_adj_resv
total[l_incurred,lrsdetail:claim_no]/align=l_incurred
total[l_incurred_lae,lrsdetail:claim_no]/align=l_incurred_lae/noheading
total[l_incurred_total,lrsdetail:claim_no]/align=l_incurred_total/noheading  
lrsceded:surplus_percent/noheading  
lrsceded:amount_subject/noheading


end of report
""/newline
"Report Total"/noheading/column=70
total[l_loss_paid]/noheading/align=l_loss_paid
total[l_curr_adj_exp]/noheading/align=l_curr_adj_exp
total[l_curr_resv]/noheading/align=l_curr_resv
total[l_curr_adj_resv]/noheading/align=l_curr_adj_resv
total[l_prior_resv]/noheading/align=l_prior_resv
total[l_prior_adj_resv]/noheading/align=l_prior_adj_resv
total[l_incurred]/align=l_incurred
total[l_incurred_lae]/align=l_incurred_lae/noheading
total[l_incurred_total]/align=l_incurred_total/noheading

Include "rpttopfw.inc"

;
/*  END OF FILE */
