/*  LRSPR434

    Losses by Claim Number - Direct (Summary)- by selected agent number

    Date Written : January 26, 2004

    SCIPS.com */

description 
Direct Incurred Losses By Claim Number - Summary - by selected agent number ;
             
define string l_name[10] = lrssetup:name[1]
Define String l_prog_number = "LRSPR434 - Rev 4.20"    

define unsigned ascii number l_agent_no = parameter/prompt="Please Enter Agent Number to View:"   

define string l_claim_no = str(lrsdetail:claim_no) + trun(sfsline_alias:claim_alpha)

Include "lrs63cal.inc"

include "lrscollect.inc"  
and   lrsdetail:trans_date <= l_ending_date 
and   lrssetup:agent_no = l_agent_no 
and   lrsdetail:trans_code < 30
                 
list
/nobanner
/domain="lrsdetail" 
/title="Direct Incurred Losses By Claim Number - Summary - by Selected Agent Number"
/pagewidth=250
/duplicates
/nodetail
/nopageheadings
/noreporttotals 

Include "lrs53prt.inc"

sorted by lrsdetail:claim_no
--          lrsdetail:cause_of_loss 
--          lrsdetail:cause_loss_subline 

--Include "lrs53clm.inc"

--include "lrs53col.inc"
end of lrsdetail:claim_no  
lrsdetail:claim_no/noheading/column=1
lrssetup:policy_no/noheading/column=13
sfpname:eff_date/noheading/column=25
lrssetup:cause_of_loss/noheading/column=37
lrssetup:cause_loss_subline/noheading/column=41
lrssetup:loss_date/noheading/column=45
lrsdetail:line_of_business/noheading/column=57
lrsdetail:lob_subline/noheading/column=61
l_status/noheading/column=64
total[l_loss_paid,lrsdetail:claim_no]/noheading/align=l_loss_paid
total[l_curr_adj_exp,lrsdetail:claim_no]/noheading/align=l_curr_adj_exp
total[l_curr_resv,lrsdetail:claim_no]/noheading/align=l_curr_resv
total[l_curr_adj_resv,lrsdetail:claim_no]/noheading/align=l_curr_adj_resv
total[l_prior_resv,lrsdetail:claim_no]/noheading/align=l_prior_resv
total[l_prior_adj_resv,lrsdetail:claim_no]/noheading/align=l_prior_adj_resv
total[l_incurred,lrsdetail:claim_no]/align=l_incurred/noheading
total[l_incurred_lae,lrsdetail:claim_no]/align=l_incurred_lae/noheading
total[l_incurred_total,lrsdetail:claim_no]/align=l_incurred_total/noheading

Include "rpttopfw.inc"
""/newline
box/noblanklines/noheadings 
    lrssetup:agent_no/column=1/newline 
    sfsagent:name[1]/column=1/newline
    sfsagent:name[2]/column=1/newline 
    sfsagent:name[3]/column=1/newline 
    sfsagent:address[1]/column=1/newline 
    sfsagent:address[2]/column=1/newline 
    sfsagent:address[3]/column=1/newline
    trun(trun(sfsagent:city) + ", " + trun(sfsagent:str_state) + "  " + trun(str(sfsagent:zipcode,"99999-ZZZZ")))/column=1/newline
xob

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
