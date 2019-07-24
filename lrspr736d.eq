/*  LRSPR736d

    Losses By Line Of Business - Direct

    Date Written : January 21, 2005

    SCIPS.com */

description 
Losses by Date of Loss, Statement Line of Business, Company Line of Business - Direct;

define string l_prog_number="LRSPR736D - Rev 4.00"

define string l_claim_no = str(lrsdetail:claim_no) + trun(
sfsline_alias:claim_alpha)

define unsigned ascii number l_loss_year=year(lrssetup:loss_date) 

Include "lrs63calrein.inc"

include "lrscollect.inc" 
      and
      (lrsdetail:trans_date <= l_ending_date and
      lrsdetail:trans_code <= 30)

list
/nobanner
/domain="lrsdetail"
/title="Losses by Date of Loss, Statement Line of Business - DIRECT"
/pagewidth=220
/pagelength=0
/duplicates
/nodetail
/nopageheadings 
/xls="lrspr736d" 

Include "lrs63prta.inc"

sorted by l_loss_year /newlines 
          sfsline:stmt_lob/newline 
          lrsdetail:line_of_business 
          lrssetup:lob_subline 
          lrsdetail:claim_no

Include "rpttopfw.inc"
""/newline

top of l_loss_year 
""/newline 
l_loss_year /heading="Loss Year "

top of sfsline:stmt_lob
sfsline:stmt_lob/noheading
sfsstmt:description/noheading/newline

end of l_loss_year 
box/noheadings 
""/newline
"TOTAL FOR LOSS YEAR"/column=20
    total[l_loss_paid]/column=100
    total[l_curr_adj_exp]/column=115
    total[l_curr_resv]/column=130
    total[l_curr_adj_resv]/column=145
    total[l_prior_resv]/column=160
    total[l_prior_adj_resv]/column=175
    total[l_incurred]/column=190 
    total[l_incurred_lae]/column=205
    total[l_incurred_total]/column=220
end box 

end of sfsline:stmt_lob
box/noheadings 
""/newline
"TOTAL FOR STATEMENT LINE"/column=20
    total[l_loss_paid]/column=100
    total[l_curr_adj_exp]/column=115
    total[l_curr_resv]/column=130
    total[l_curr_adj_resv]/column=145
    total[l_prior_resv]/column=160
    total[l_prior_adj_resv]/column=175
    total[l_incurred]/column=190 
    total[l_incurred_lae]/column=205
    total[l_incurred_total]/column=220
end box 

top of lrsdetail:line_of_business 
box/noheadings 
    lrsdetail:line_of_business /column=1
    sfsline_heading:description
end box 

end of lrsdetail:line_of_business
box/noheadings 
""/newline 
"TOTAL FOR LINE of BUSINESS"/column=5
    total[l_loss_paid]/column=100
    total[l_curr_adj_exp]/column=115
    total[l_curr_resv]/column=130
    total[l_curr_adj_resv]/column=145
    total[l_prior_resv]/column=160
    total[l_prior_adj_resv]/column=175
    total[l_incurred]/column=190 
    total[l_incurred_lae]/column=205
    total[l_incurred_total]/column=220
end box 

end of lrssetup:lob_subline 
box/noheadings 
lrssetup:lob_subline/column=10/noheading
sfsline:description/noheading/column=15
    total[l_loss_paid]/column=100
    total[l_curr_adj_exp]/column=115
    total[l_curr_resv]/column=130
    total[l_curr_adj_resv]/column=145
    total[l_prior_resv]/column=160
    total[l_prior_adj_resv]/column=175
    total[l_incurred]/column=190 
    total[l_incurred_lae]/column=205
    total[l_incurred_total]/column=220
end box 
/*  END OF FILE */
