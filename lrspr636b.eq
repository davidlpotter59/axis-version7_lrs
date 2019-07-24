/*  LRSPR636B

    Losses by Line Of Business - DIRECT

    Date Written : January 16, 2004

    SCIPS.com */

description 
Direct Losses by Line of Business - Date of Loss - Annual Statement - Property and Liability Breakout;

define string l_prog_number="LRSPR636B - Rev 2.00"

define string l_claim_no = str(lrsdetail:claim_no) + trun(
sfsline_alias:claim_alpha)

define unsigned ascii number l_loss_year=year(lrssetup:loss_date)

define string l_type = switch(sfscause:line_type)
   case "L" : "L"
   default  : "P"
   
Include "lrs63cal.inc"

include "lrscollect.inc" 
and  (lrsdetail:trans_date <= l_ending_date and
      lrsdetail:trans_code < 30)

list
/nobanner
/domain="lrsdetail"
/title="Direct Losses By Line of Business - Date of Loss - Annual Statement"
/pagewidth=220
/duplicates
/nodetail
/nopageheadings 
/noreporttotals 

Include "lrs63prt.inc"

sorted by l_loss_year/newlines 
          sfsline:stmt_lob/newline 
          l_type 

top of page
trun(sfscompany:name[1])/center/newline 
"Report No.: LRSPR636"/left/newline 
"Report Period"/center/newline 
trun(str(l_starting_date,"MM/DD/YYYY") + " - " + str(l_ending_date,"MM/DD/YYYY"))/center/newline 

top of l_loss_year 
""/newline 
"Year "
l_loss_year/noheading/newline 

top of sfsline:stmt_lob
sfsline:stmt_lob/noheading
sfsstmt:description/noheading/newline
"------------------------------------------------------"

end of l_loss_year 
""/newline
"TOTAL FOR LOSS YEAR"/column=20
total[l_loss_paid]/noheading/align=l_loss_paid
total[l_curr_adj_exp]/noheading/align=l_curr_adj_exp
total[l_curr_resv]/noheading/align=l_curr_resv
total[l_curr_adj_resv]/noheading/align=l_curr_adj_resv
total[l_prior_resv]/noheading/align=l_prior_resv
total[l_prior_adj_resv]/noheading/align=l_prior_adj_resv
total[l_incurred]/align=l_incurred
total[l_incurred_lae]/align=l_incurred_lae/noheading
total[l_incurred_total]/align=l_incurred_total/noheading

end of l_type 
""/newline
switch(l_type)
  case "L" : "TOTAL FOR LIABILITY"/column=20 
  default  : "TOTAL FOR PROPERTY" 
total[l_loss_paid]/noheading/align=l_loss_paid
total[l_curr_adj_exp]/noheading/align=l_curr_adj_exp
total[l_curr_resv]/noheading/align=l_curr_resv
total[l_curr_adj_resv]/noheading/align=l_curr_adj_resv
total[l_prior_resv]/noheading/align=l_prior_resv
total[l_prior_adj_resv]/noheading/align=l_prior_adj_resv
total[l_incurred]/align=l_incurred
total[l_incurred_lae]/align=l_incurred_lae/noheading
total[l_incurred_total]/align=l_incurred_total/noheading

end of report
""/newline
"TOTAL FOR Report"/column=20
total[l_loss_paid]/noheading/align=l_loss_paid
total[l_curr_adj_exp]/noheading/align=l_curr_adj_exp
total[l_curr_resv]/noheading/align=l_curr_resv
total[l_curr_adj_resv]/noheading/align=l_curr_adj_resv
total[l_prior_resv]/noheading/align=l_prior_resv
total[l_prior_adj_resv]/noheading/align=l_prior_adj_resv
total[l_incurred]/align=l_incurred
total[l_incurred_lae]/align=l_incurred_lae/noheading
total[l_incurred_total]/align=l_incurred_total/noheading



/*  END OF FILE */
