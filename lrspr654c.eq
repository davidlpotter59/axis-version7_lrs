/*  LRSPR654c

    Losses by Claim Number - Ceded - Spreadsheet output

    Date Written : October 28, 2003

    SCIPS.com, Inc. */

description Outstanding Loss and LAE by Annual Statement Line of Business and Company Line - Spreadsheet Output - Ceded;


Define String l_prog_number = "LRSPR654c - Rev 4.10"

Include "lrs63cal.inc"

include "lrscollect.inc"
and   lrsdetail:trans_date <= l_ending_date  
and lrsdetail:trans_code >= 70 

list
/nobanner
/domain="lrsdetail"
/pagewidth=255
/duplicates 
/nodetail                   
/nototals
/noreporttotals
/wks 
/nopageheadings 
/nodefaults  

--Include "lrs664prt.inc"

sorted by sfsline:stmt_lob /newlines 
          lrsdetail:line_of_business 

top of sfsline:stmt_lob 
sfsline:stmt_lob/noheading/column=1
sfsstmt:description/column=6/noheading /newline
"================================================" 

end of sfsline:stmt_lob 
""/newline     
"Total for Statement"/column=15
total[l_loss_paid,     sfsline:stmt_lob]/noheading/column=40
total[l_curr_adj_exp,  sfsline:stmt_lob]/noheading/column=60
total[l_curr_resv,     sfsline:stmt_lob]/noheading/column=80
total[l_curr_adj_resv, sfsline:stmt_lob]/noheading/column=100
total[l_prior_resv,    sfsline:stmt_lob]/noheading/column=120
total[l_prior_adj_resv,sfsline:stmt_lob]/noheading/column=140
total[l_incurred,      sfsline:stmt_lob]/noheading/column=160
total[l_incurred_lae,  sfsline:stmt_lob]/noheading/column=180
total[l_incurred_total,sfsline:stmt_lob]/noheading/column=200

end of lrsdetail:line_of_business 
lrsdetail:line_of_business/column=5/noheading
sfsline_heading:description/mask="X(25)"/noheading/column=11
total[l_loss_paid,     lrsdetail:line_of_business]/noheading/column=40
total[l_curr_adj_exp,  lrsdetail:line_of_business]/noheading/column=60
total[l_curr_resv,     lrsdetail:line_of_business]/noheading/column=80
total[l_curr_adj_resv, lrsdetail:line_of_business]/noheading/column=100
total[l_prior_resv,    lrsdetail:line_of_business]/noheading/column=120
total[l_prior_adj_resv,lrsdetail:line_of_business]/noheading/column=140
total[l_incurred,      lrsdetail:line_of_business]/noheading/column=160
total[l_incurred_lae,  lrsdetail:line_of_business]/noheading/column=180
total[l_incurred_total,lrsdetail:line_of_business]/noheading/column=200  


end of report
""/newline
"REPORT TOTAL"/noheading/column=10
total[l_loss_paid]      /noheading/column=40
total[l_curr_adj_exp]   /noheading/column=60
total[l_curr_resv]      /noheading/column=80
total[l_curr_adj_resv]  /noheading/column=100
total[l_prior_resv]     /noheading/column=120
total[l_prior_adj_resv] /noheading/column=140
total[l_incurred]       /noheading/column=160
total[l_incurred_lae]   /noheading/column=180
total[l_incurred_total] /noheading/column=200
