/*  LRSPR533

    Losses by Claim Number - Net (Detail)

    Date Written : October 19, 2002

    SCIPS.com */

description Loss By Claim Number -Net (Detail) ;
             
define string l_name[10] = lrssetup:name[1]
Define String l_prog_number = "LRSPR533 - Rev 4.00"       

define string l_claim_no = str(lrsdetail:claim_no) + trun(sfsline_alias:claim_alpha)

Include "lrs63cal.inc"

include "lrscollect.inc"  

and   lrsdetail:trans_date <= l_ending_date 

list
/nobanner
/domain="lrsdetail" 
/title="Losses By Claim Number - NET"
/pagewidth=220
/duplicates
/nodetail
/nopageheadings
/noreporttotals 

Include "lrs53prt.inc"

sorted by lrsdetail:claim_no
          lrsdetail:cause_of_loss 
          lrsdetail:cause_loss_subline 

Include "lrs53clm.inc"

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
