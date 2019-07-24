/*  LRSPR530

    Losses by Claim Number - Direct

    Date Written : January 23, 2003

    SCIPS.com */

description 
Direct Losses By Claim Number - ALAE and ULAE only ;
             
define string l_name[10] = lrssetup:name[1]
Define String l_prog_number = "LRSPR530 - Rev 4.00"       

define unsigned ascii number l_stmt_lob = sfsline:stmt_lob 
define unsigned ascii number l_loss_year = year(lrssetup:loss_date)

define string l_claim_no = str(lrsdetail:claim_no) + trun(sfsline_alias:claim_alpha)

Include "lrs63callae.inc"

include "lrscollect.inc"  

and   lrsdetail:trans_date <= l_ending_date and
      lrsdetail:trans_code < 30

list
/nobanner
/domain="lrsdetail" 
/title="Direct Losses By Claim Number - LAE Only"
/pagewidth=220
/duplicates
/nodetail
/nopageheadings

Include "lrs53prtlae.inc"

sorted by l_stmt_lob
          l_loss_year 
          lrsdetail:claim_no
          lrsdetail:cause_of_loss 
          lrsdetail:cause_loss_subline 

Include "lrs53clmlae.inc"

top of page
trun(sfscompany:name[1])/center/newline 
"Report No.: LRSPR530"/left/newline 
"Report Report"/center/newline 
trun(str(l_starting_date,"MM/DD/YYYY") + " - " + str(l_ending_date,"MM/DD/YYYY"))/center/newline

top of l_stmt_lob
sfsstmt:stmt_lob/noheading 
sfsstmt:description/noheading/newline

top of l_loss_year
l_loss_year/heading="Date of Loss Year"/newline
                    
end of l_stmt_lob                    
""/newline
"Total for Statement Line"/column=15/newline
total[l_curr_alae_adj_exp,l_stmt_lob]/noheading/align=l_curr_alae_adj_exp
total[l_curr_ulae_adj_exp,l_stmt_lob]/noheading/align=l_curr_ulae_adj_exp
total[l_curr_alae_adj_resv,l_stmt_lob]/noheading/align=l_curr_alae_adj_resv
total[l_curr_ulae_adj_resv,l_stmt_lob]/noheading/align=l_curr_ulae_adj_resv
total[l_prior_alae_adj_resv,l_stmt_lob]/noheading/align=l_prior_alae_adj_resv
total[l_prior_ulae_adj_resv,l_stmt_lob]/noheading/align=l_prior_ulae_adj_resv
total[l_incurred_alae_lae,l_stmt_lob]/align=l_incurred_alae_lae/noheading
total[l_incurred_ulae_lae,l_stmt_lob]/align=l_incurred_ulae_lae/noheading
total[l_incurred_lae,l_stmt_lob]/align=l_incurred_lae/noheading 

end of l_loss_year 
""/newline
"Total for Loss Year"/column=15
total[l_curr_alae_adj_exp,l_loss_year]/noheading/align=l_curr_alae_adj_exp
total[l_curr_ulae_adj_exp,l_loss_year]/noheading/align=l_curr_ulae_adj_exp
total[l_curr_alae_adj_resv,l_loss_year]/noheading/align=l_curr_alae_adj_resv
total[l_curr_ulae_adj_resv,l_loss_year]/noheading/align=l_curr_ulae_adj_resv
total[l_prior_alae_adj_resv,l_loss_year]/noheading/align=l_prior_alae_adj_resv
total[l_prior_ulae_adj_resv,l_loss_year]/noheading/align=l_prior_ulae_adj_resv
total[l_incurred_alae_lae,l_loss_year]/align=l_incurred_alae_lae/noheading
total[l_incurred_ulae_lae,l_loss_year]/align=l_incurred_ulae_lae/noheading
total[l_incurred_lae,l_loss_year]/align=l_incurred_lae/noheading   

end of report
""/newline
"Report Totals"/column=35
total[l_curr_alae_adj_exp]/noheading/align=l_curr_alae_adj_exp
total[l_curr_ulae_adj_exp]/noheading/align=l_curr_ulae_adj_exp
total[l_curr_alae_adj_resv]/noheading/align=l_curr_alae_adj_resv
total[l_curr_ulae_adj_resv]/noheading/align=l_curr_ulae_adj_resv
total[l_prior_alae_adj_resv]/noheading/align=l_prior_alae_adj_resv
total[l_prior_ulae_adj_resv]/noheading/align=l_prior_ulae_adj_resv
total[l_incurred_alae_lae]/align=l_incurred_alae_lae/noheading
total[l_incurred_ulae_lae]/align=l_incurred_ulae_lae/noheading
total[l_incurred_lae]/align=l_incurred_lae/noheading   


/*  END OF FILE */
