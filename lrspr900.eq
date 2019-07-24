/*  LRSPR635N

    Losses by Claim Number - Direct and ceded

    Date Written : November 3, 2003

    SCIPS.com, Inc. */

description Losses by Claim Number - Net - Detail - By date of loss ;

define string l_type = if
lrsdetail:reins_co = 0 then "Direct"
else
"Treaty " + str(lrsdetail:reins_co)
             
define string l_claim_no = str(lrsdetail:claim_no) + trun(sfsline_alias:claim_alpha
)

Define String l_prog_number = "LRSPR635N - Rev 4.00"

define unsigned ascii number l_loss_year[4]=year(lrssetup:loss_date)

Include "lrs63cal.inc"

include "lrscollect.inc"
and   lrsdetail:trans_date <= l_ending_date

list
/nobanner
/domain="lrsdetail"
/title="Losses By Claim Number - Net Only - By Date of Loss"
/pagewidth=255
/duplicates 
/nodetail                   
/nototals 

Include "lrs634prt.inc"
lrsceded:surplus_percent 
lrsceded:amount_subject 

sorted by l_loss_year/newpage 
          lrsdetail:reins_co /newpage 
          lrsdetail:claim_no
--          l_type

--Include "lrs634clm.inc" 

/* end of l_type 
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
*/

end of l_loss_year 
""/newline 
"Loss Year Total"
total[l_loss_paid,l_loss_year]/noheading/align=l_loss_paid
total[l_curr_adj_exp,l_loss_year]/noheading/align=l_curr_adj_exp
total[l_curr_resv,l_loss_year]/noheading/align=l_curr_resv
total[l_curr_adj_resv,l_loss_year]/noheading/align=l_curr_adj_resv
total[l_prior_resv,l_loss_year]/noheading/align=l_prior_resv
total[l_prior_adj_resv,l_loss_year]/noheading/align=l_prior_adj_resv
total[l_incurred,l_loss_year]/align=l_incurred
total[l_incurred_lae,l_loss_year]/align=l_incurred_lae/noheading
total[l_incurred_total,l_loss_year]/align=l_incurred_total/noheading  

end of lrsdetail:reins_co 
""/newline 
"Treaty Total"
total[l_loss_paid,lrsdetail:reins_co]/noheading/align=l_loss_paid
total[l_curr_adj_exp,lrsdetail:reins_co]/noheading/align=l_curr_adj_exp
total[l_curr_resv,lrsdetail:reins_co]/noheading/align=l_curr_resv
total[l_curr_adj_resv,lrsdetail:reins_co]/noheading/align=l_curr_adj_resv
total[l_prior_resv,lrsdetail:reins_co]/noheading/align=l_prior_resv
total[l_prior_adj_resv,lrsdetail:reins_co]/noheading/align=l_prior_adj_resv
total[l_incurred,lrsdetail:reins_co]/align=l_incurred
total[l_incurred_lae,lrsdetail:reins_co]/align=l_incurred_lae/noheading
total[l_incurred_total,lrsdetail:reins_co]/align=l_incurred_total/noheading  

end of lrsdetail:claim_no 
l_claim_no/noheading
lrssetup:policy_no/column=13/noheading 
str(lrsdetail:cause_of_loss) + " " + lrsdetail:cause_loss_subline/noheading
lrssetup:loss_date/noheading
str(lrsdetail:Line_of_business) + " " + lrsdetail:lob_subline/noheading  
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
""/newline
l_loss_year/heading="Loss Year"/newline 

/*  END OF FILE */
