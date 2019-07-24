/*  LRSPR637

    Net Losses by Line of Business

    Date Written : December 29, 1992

    SCIPS.com */
                                       
description Losses By Line of Business - NET ;

define string l_prog_number="LRSPR637 - Rev 2.00"
                                        
define string l_claim_no = str(lrsdetail:claim_no) + trun(
sfsline_alias:claim_alpha)

/*  CQ DOES NOT USE LRS63CAL.INC DUE TO THE NEED TO REVERSE THE
    THE VALUE OF ANY REINSURANCE TRANSACTION TO GET CORRECT NET
    LOSS AMOUNTS */

define date l_starting_date=parameter/prompt="Enter Starting Date: "
            l_ending_date  =parameter/prompt="Enter Ending Date: "

define unsigned ascii number
     l_trans=switch(lrsdetail:trans_type)
     case 1         : 1
     default        : 2

define signed ascii number l_multiplier[1]=switch(l_trans)
        case 1          :  1
        case 2          : -1

define signed ascii l_prior_resv[10]= if
    lrsdetail:trans_date < l_starting_date then
    lrsdetail:loss_resv * l_multiplier

define signed ascii l_prior_adj_resv[10]=if
    lrsdetail:trans_date < l_starting_date then
    lrsdetail:lae_resv * l_multiplier

define signed ascii l_curr_resv[10]= if
    lrsdetail:trans_date <= l_ending_date then
    lrsdetail:loss_resv * l_multiplier

define signed ascii l_curr_adj_resv[10]=if
    lrsdetail:trans_date <= l_ending_date then
    lrsdetail:lae_resv * l_multiplier

define signed ascii number l_loss_paid[10]=if
    lrsdetail:trans_date => l_starting_date and
    lrsdetail:trans_date <= l_ending_date then
    lrsdetail:loss_paid * l_multiplier/dec=2

define signed ascii number l_curr_adj_exp[10]=if
    lrsdetail:trans_date => l_starting_date and
    lrsdetail:trans_date <= l_ending_date then
    lrsdetail:lae_paid * l_multiplier/dec=2

define signed ascii number l_prior_resv_total[10]=
    l_prior_resv

define signed ascii number l_incurred[10]=
    l_curr_resv + l_loss_paid - l_prior_resv_total

define signed ascii number l_incurred_lae[10]=
    l_curr_adj_resv + l_curr_adj_exp - l_prior_adj_resv

define signed ascii number l_incurred_total[10]=
    l_incurred + l_incurred_lae

include "lrscollect.inc"
and   lrsdetail:trans_date <= l_ending_date

list
/nobanner
/domain="lrsdetail"
/title="Losses By Line of Business -NET"
/pagewidth=220
/duplicates
/nodetail
/nopageheadings

Include "lrs63prt.inc"

sorted by sfsline:stmt_lob/newline 
          lrsdetail:line_of_business 
          lrsdetail:claim_no

Include "rpttopfw.inc"
""/newline

top of sfsline:stmt_lob
sfsline:stmt_lob/noheading
sfsstmt:description/noheading/newline
"------------------------------"

end of sfsline:stmt_lob
""/newline
"TOTAL FOR STATEMENT LINE"/column=20
total[l_loss_paid,sfsline:stmt_lob]/noheading/align=l_loss_paid
total[l_curr_adj_exp,sfsline:stmt_lob]/noheading/align=l_curr_adj_exp
total[l_curr_resv,sfsline:stmt_lob]/noheading/align=l_curr_resv
total[l_curr_adj_resv,sfsline:stmt_lob]/noheading/align=l_curr_adj_resv
total[l_prior_resv,sfsline:stmt_lob]/noheading/align=l_prior_resv
total[l_prior_adj_resv,sfsline:stmt_lob]/noheading/align=l_prior_adj_resv
total[l_incurred,sfsline:stmt_lob]/align=l_incurred
total[l_incurred_lae,sfsline:stmt_lob]/align=l_incurred_lae/noheading
total[l_incurred_total,sfsline:stmt_lob]/align=l_incurred_total/noheading

end of lrsdetail:line_of_business
str(lrsdetail:line_of_business) + " " + lrsdetail:lob_subline/column=1/noheading
sfsline:description/noheading
total[l_loss_paid,lrsdetail:line_of_business]/noheading/align=l_loss_paid
total[l_curr_adj_exp,lrsdetail:line_of_business]/noheading/align=l_curr_adj_exp
total[l_curr_resv,lrsdetail:line_of_business]/noheading/align=l_curr_resv
total[l_curr_adj_resv,lrsdetail:line_of_business]/noheading/align=l_curr_adj_resv
total[l_prior_resv,lrsdetail:line_of_business]/noheading/align=l_prior_resv
total[l_prior_adj_resv,lrsdetail:line_of_business]/noheading/align=l_prior_adj_resv
total[l_incurred,lrsdetail:line_of_business]/align=l_incurred
total[l_incurred_lae,lrsdetail:line_of_business]/align=l_incurred_lae/noheading
total[l_incurred_total,lrsdetail:line_of_business]/align=l_incurred_total/noheading
;

/*  END OF FILE */
