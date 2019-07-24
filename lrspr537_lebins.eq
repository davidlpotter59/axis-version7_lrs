/*  LRSPR537_lebins

    Liability Losses by Claim Number - Direct

    Date Written : October 5, 1993
                   October 31, 2000 -- created from lrspr531

    SCIPS.com, Inc

Modified By     Date                  Description
   DLP          09/05/2000          added standard report heading
*/

description 
Direct Liability and Property Losses by Claim Number ;

Define String l_prog_number = "LRSPR537_lebins - Rev 4.10"
         
define string l_claim_no = str(lrsdetail:claim_no) + trun(sfsline_alias:claim_alpha
)

define string l_type = switch(sfscause1:line_type)
case "P" : "Property Claims"
default  : "Liability Claims"

include "startend.inc"

define string
        l_status[16] = switch(lrssetup:status)
        case "O"                : " ** OPEN **     "
        case "R"                : " ** REOPENED ** "
        case "C"                : " ** CLOSED **   "

define unsigned ascii number l_liab[1]=switch(sfscause1:line_type)
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
    lrsdetail:trans_date <= l_ending_date then 
    lrsdetail:loss_paid/dec=2

define signed ascii number l_curr_adj_exp[10]=if
    lrsdetail:trans_date => l_starting_date and
    lrsdetail:trans_date <= l_ending_date then 
    lrsdetail:lae_paid/dec=2

define signed ascii number l_prior_resv_total[10]= l_prior_resv

define signed ascii number l_incurred[10]=  l_curr_resv + l_loss_paid - l_prior_resv_total

define signed ascii number l_incurred_lae[10]=  l_curr_adj_resv + l_curr_adj_exp - l_prior_adj_resv

define signed ascii number l_incurred_total[10]=  l_incurred + l_incurred_lae

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
/noreporttotals

box/duplicates 
l_claim_no/heading="Claim-No"/column=1
lrssetup:policy_no/heading="Policy-No"/column=11
lrssetup:agent_no/heading="Agent-No"/column=21/duplicates 
lrssetup:eff_date/heading="Effective-Date"/column=26/duplicates 
lrsdetail:cause_of_loss/heading="Cause"/column=37/duplicates 
lrsdetail:cause_loss_subline/noheading/column=41
lrssetup:loss_date/heading="Loss-Date"/column=45
lrsdetail:line_of_business/heading="LOB-Subline"/column=57 
lrsdetail:lob_subline/noheading/column=61
l_status/heading="Open/Closed"/width=12/column=64
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

sorted by   sfscause1:line_type/newpage  
            lrsdetail:claim_no
            lrsdetail:cause_of_loss
            lrsdetail:cause_loss_subline

end of lrsdetail:cause_loss_subline 
l_claim_no/noheading
lrssetup:policy_no/noheading/column=11
lrssetup:agent_no/noheading/column=21
lrssetup:eff_date/noheading/column=26
lrsdetail:cause_of_loss/noheading/column=37
lrsdetail:cause_loss_subline/noheading/column=41
lrssetup:loss_date/noheading/column=45
lrsdetail:line_of_business/noheading/column=57
lrsdetail:lob_subline/noheading/column=61
l_status/noheading/width=12/column=64
total[l_loss_paid]/noheading/align=l_loss_paid/column=80
total[l_curr_adj_exp]/noheading/align=l_curr_adj_exp/column=100
total[l_curr_resv]/noheading/align=l_curr_resv/column=120
total[l_curr_adj_resv]/noheading/align=l_curr_adj_resv/column=140
total[l_prior_resv]/noheading/align=l_prior_resv/column=160
total[l_prior_adj_resv]/noheading/align=l_prior_adj_resv/column=180
total[l_incurred]/align=l_incurred/noheading/column=200
total[l_incurred_lae]/align=l_incurred_lae/noheading/column=220
total[l_incurred_total]/align=l_incurred_total/noheading/column=240

end of report
""/newline
total[l_loss_paid]/noheading/align=l_loss_paid/column=80
total[l_curr_adj_exp]/noheading/align=l_curr_adj_exp/column=100
total[l_curr_resv]/noheading/align=l_curr_resv/column=120
total[l_curr_adj_resv]/noheading/align=l_curr_adj_resv/column=140
total[l_prior_resv]/noheading/align=l_prior_resv/column=160
total[l_prior_adj_resv]/noheading/align=l_prior_adj_resv/column=180
total[l_incurred]/align=l_incurred/noheading/column=200
total[l_incurred_lae]/align=l_incurred_lae/noheading/column=220
total[l_incurred_total]/align=l_incurred_total/noheading/column=240

/*end of sfscause1:line_type 
""/newline 
"Total for Type " + sfscause1:line_type/column=20
total[l_loss_paid]/noheading/align=l_loss_paid
total[l_curr_adj_exp]/noheading/align=l_curr_adj_exp
total[l_curr_resv]/noheading/align=l_curr_resv
total[l_curr_adj_resv]/noheading/align=l_curr_adj_resv
total[l_prior_resv]/noheading/align=l_prior_resv
total[l_prior_adj_resv]/noheading/align=l_prior_adj_resv
total[l_incurred]/align=l_incurred/noheading
total[l_incurred_lae]/align=l_incurred_lae/noheading
total[l_incurred_total]/align=l_incurred_total/noheading   */

Include "reporttop.inc"
""/newline
l_type/heading="Cause Type"/column=1
