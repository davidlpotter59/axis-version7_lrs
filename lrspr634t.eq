/*  LRSPR634

    Ceded Losses by Claim Number 

    Date Written : February 8, 2003

    SCIPS.com, Inc. */

description Ceded (Facultative and Treaty) Losses by Claim Number - Detail - By date of loss ;

define string l_type = if
lrsdetail:reins_co = 0 then "Direct"
else
"Treaty " + str(lrsdetail:reins_co)
             
define string l_claim_no = str(lrsdetail:claim_no) + trun(sfsline_alias:claim_alpha
)

Define String l_prog_number = "LRSPR634T - Rev 4.10"

define unsigned ascii number l_loss_year[4]=year(lrssetup:loss_date)

Include "lrs63cal.inc"

include "lrscollect.inc"
and   lrsdetail:trans_date <= l_ending_date
and   lrsdetail:trans_code => 50  

list
/nobanner
/domain="lrsdetail"
/title="Ceded Losses By Claim Number - By Date of Loss"
/pagewidth=280
/duplicates 
/nodetail                   
/nototals 

Include "lrs634aprt.inc"
lrsceded:surplus_percent /column=190
lrsceded:amount_subject /column=205

sorted by l_loss_year/newpage 
          lrsdetail:reins_co /newpage 
          lrsdetail:claim_no

end of l_loss_year 
""/newline 
"Loss Year Total"
total[l_loss_paid]/noheading/align=l_loss_paid/column=55
total[l_curr_adj_exp]/noheading/align=l_curr_adj_exp/column=70
total[l_curr_resv]/noheading/align=l_curr_resv/column=85
total[l_curr_adj_resv]/noheading/align=l_curr_adj_resv/column=100
total[l_prior_resv]/noheading/align=l_prior_resv/column=115
total[l_prior_adj_resv]/noheading/align=l_prior_adj_resv/column=130
total[l_incurred]/align=l_incurred/column=145
total[l_incurred_lae]/align=l_incurred_lae/noheading/column=160
total[l_incurred_total]/align=l_incurred_total/noheading/column=175

end of lrsdetail:reins_co 
""/newline 
"Treaty Total"
total[l_loss_paid]/noheading/align=l_loss_paid/column=55
total[l_curr_adj_exp]/noheading/align=l_curr_adj_exp/column=70
total[l_curr_resv]/noheading/align=l_curr_resv/column=85
total[l_curr_adj_resv]/noheading/align=l_curr_adj_resv/column=100
total[l_prior_resv]/noheading/align=l_prior_resv/column=115
total[l_prior_adj_resv]/noheading/align=l_prior_adj_resv/column=130
total[l_incurred]/align=l_incurred/column=145
total[l_incurred_lae]/align=l_incurred_lae/noheading/column=160
total[l_incurred_total]/align=l_incurred_total/noheading/column=175

end of lrsdetail:claim_no 
box/noheadings 
l_claim_no/noheading
lrssetup:policy_no/column=13/noheading 
str(lrsdetail:cause_of_loss)/column=24
lrsdetail:cause_loss_subline/noheading/column=29
lrssetup:loss_date/noheading/column=35
str(lrsdetail:Line_of_business)/column=45
lrsdetail:lob_subline/noheading  /column=48
total[l_loss_paid]/noheading/align=l_loss_paid/column=55
total[l_curr_adj_exp]/noheading/align=l_curr_adj_exp/column=70
total[l_curr_resv]/noheading/align=l_curr_resv/column=85
total[l_curr_adj_resv]/noheading/align=l_curr_adj_resv/column=100
total[l_prior_resv]/noheading/align=l_prior_resv/column=115
total[l_prior_adj_resv]/noheading/align=l_prior_adj_resv/column=130
total[l_incurred]/align=l_incurred/column=145
total[l_incurred_lae]/align=l_incurred_lae/noheading/column=160
total[l_incurred_total]/align=l_incurred_total/noheading/column=175
if lrsceded:surplus_percent <> 0.000 then 
{
    lrsceded:surplus_percent /column=190/noheading 
    lrsceded:amount_subject /column=205/noheading 
}
end box 

end of report
""/newline
"Report Total"/noheading/column=70
total[l_loss_paid]/noheading/align=l_loss_paid/column=55
total[l_curr_adj_exp]/noheading/align=l_curr_adj_exp/column=70
total[l_curr_resv]/noheading/align=l_curr_resv/column=85
total[l_curr_adj_resv]/noheading/align=l_curr_adj_resv/column=100
total[l_prior_resv]/noheading/align=l_prior_resv/column=115
total[l_prior_adj_resv]/noheading/align=l_prior_adj_resv/column=130
total[l_incurred]/align=l_incurred/column=145
total[l_incurred_lae]/align=l_incurred_lae/noheading/column=160
total[l_incurred_total]/align=l_incurred_total/noheading/column=175

Include "reporttop.inc" 
""/newline
"Date of Loss Year"/left
str(l_loss_year,"9999")/noheading/column=20/newline 
lrsdetail:reins_co/heading="Treaty Number"/newline
