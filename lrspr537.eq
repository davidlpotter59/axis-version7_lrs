/*  LRSPR537

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

Include "lrs63calliab.inc"

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

Include "lrs53prt.inc"

sorted by   sfscause:line_type/newpage  
            lrsdetail:claim_no

Include "lrs53clm.inc"

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
