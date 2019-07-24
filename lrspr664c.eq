/*  LRSPR664c

    Losses by Claim Number - Ceded 

    Date Written : October 29, 2003

    SCIPS.com, Inc. */

description Outstanding Loss and LAE - Net;

Define String l_prog_number = "LRSPR664c - Rev 4.10"

Include "lrs63cal.inc"

include "lrscollect.inc"
and   lrsdetail:trans_date <= l_ending_date
and trans_code >= 50

list
/nobanner
/domain="lrsdetail"
/title="Outstanding Losses By Annual Statement Line (Ceded)"
/pagewidth=255
/duplicates 
/nodetail                   
/nototals
/noreporttotals  

Include "lrs664prt.inc"

sorted by sfsline:stmt_lob /newlines 
          lrsdetail:line_of_business 

top of sfsline:stmt_lob 
sfsline:stmt_lob/noheading/column=1
sfsstmt:description/column=6/noheading /newline
"================================================" 

end of sfsline:stmt_lob 
""/newline     
"Total for Statement"/column=15
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
lrsdetail:line_of_business/column=5/noheading
sfsline_heading:description/mask="X(25)"/noheading/column=11
total[l_loss_paid,     lrsdetail:line_of_business]/noheading/align=l_loss_paid
total[l_curr_adj_exp,  lrsdetail:line_of_business]/noheading/align=l_curr_adj_exp
total[l_curr_resv,     lrsdetail:line_of_business]/noheading/align=l_curr_resv
total[l_curr_adj_resv, lrsdetail:line_of_business]/noheading/align=l_curr_adj_resv
total[l_prior_resv,    lrsdetail:line_of_business]/noheading/align=l_prior_resv
total[l_prior_adj_resv,lrsdetail:line_of_business]/noheading/align=l_prior_adj_resv
total[l_incurred,      lrsdetail:line_of_business]/align=l_incurred
total[l_incurred_lae,  lrsdetail:line_of_business]/align=l_incurred_lae/noheading
total[l_incurred_total,lrsdetail:line_of_business]/align=l_incurred_total/noheading  


end of report
""/newline
"REPORT TOTAL"/noheading/column=10
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
