/*  LRSPR86D

    Subrogation Breakout - Detail

    sorted by property, liability and incurred year 

    Date Written : January 13, 1995 

    SCIPS.com, Inc. */

description 
Subrogation and Salvage - sorted by property, liability and incurred year;

define string l_prog_number="LRSPR866"

/*  CQ DOES NOT USE LRS63CAL.INC DUE TO THE NEED TO REVERSE THE
    THE VALUE OF ANY REINSURANCE TRANSACTION TO GET CORRECT NET
    LOSS AMOUNTS */

define string l_claim_no = str(lrsdetail:claim_no) + trun(sfsline_alias:claim_alpha
)

include "startend.inc"

define unsigned ascii number l_incurred_year[4] = year(lrssetup:loss_date)
                             l_reported_year[4] = year(lrssetup:reported_date)

define unsigned ascii number
     l_trans=switch(lrsdetail:trans_type)
     case 1         : 1
     default        : 2

define signed ascii number l_multiplier[1]=switch(l_trans)
        case 1          :   1
        case 2          :  -1

define string
        l_trans_description=switch(l_trans)
        case 1          : "Direct"
        case 2          : "Ceded"

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

define signed ascii l_prior_resv_1[10]= if
    lrsdetail:trans_date < l_starting_date then
    lrsdetail:loss_resv 

define signed ascii l_prior_adj_resv_1[10]=if
    lrsdetail:trans_date < l_starting_date then
    lrsdetail:lae_resv 

define signed ascii l_curr_resv_1[10]= if
    lrsdetail:trans_date <= l_ending_date then
    lrsdetail:loss_resv 

define signed ascii l_curr_adj_resv_1[10]=if
    lrsdetail:trans_date <= l_ending_date then
    lrsdetail:lae_resv 

define signed ascii number l_loss_paid_1[10]=if
    lrsdetail:trans_date => l_starting_date and
    lrsdetail:trans_date <= l_ending_date then
    lrsdetail:loss_paid /dec=2

define signed ascii number l_curr_adj_exp_1[10]=if
    lrsdetail:trans_date => l_starting_date and
    lrsdetail:trans_date <= l_ending_date then
    lrsdetail:lae_paid /dec=2

define signed ascii number l_prior_resv_total_1[10]=
    l_prior_resv

define signed ascii number l_incurred_1[10]=
    l_curr_resv + l_loss_paid - l_prior_resv_total

define signed ascii number l_incurred_lae_1[10]=
    l_curr_adj_resv + l_curr_adj_exp - l_prior_adj_resv

define signed ascii number l_incurred_total_1[10]=
    l_incurred + l_incurred_lae

where lrsdetail:trans_date <= l_ending_date and 
    /*  (lrssetup:subro_sal = "Y" or */
       ((lrsdetail:trans_code = 15 or 
       ((lrsdetail:trans_code = 16 or
        lrsdetail:trans_code = 17) and
        lrsdetail:loss_resv < 0))) or
       ((lrsdetail:trans_code = 55 or 
       ((lrsdetail:trans_code = 56 or
        lrsdetail:trans_code = 57) and
        lrsdetail:loss_resv < 0)))

list
/nobanner
/domain="lrsdetail"
/title="Subrogation and Salvage - Sorted by Property, Liability and Incurred Year"
/pagewidth=220
/duplicates
              
Include "lrs63prt.inc"

sorted by sfsline_alias:stmt_lob/newline
                  l_incurred_year/newline
                  l_reported_year
                  l_trans

Include "rpttopfw.inc"
""/newline

top of sfsline_alias:stmt_lob
sfsline_alias:stmt_lob/noheading
sfsline_alias:description/noheading/newline
"------------------------------"

end of sfsline_alias:stmt_lob
""/newline
"TOTAL FOR STATEMENT LINE"
total[l_loss_paid,sfsline_alias:stmt_lob]/noheading/align=l_loss_paid
total[l_curr_adj_exp,sfsline_alias:stmt_lob]/noheading/align=l_curr_adj_exp
total[l_curr_resv,sfsline_alias:stmt_lob]/noheading/align=l_curr_resv
total[l_curr_adj_resv,sfsline_alias:stmt_lob]/noheading/align=l_curr_adj_resv
total[l_prior_resv,sfsline_alias:stmt_lob]/noheading/align=l_prior_resv
total[l_prior_adj_resv,sfsline_alias:stmt_lob]/noheading/align=l_prior_adj_resv
total[l_incurred,sfsline_alias:stmt_lob]/align=l_incurred
total[l_incurred_lae,sfsline_alias:stmt_lob]/align=l_incurred_lae/noheading
total[l_incurred_total,sfsline_alias:stmt_lob]/align=l_incurred_total/noheading
/* mod 101 incurred year */

end of l_incurred_year
""/newline
"Total for Incurred Date:"
l_incurred_year/noheading/mask="9999"
total[l_loss_paid,l_incurred_year]/noheading/align=l_loss_paid
total[l_curr_adj_exp,l_incurred_year]/noheading/align=l_curr_adj_exp
total[l_curr_resv,l_incurred_year]/noheading/align=l_curr_resv
total[l_curr_adj_resv,l_incurred_year]/noheading/align=l_curr_adj_resv
total[l_prior_resv,l_incurred_year]/noheading/align=l_prior_resv
total[l_prior_adj_resv,l_incurred_year]/noheading/align=l_prior_adj_resv
total[l_incurred,l_incurred_year]/align=l_incurred
total[l_incurred_lae,l_incurred_year]/align=l_incurred_lae/noheading
total[l_incurred_total,l_incurred_year]/align=l_incurred_total/noheading

top of l_incurred_year
"Incurred in:"
l_incurred_year/noheading/mask="9999"

top of l_reported_year
""/newline
"Reported in:"
l_reported_year/noheading/mask="9999"/newline

end of l_reported_year
"Total for Reported Date:"
l_reported_year/noheading/mask="9999"
total[l_loss_paid,l_reported_year]/noheading/align=l_loss_paid
total[l_curr_adj_exp,l_reported_year]/noheading/align=l_curr_adj_exp
total[l_curr_resv,l_reported_year]/noheading/align=l_curr_resv
total[l_curr_adj_resv,l_reported_year]/noheading/align=l_curr_adj_resv
total[l_prior_resv,l_reported_year]/noheading/align=l_prior_resv
total[l_prior_adj_resv,l_reported_year]/noheading/align=l_prior_adj_resv
total[l_incurred,l_reported_year]/align=l_incurred
total[l_incurred_lae,l_reported_year]/align=l_incurred_lae/noheading
total[l_incurred_total,l_reported_year]/align=l_incurred_total/noheading

end of l_trans
""/newline
l_trans_description/noheading
total[l_loss_paid_1,l_trans]/noheading/align=l_loss_paid
total[l_curr_adj_exp_1,l_trans]/noheading/align=l_curr_adj_exp
total[l_curr_resv_1,l_trans]/noheading/align=l_curr_resv
total[l_curr_adj_resv_1,l_trans]/noheading/align=l_curr_adj_resv
total[l_prior_resv_1,l_trans]/noheading/align=l_prior_resv
total[l_prior_adj_resv_1,l_trans]/noheading/align=l_prior_adj_resv
total[l_incurred_1,l_trans]/align=l_incurred
total[l_incurred_lae_1,l_trans]/align=l_incurred_lae/noheading
total[l_incurred_total_1,l_trans]/align=l_incurred_total/noheading/newline

;

/*  END OF FILE */
