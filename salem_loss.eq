/* salem_loss.eq

   scips.com

   February 15, 2012

   loss run by policy no for agents
*/

description
AGENTS VERSION OF THE LOSS RUN REPORT
 
LOSS RUN INFORMATION BY POLICY NUMBER (Direct - Not Ceded)

PRINT THE RESULTS INTO IMAGERIGHT THEN FAX OR EMAIL TO THE AGENT

ENTER THE POLICY NUMBER WHEN PROMPTED;

define unsigned ascii number l_agent_no[4] = parameter

define unsigned ascii number l_policy_no[9] = parameter 
  
define file alt_sfpcurrent = access sfpcurrent, set
sfpcurrent:policy_no = l_policy_no, generic

define string l_subline[2] = "00"

define file alt_sfpname = access sfpname, set
sfpname:policy_no    = l_policy_no,
sfpname:pol_year     = alt_sfpcurrent:pol_year,
sfpname:end_sequence = alt_sfpcurrent:end_sequence, generic

define file alt_sfsline = access sfsline, set
sfsline:company_id       = alt_sfpname:company_id,
sfsline:line_of_business = alt_sfpname:line_of_business,
sfsline:lob_subline      = l_subline, generic

define string i_name[30] = alt_sfpname:name[1]
include "renaeq1.inc"

where lrssetup:policy_no = l_policy_no and
      lrssetup:agent_no  = l_agent_no and
      lrsdetail:trans_code < 30 
list
/nobanner
/nodetail
/title="AGENT LOSS RUN REPORT BY POLICY NO."
/domain="lrsdetail"
--/nopageheadings
/noreporttotals

lrsdetail:claim_no/column=1/heading="CLAIM NO." 
lrssetup:status/column=20/heading="CLAIM STATUS" 
lrssetup:loss_date/column=40/heading="LOSS DATE" 
sfscause:description/column=55/heading="CAUSE OF LOSS" 
lrsdetail:loss_resv/mask="ZZZ,ZZZ,ZZZ.99"/column=75/heading="LOSS RESERVE" 
lrsdetail:loss_paid/mask="ZZZ,ZZZ,ZZZ.99"/column=95/heading="LOSS PAID"

sorted by 
  lrsdetail:claim_no
  lrsdetail:line_of_business
  lrsdetail:lob_subline
  lrsdetail:cause_loss_subline
  lrsdetail:claim_no

end of lrsdetail:claim_no 
  box/noblanklines/noheadings lrsdetail:claim_no/column=1
  lrssetup:status /column= 20
  lrssetup:loss_date /column= 40
  sfscause:description /column=55
  total[lrsdetail:loss_resv]/column= 75/mask="ZZZ,ZZZ,ZZZ.99"
  total[lrsdetail:loss_paid]/column= 95/mask="ZZZ,ZZZ,ZZZ.99"
  
  end box

top of report 
  box/noblanklines/noheading/column=1/inline
  L_POLICY_NO/left/heading="         POLICY NO"/mask="ZZZZZZZZZ"/column=1/newline
  alt_sfsline:description/left/heading="               LOB"/column=1/newline
  include "renaeq2.inc"/heading="     NAMED INSURED"/column=1/newline
  ALT_SFPNAME:ORIGINAL_EFF_DATE/left/heading="POLICYHOLDER SINCE"/column=1
  end box/newline
    
end of report 
  ""/newline
  count[lrssetup:loss_date]/duplicates/heading="TOTAL CLAIMS REPORTED"



