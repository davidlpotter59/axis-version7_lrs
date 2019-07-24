Define String l_prog_number = "LRSPR538 - Rev 4.10"

Include "lrs63calliab.inc"                                                                                                                                 
                                                                                                                                                          
include "lrscollect.inc"                                                                                                                                   
and lrsdetail:trans_date <= l_ending_date and                                                                                                              
    lrsdetail:trans_code < 30 
--and lrsdetail:claim_no one of 5232009                                                                                                                              
                                                                                                                                                           
list                                                                                                                        
                               
/nobanner                                                                                                                   
                               
/domain="lrsdetail"                                                                                                         
                               
/title="Direct Losses By Claim Number cause of loss sub line"                                                               
                   
/pagewidth=250                                                                                                              
                               
/duplicates                                                                                                                 
                               
/nodetail  

lrsdetail:claim_no/column=1
lrssetup:policy_no/noheading/column=13
lrssetup:eff_date/noheading/column=25
lrsdetail:cause_of_loss/noheading/column=37
lrsdetail:cause_loss_subline/noheading/column=41
lrssetup:loss_date/noheading/column=45
lrsdetail:line_of_business/noheading/column=57
lrsdetail:lob_subline/noheading/column=61

sorted by claim_no cause_of_loss cause_loss_subline 

end of cause_of_loss
lrsdetail:claim_no/noheading/column=1
lrssetup:policy_no/noheading/column=13
lrssetup:eff_date/noheading/column=25
lrsdetail:cause_of_loss/noheading/column=37
lrsdetail:cause_loss_subline/noheading/column=41
lrssetup:loss_date/noheading/column=45
lrsdetail:line_of_business/noheading/column=57
lrsdetail:lob_subline/noheading/column=61

total[l_loss_paid]/noheading
--/align=l_loss_paid                                                                                                           
total[l_curr_adj_exp]/noheading
--/align=l_curr_adj_exp                                                                                                       
total[l_curr_resv]/noheading
--/align=l_curr_resv                                                                                                             
total[l_curr_adj_resv]/noheading
--/align=l_curr_adj_resv                                                                                                     
total[l_prior_resv]/noheading
--/align=l_prior_resv                                                                                                           
total[l_prior_adj_resv]/noheading
-- /align=l_prior_adj_resv                                                                                                   
total[l_incurred]
--/align=l_incurred/noheading                                                                                                               
total[l_incurred_lae]
--/align=l_incurred_lae/noheading                                                                                                       
total[l_incurred_total]--/align=l_incurred_total/noheading
