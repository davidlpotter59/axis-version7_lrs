/*  LRSPR900

    Schedule P - Part 1 - Summary (losses by reported date / date of loss) - Direct

    Date Written : November 3, 2003

    SCIPS.com, Inc. */

description Losses by Reported Date and Date of Loss (Schedule P - Part 1 - Summary) - Direct;

define string l_type = if
lrsdetail:reins_co = 0 then "Direct"
else
"Treaty " + str(lrsdetail:reins_co)
             
define string l_claim_no = str(lrsdetail:claim_no) + trun(sfsline_alias:claim_alpha
)

Define String l_prog_number = "LRSPR900 - Rev 4.00"
                           
define unsigned ascii number l_report_year[4]=year(lrssetup:reported_date)
define unsigned ascii number l_loss_year[4]=year(lrssetup:loss_date)

Include "lrs63cal.inc"

include "lrscollect.inc"
and   lrsdetail:trans_date <= l_ending_date  
and   lrsdetail:trans_code < 30

list
/nobanner
/domain="lrsdetail"
--/title="Schedule P - Part 1 - Summary - Direct Losses"
/pagewidth=255
/duplicates 
/nodetail                   
/nototals 
/wks

Include "lrs634prt_small.inc"


sorted by l_report_year/newlines 
          l_loss_year

 
top of l_report_year 
l_report_year/mask="9999"/heading="Reported Date"

end of l_report_year 
""/newline 
"Reported Year Total"
total[l_loss_paid,       l_report_year]/noheading/align=l_loss_paid
total[l_curr_adj_exp,    l_report_year]/noheading/align=l_curr_adj_exp
total[l_curr_resv,       l_report_year]/noheading/align=l_curr_resv
total[l_curr_adj_resv,   l_report_year]/noheading/align=l_curr_adj_resv
total[l_prior_resv,      l_report_year]/noheading/align=l_prior_resv
total[l_prior_adj_resv,  l_report_year]/noheading/align=l_prior_adj_resv
total[l_incurred,        l_report_year]/align=l_incurred/noheading 
total[l_incurred_lae,    l_report_year]/align=l_incurred_lae/noheading
total[l_incurred_total,  l_report_year]/align=l_incurred_total/noheading  


end of l_loss_year 
l_loss_year/mask="9999"/heading="Date of Loss Year"/column=20
total[l_loss_paid,       l_loss_year]/noheading/align=l_loss_paid
total[l_curr_adj_exp,    l_loss_year]/noheading/align=l_curr_adj_exp
total[l_curr_resv,       l_loss_year]/noheading/align=l_curr_resv
total[l_curr_adj_resv,   l_loss_year]/noheading/align=l_curr_adj_resv
total[l_prior_resv,      l_loss_year]/noheading/align=l_prior_resv
total[l_prior_adj_resv,  l_loss_year]/noheading/align=l_prior_adj_resv
total[l_incurred,        l_loss_year]/align=l_incurred
total[l_incurred_lae,    l_loss_year]/align=l_incurred_lae/noheading
total[l_incurred_total,  l_loss_year]/align=l_incurred_total/noheading  

end of report
""/newline
"Report Total"/noheading/column=50
total[l_loss_paid]/noheading/align=l_loss_paid
total[l_curr_adj_exp]/noheading/align=l_curr_adj_exp
total[l_curr_resv]/noheading/align=l_curr_resv
total[l_curr_adj_resv]/noheading/align=l_curr_adj_resv
total[l_prior_resv]/noheading/align=l_prior_resv
total[l_prior_adj_resv]/noheading/align=l_prior_adj_resv
total[l_incurred]/align=l_incurred
total[l_incurred_lae]/align=l_incurred_lae/noheading
total[l_incurred_total]/align=l_incurred_total/noheading
