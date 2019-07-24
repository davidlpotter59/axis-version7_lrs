/*  LRSPR634k

    Average Daily Net Loss Incurred

    Date Written : February 8, 2003

    SCIPS.com, Inc. */

description Average Daily Net Loss Incurred - Enter a 'number of days parameter' to obtain the days to calculate on ;

define unsigned ascii number l_type = if
lrsdetail:trans_code < 30 then 1
else 2
             
define string l_claim_no = str(lrsdetail:claim_no) + trun(sfsline_alias:claim_alpha
)

Define String l_prog_number = "LRSPR634K - Rev 4.00"

Include "lrs63cal.inc"
define unsigned ascii number l_work_days = parameter/prompt="Enter the Total Number of Work Days"

include "lrscollect.inc"
and   lrsdetail:trans_date <= l_ending_date

list
/nobanner
/domain="lrsdetail"
/title="Average Daily Net Loss Incurred"
/pagewidth=180
/nodetail                   
/nototals 

Include "lrs634prt_small.inc"

sorted by l_type 

top of l_type 
if l_type = 1 then 
{"D I R E C T"/column=10}
else      
{"C E D E D"/column=10}

end of l_type 
"Total Net Incurred for Type"/noheading/column=10
total[l_loss_paid,      l_type]/noheading/align=l_loss_paid
total[l_curr_adj_exp,   l_type]/noheading/align=l_curr_adj_exp
total[l_curr_resv,      l_type]/noheading/align=l_curr_resv
total[l_curr_adj_resv,  l_type]/noheading/align=l_curr_adj_resv
total[l_prior_resv,     l_type]/noheading/align=l_prior_resv
total[l_prior_adj_resv, l_type]/noheading/align=l_prior_adj_resv
total[l_incurred,       l_type]/align=l_incurred
total[l_incurred_lae,   l_type]/align=l_incurred_lae/noheading
total[l_incurred_total, l_type]/align=l_incurred_total/noheading/newline

"Daily Averages For Type"/noheading/column=10
(total[l_loss_paid,     l_type]) div l_work_days/noheading/align=l_loss_paid
(total[l_curr_adj_exp,  l_type]) div l_work_days/noheading/align=l_curr_adj_exp
(total[l_curr_resv,     l_type]) div l_work_days/noheading/align=l_curr_resv
(total[l_curr_adj_resv, l_type]) div l_work_days/noheading/align=l_curr_adj_resv
(total[l_prior_resv,    l_type]) div l_work_days/noheading/align=l_prior_resv
(total[l_prior_adj_resv,l_type]) div l_work_days/noheading/align=l_prior_adj_resv
(total[l_incurred,      l_type]) div l_work_days/align=l_incurred
(total[l_incurred_lae,  l_type]) div l_work_days/align=l_incurred_lae/noheading
(total[l_incurred_total,l_type]) div l_work_days/align=l_incurred_total/noheading/newline

end of report
""/newline
"Net Total Incurred"/noheading/column=10
total[l_loss_paid]/noheading/align=l_loss_paid
total[l_curr_adj_exp]/noheading/align=l_curr_adj_exp
total[l_curr_resv]/noheading/align=l_curr_resv
total[l_curr_adj_resv]/noheading/align=l_curr_adj_resv
total[l_prior_resv]/noheading/align=l_prior_resv
total[l_prior_adj_resv]/noheading/align=l_prior_adj_resv
total[l_incurred]/align=l_incurred
total[l_incurred_lae]/align=l_incurred_lae/noheading
total[l_incurred_total]/align=l_incurred_total/noheading/newline

"Net Daily Averages"/noheading/column=10
(total[l_loss_paid]) div l_work_days/noheading/align=l_loss_paid
(total[l_curr_adj_exp]) div l_work_days/noheading/align=l_curr_adj_exp
(total[l_curr_resv]) div l_work_days/noheading/align=l_curr_resv
(total[l_curr_adj_resv]) div l_work_days/noheading/align=l_curr_adj_resv
(total[l_prior_resv]) div l_work_days/noheading/align=l_prior_resv
(total[l_prior_adj_resv]) div l_work_days/noheading/align=l_prior_adj_resv
(total[l_incurred]) div l_work_days/align=l_incurred
(total[l_incurred_lae]) div l_work_days/align=l_incurred_lae/noheading
(total[l_incurred_total]) div l_work_days/align=l_incurred_total/noheading/newline
 
top of page
trun(sfscompany:name[1])/toggle/centre/newline
"Report Period"/centre/newline 
trun(str(l_starting_date,"MM/DD/YYYY") + " - " + str(l_ending_date,"MM/DD/YYYY"))/centre/newline  
trun("Total Work Days " + trun(str(l_work_days,"ZZZ")))/center/newline  
