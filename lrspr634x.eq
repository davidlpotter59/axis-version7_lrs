/*  LRSPR634

    Losses by Claim Number - Direct and ceded

    Date Written : February 8, 2003

    SCIPS.com, Inc. */

description Losses by Claim Number - Direct and Ceded - Detail ;

define string l_type = if
lrsdetail:reins_co = 0 then "Direct"
else
"Treaty " + str(lrsdetail:reins_co)
             
define string l_claim_no = str(lrsdetail:claim_no) + trun(sfsline_alias:claim_alpha
)

Define String l_prog_number = "LRSPR634 - Rev 4.10"

Include "lrs63cal.inc"

include "lrscollect.inc"
and   lrsdetail:trans_date <= l_ending_date   
-- and sfscause:line_type = "P"
--and lrsdetail:claim_no = 182002 
--and lrsdetail:trans_code >= 70
list
/nobanner
/domain="lrsdetail"
/title="Losses By Claim Number - DIRECT and Ceded (NET)"
/pagewidth=220
/duplicates 
/nodetail                   
/nototals
/wks 

Include "lrs634prt.inc"

sorted by lrsdetail:claim_no/newline
          l_type

--Include "lrs634clm.inc" 

end of l_type 
if l_type = "Direct" then 
{  
l_claim_no/noheading
lrssetup:policy_no/column=13/noheading 
str(lrsdetail:cause_of_loss) + " " + lrsdetail:cause_loss_subline/noheading
lrssetup:loss_date/noheading
str(lrsdetail:Line_of_business) + " " + lrsdetail:lob_subline/noheading  
l_type/noheading/column=70
total[l_loss_paid,l_type]/noheading/align=l_loss_paid
total[l_curr_adj_exp,l_type]/noheading/align=l_curr_adj_exp
total[l_curr_resv,l_type]/noheading/align=l_curr_resv
total[l_curr_adj_resv,l_type]/noheading/align=l_curr_adj_resv
total[l_prior_resv,l_type]/noheading/align=l_prior_resv
total[l_prior_adj_resv,l_type]/noheading/align=l_prior_adj_resv
total[l_incurred,l_type]/align=l_incurred
total[l_incurred_lae,l_type]/align=l_incurred_lae/noheading
total[l_incurred_total,l_type]/align=l_incurred_total/noheading
}
else
{   
l_type/noheading/column=70 
total[l_loss_paid,l_type]/noheading/align=l_loss_paid
total[l_curr_adj_exp,l_type]/noheading/align=l_curr_adj_exp
total[l_curr_resv,l_type]/noheading/align=l_curr_resv
total[l_curr_adj_resv,l_type]/noheading/align=l_curr_adj_resv
total[l_prior_resv,l_type]/noheading/align=l_prior_resv
total[l_prior_adj_resv,l_type]/noheading/align=l_prior_adj_resv
total[l_incurred,l_type]/align=l_incurred
total[l_incurred_lae,l_type]/align=l_incurred_lae/noheading
total[l_incurred_total,l_type]/align=l_incurred_total/noheading
}                                                                      

end of claim_no
"NET"/noheading/column=70
total[l_loss_paid,lrsdetail:claim_no]/noheading/align=l_loss_paid
total[l_curr_adj_exp,lrsdetail:claim_no]/noheading/align=l_curr_adj_exp
total[l_curr_resv,lrsdetail:claim_no]/noheading/align=l_curr_resv
total[l_curr_adj_resv,lrsdetail:claim_no]/noheading/align=l_curr_adj_resv
total[l_prior_resv,lrsdetail:claim_no]/noheading/align=l_prior_resv
total[l_prior_adj_resv,lrsdetail:claim_no]/noheading/align=l_prior_adj_resv
total[l_incurred,lrsdetail:claim_no]/align=l_incurred
total[l_incurred_lae,lrsdetail:claim_no]/align=l_incurred_lae/noheading
total[l_incurred_total,lrsdetail:claim_no]/align=l_incurred_total/noheading
Include "rpttopfw.inc"

;
/*  END OF FILE */
