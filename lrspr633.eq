/*  LRSPR633

    Losses by State and Line Of Business - DIRECT

    Date Written : November 7, 1992

    SCIPS.com */

description Losses by State and Line of Business - Direct ;

define string l_prog_number="LRSPR633 - Rev 2.00"
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
/title="Losses By State and Line - DIRECT"
/pagewidth=220
/duplicates
/nodetail
/nopageheadings 

Include "lrs63prt.inc"

sorted by lrssetup:state/newpage 
          sfsline:stmt_lob/newline 
          lrsdetail:line_of_business 
          lrsdetail:claim_no

Include "rpttopfw.inc"
""/newline
sfsstate:description/noheading
""/newline

top of sfsline:stmt_lob
sfsline:stmt_lob/noheading
sfsstmt:description/noheading/newline
"------------------------------"

end of lrssetup:state
""/newline
"TOTAL FOR STATE: "
sfsstate:description/noheading
total[l_loss_paid,lrssetup:state]/noheading/align=l_loss_paid
total[l_curr_adj_exp,lrssetup:state]/noheading/align=l_curr_adj_exp
total[l_curr_resv,lrssetup:state]/noheading/align=l_curr_resv
total[l_curr_adj_resv,lrssetup:state]/noheading/align=l_curr_adj_resv
total[l_prior_resv,lrssetup:state]/noheading/align=l_prior_resv
total[l_prior_adj_resv,lrssetup:state]/noheading/align=l_prior_adj_resv
total[l_incurred,lrssetup:state]/align=l_incurred
total[l_incurred_lae,lrssetup:state]/align=l_incurred_lae/noheading
total[l_incurred_total,lrssetup:state]/align=l_incurred_total/noheading

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
