/*  LRSPR531a

    Losses by Claim Number - Direct

    Date Written : October 5, 1993

    SCIPS.com */

description 
Loss By Claim Number - Direct - Combination Dwelling Owner Occupied Policies ;
             
define string l_name[10] = lrssetup:name[1]
Define String l_prog_number = "LRSPR531a - Rev 2.00"       

define string l_claim_no = str(lrsdetail:claim_no) + trun(sfsline_alias:claim_alpha)

define file alt_sfpcurrent = access sfpcurrent, set
sfpcurrent:policy_no = lrssetup:policy_no, exact

define file alt_plppersonal = access plppersonal, set
plppersonal:policy_no = alt_sfpcurrent:policy_no,
plppersonal:pol_year  = alt_sfpcurrent:pol_year,
plppersonal:end_sequence = alt_sfpcurrent:end_sequence, generic

Include "lrs63cal.inc"

include "lrscollect.inc"  
        
and   lrsdetail:trans_date <= l_ending_date and
      lrsdetail:trans_code < 30 and
      lrsdetail:line_of_business = 1 and
      alt_plppersonal:owner_occupied = "Y"

list
/nobanner
/domain="lrsdetail" 
/title="Losses By Claim Number - DIRECT"
--/pagewidth=220
/duplicates
/nodetail
/nopageheadings
/noreporttotals 
/wks

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
