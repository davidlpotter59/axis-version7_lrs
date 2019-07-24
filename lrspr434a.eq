/*  LRSPR434a

    Losses by Claim Number - Direct (Summary)- by ALL agent number

    Date Written : July 11, 2005

    SCIPS.com */

description 
Direct Incurred Losses By Claim Number - Summary - All Agents ;
             
define string l_name[10] = lrssetup:name[1]
Define String l_prog_number = "LRSPR434a - Rev 4.10"    

define string l_claim_no = str(lrsdetail:claim_no) + trun(sfsline_alias:claim_alpha)
          
define file lrssetupa = access lrssetup, set lrssetup:company_id= 
lrsdetail:company_id, 
                                             lrssetup:claim_no= 
lrsdetail:claim_no, exact, many to one 

Include "lrs63cal.inc"

include "lrscollect.inc"  
          
and   lrsdetail:trans_date <= l_ending_date 
and   lrsdetaiL:trans_code < 30

list
/nobanner
/domain="lrsdetail" 
/title="Direct Incurred Losses By Claim Number - Summary - ALL Agents"
/duplicates
/nodetail
/nopageheadings
/noreporttotals 
/pagewidth=255

Include "lrs53prt.inc"

sorted by lrssetupa:agent_no /newpage 
          lrsdetail:claim_no
          lrsdetail:cause_of_loss 
          lrsdetail:cause_loss_subline 

--Include "lrs53clm.inc"

include "lrs53col.inc"

Include "reporttop.inc"
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

end of lrssetupa:agent_no 
""/newline  
"  AGENT TOTAL "
total[l_loss_paid]/noheading/column=77
total[l_curr_adj_exp]/noheading/column=92
total[l_curr_resv]/noheading/column=107
total[l_curr_adj_resv]/noheading/column=122
total[l_prior_resv]/noheading/column=137
total[l_prior_adj_resv]/noheading/column=152
total[l_incurred]/noheading/column=167
total[l_incurred_lae]/noheading/column=182
total[l_incurred_total]/noheading/column=197

end of report 
""/newline  
"  REPORT TOTAL "
total[l_loss_paid]/noheading/column=77
total[l_curr_adj_exp]/noheading/column=92
total[l_curr_resv]/noheading/column=107
total[l_curr_adj_resv]/noheading/column=122
total[l_prior_resv]/noheading/column=137
total[l_prior_adj_resv]/noheading/column=152
total[l_incurred]/noheading/column=167
total[l_incurred_lae]/noheading/column=182
total[l_incurred_total]/noheading/column=197
