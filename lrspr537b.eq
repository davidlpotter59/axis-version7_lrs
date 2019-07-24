/*  LRSPR537B

    Liability Losses by Claim Number - Direct

    Date Written : October 5, 1993
                   October 31, 2000 -- created from lrspr531

    SCIPS.com, Inc

Modified By     Date                  Description
   DLP          09/05/2000          added standard report heading
*/

description 
Direct Liability and Property Losses by Claim Number ;

Define String l_prog_number = "LRSPR537 - Rev 4.10"
         
define string l_claim_no = str(lrsdetail:claim_no) + trun(sfsline_alias:claim_alpha
)

define string l_type = switch(sfscause:line_type)
case "P" : "Property Claims"
default  : "Liability Claims"

include "startend.inc"

define string
        l_status[16] = switch(lrssetup:status)
        case "O"                : " ** OPEN **     "
        case "R"                : " ** REOPENED ** "
        case "C"                : " ** CLOSED **   "

define unsigned ascii number l_liab[1]=switch(sfscause:line_type)
        case "L" : 1
        default  : 0

define signed ascii l_prior_resv[10]= if 
    lrsdetail:trans_date < l_starting_date then 
        lrsdetail:loss_resv

define signed ascii l_prior_adj_resv[10]=if
    lrsdetail:trans_date < l_starting_date then
        lrsdetail:lae_resv

define signed ascii l_curr_resv[10]= if
    lrsdetail:trans_date <= l_ending_date then 
        lrsdetail:loss_resv

define signed ascii l_curr_adj_resv[10]=if
    lrsdetail:trans_date <= l_ending_date then 
        lrsdetail:lae_resv

define signed ascii number l_loss_paid[10]=if
    lrsdetail:trans_date => l_starting_date and
    lrsdetail:trans_date <= l_ending_date  then 
        lrsdetail:loss_paid/dec=2

define signed ascii number l_curr_adj_exp[10]=if
    lrsdetail:trans_date => l_starting_date and
    lrsdetail:trans_date <= l_ending_date then 
        lrsdetail:lae_paid/dec=2

define signed ascii number l_prior_resv_total[10]=l_prior_resv

define signed ascii number l_incurred[10]=l_curr_resv + l_loss_paid - l_prior_resv_total

define signed ascii number l_incurred_lae[10]=l_curr_adj_resv + l_curr_adj_exp - l_prior_adj_resv

define signed ascii number l_incurred_total[10]= l_incurred + l_incurred_lae

include "lrscollect.inc"
and lrsdetail:trans_date <= l_ending_date and
    lrsdetail:trans_code < 30 

list
/nobanner
/domain="lrsdetail"
/title="Direct Losses By Claim Number - Sorted by Property and Liability"
/pagewidth=250
/duplicates
/nodetail 

box/duplicates 
sfsline:stmt_lob/heading="STMT-LOB"/column=1
l_loss_paid/heading="Period-Losses-Paid"/width=15/column=80
l_curr_adj_exp/heading="Period-LAE-Paid"/width=15/column=100
l_curr_resv/heading="Current-Loss-Reserves"/width=15/column=120
l_curr_adj_resv/heading="Current-LAE Reserves"/width=15/column=140
l_prior_resv/heading="Prior-Loss-Reserves"/width=15/column=160
l_prior_adj_resv/heading="Prior-LAE Reserves"/width=15/column=180
l_incurred/heading="Current Period-Incurred Losses-Without LAE"/width=15/column=200
l_incurred_lae/heading="Current Period-Incurred LAE"/width=15/column=220
l_incurred_total/heading="Current Period-Net Losses &-LAE Incurred"/width=15/column=240
end box

sorted by   sfscause:line_type/newpage  
            sfsline:stmt_lob 

end of sfsline:stmt_lob 
sfsline:stmt_lob
total[l_loss_paid]/noheading/align=l_loss_paid/column=80
total[l_curr_adj_exp]/noheading/align=l_curr_adj_exp/column=100
total[l_curr_resv]/noheading/align=l_curr_resv/column=120
total[l_curr_adj_resv]/noheading/align=l_curr_adj_resv/column=140
total[l_prior_resv]/noheading/align=l_prior_resv/column=160
total[l_prior_adj_resv]/noheading/align=l_prior_adj_resv/column=180
total[l_incurred]/align=l_incurred/noheading/column=200
total[l_incurred_lae]/align=l_incurred_lae/noheading/column=220
total[l_incurred_total]/align=l_incurred_total/noheading/column=240

end of sfscause:line_type 
""/newline 
"Total for Type"/column=20
total[l_loss_paid]/noheading/align=l_loss_paid
total[l_curr_adj_exp]/noheading/align=l_curr_adj_exp
total[l_curr_resv]/noheading/align=l_curr_resv
total[l_curr_adj_resv]/noheading/align=l_curr_adj_resv
total[l_prior_resv]/noheading/align=l_prior_resv
total[l_prior_adj_resv]/noheading/align=l_prior_adj_resv
total[l_incurred]/align=l_incurred/noheading
total[l_incurred_lae]/align=l_incurred_lae/noheading
total[l_incurred_total]/align=l_incurred_total/noheading   

Include "reporttop.inc"
""/newline
l_type/heading="Cause Type"/column=1
