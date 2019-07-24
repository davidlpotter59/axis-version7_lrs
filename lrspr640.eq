/*  LRSPR640

    Losses by Line Of Business, Claim Number - DIRECT

    Date Written : April 7, 2008

    SCIPS.com */

description 
Direct Incurred Losses by Line of Business and Claim Number ;

define string l_prog_number="LRSPR633 - Rev 7.20"

define unsigned ascii number l_stmt_lob = sfsline:stmt_lob

define string l_claim_no = str(lrsdetail:claim_no) + trun(
sfsline_alias:claim_alpha)

Include "lrs63cal.inc"

include "lrscollect.inc"
and   lrsdetail:trans_date <= l_ending_date and
      lrsdetail:trans_code < 30

list
/nobanner
/domain="lrsdetail"
/title="Direct Incurred Losses By Line and Claim Number"
/pagewidth=220
/duplicates
/nodetail
/nopageheadings 

Include "lrs63prt.inc"

sorted by sfsline:stmt_lob/newline 
          lrsdetail:line_of_business 
          lrsdetail:claim_no

include "reporttop.inc"
""/newline
sfsstate:description/noheading
""/newline

top of sfsline:stmt_lob
sfsline:stmt_lob/noheading
sfsstmt:description/noheading/newline
"------------------------------"

end of lrsdetail:claim_no 
box/noheadings 
if total[l_loss_paid] <> 0 or 
   total[l_curr_adj_exp] <> 0 or 
   total[l_curr_adj_resv] <> 0 or
   total[l_prior_resv] <> 0 or
   total[l_prior_adj_resv] <> 0 or
   total[l_incurred] <> 0 or
   total[l_incurred_lae] <> 0 or
   total[l_incurred_total] <> 0 then
    box/noblanklines/noheading
    l_claim_no/column=1/mask="X(15)"
    lrssetup:policy_no/column=13
    str(lrsdetail:cause_of_loss) + " " + lrsdetail:cause_loss_subline/column=25
    lrssetup:loss_date/column=40

    total[l_loss_paid]/noheading/align=l_loss_paid
    total[l_curr_adj_exp]/noheading/align=l_curr_adj_exp
    total[l_curr_resv]/noheading/align=l_curr_resv
    total[l_curr_adj_resv]/noheading/align=l_curr_adj_resv
    total[l_prior_resv]/noheading/align=l_prior_resv
    total[l_prior_adj_resv]/noheading/align=l_prior_adj_resv
    total[l_incurred]/align=l_incurred
    total[l_incurred_lae]/align=l_incurred_lae/noheading
    total[l_incurred_total]/align=l_incurred_total/noheading
    end box

end box

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

/*
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
*/
