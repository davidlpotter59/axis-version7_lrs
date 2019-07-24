/*  LRSPR751

    Losses by Claim Number - Direct - prior system claim number

    Date Written : March 13, 2003

    SCIPS.com */

description Loss By Prior System Claim Number then SCIPS Claim Number - Direct ;
             
define string l_name[10] = lrssetup:name[1]
Define String l_prog_number = "LRSPR751 - Rev 4.00"       

define string l_claim_no = str(lrsdetail:claim_no) + trun(sfsline_alias:claim_alpha)

Include "lrs63cal.inc"

include "lrscollect.inc"  

and   lrsdetail:trans_date <= l_ending_date and
      lrsdetail:trans_code < 30

list
/nobanner
/domain="lrsdetail" 
/title="Losses By Prior System Claim Number - DIRECT"
/pagewidth=220
/duplicates
/nodetail
/nopageheadings
/noreporttotals 

Include "lrs53xprt.inc"

sorted by lrssetup:other_system_claim_no 
          lrsdetail:claim_no
          lrsdetail:cause_of_loss 
          lrsdetail:cause_loss_subline 

Include "lrs53xclm.inc"

--include "lrs53col.inc"

Include "rpttopfw.inc"
end of report 
""/newline  
"  REPORT TOTAL "
total[l_loss_paid]/noheading/align=l_loss_paid
total[l_curr_adj_exp]/noheading/align=l_curr_adj_exp
total[l_curr_resv]/noheading/align=l_curr_resv
total[l_curr_adj_resv]/noheading/align=l_curr_adj_resv
total[l_prior_resv]/noheading/align=l_prior_resv
total[l_prior_adj_resv]/noheading/align=l_prior_adj_resv
total[l_incurred]/align=l_incurred/noheading
total[l_incurred_lae]/align=l_incurred_lae/noheading
total[l_incurred_total]/align=l_incurred_total/noheading   

;
/*  END OF FILE */
