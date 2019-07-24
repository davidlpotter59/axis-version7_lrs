/* lrs_9012_loss.eq

   written by Conni at Salem

   November 16, 2012

*/
 
description
CAT 9012 LOSS RUN INFORMATION BY AGENT NO - INCLUDES LAE PAID AND LAE RESERVE ;

define unsigned number l_agent_no = parameter/prompt="Enter Agent No: "

Define unsigned ascii number l_vendor_no[5] = if lrssetup:adjustor_vendor <> 0 then
    Lrssetup:Adjustor_vendor
Else
    Lrssetup:examiner_no

define file sfsvendor_adjust_conni = access sfsvendor_adjust, set
sfsvendor_adjust:company_id = LRSSETUP:company_id,
sfsvendor_adjust:vendor_no = L_VENDOR_NO, exact
  
where lrssetup:AGENT_NO = l_agent_no and
      lrssetup:loss_date >=10.28.2012 and
      lrssetup:loss_date <=10.30.2012
list
/nobanner
/nodetail
/title="Cat 9012 Loss Run Report"
/domain="lrsdetail"

LRSSETUP:POLICY_NO/heading="POLICY NO"/name="policy_no" 
sfsline_heading:description/heading="POLICY-TYPE"/name="policy_type" 
sfpname:pol_year/heading="POLICY-YEAR"/name="Policy_year" 
SFPNAME:NAME[1]/heading="NAMED INSURED" /name="name_insured"
lrsdetail:claim_no/heading="CLAIM NO"/name="claim_no" 
lrssetup:status/heading="STATUS" /name="status"
lrssetup:loss_date/heading="LOSS DATE"/name="loss_date" 
sfscause:description/heading="CAUSE OF LOSS" /name="cause"
lrsdetail:loss_resv/mask="ZZZ,ZZZ,ZZZ.99"/heading="LOSS RESV"/name="loss_resv"
lrsdetail:loss_paid/mask="ZZZ,ZZZ,ZZZ.99"/heading="LOSS PAID" /name="loss_paid"
lrsdetail:lae_paid/mask="ZZZ,ZZZ,ZZZ.99"/heading="LAE PAID"/name="lae_paid" 
lrsdetail:lae_resv/mask="ZZZ,ZZZ,ZZZ.99"/heading="LAE RESV" /name="lae_resv"
lrsdetail:loss_resv+lrsdetail:loss_paid+lrsdetail:lae_paid+lrsdetail:lae_resv/heading="TOTAL-INCURRED"/total/mask="ZZZ,ZZZ,ZZZ.99"/name="total_incurred"
sfsvendor_adjust_conni:EXAMINOR_NAME/DUPLICATES/HEADING="ADJUSTER"/name="adjustor" 
sfsvendor_adjust_conni:telephone/DUPLICATES/HEADING="TELEPHONE NUMBER"/name="telephone"

sorted by LRSSETUP:POLICY_NO
          lrsdetail:claim_no

end of lrsdetail:claim_no 
box/noblanklines/noheadings 
LRSSETUP:POLICY_NO/align=policy_no
sfsline_heading:description/align=policy_type
sfpname:pol_year/align=policy_year 
SFPNAME:NAME[1]/align=name_insured
lrsdetail:claim_no/align=claim_no
lrssetup:status/align=status
lrssetup:loss_date/align=loss_date
sfscause:description/align=cause
TOTAL[lrsdetail:loss_resv]/mask="ZZZ,ZZZ,ZZZ.99"/align=loss_resv
TOTAL[lrsdetail:loss_paid]/mask="ZZZ,ZZZ,ZZZ.99"/align=loss_paid
total[lrsdetail:lae_paid]/mask="ZZZ,ZZZ,ZZZ.99"/align=lae_paid
total[lrsdetail:lae_resv]/mask="ZZZ,ZZZ,ZZZ.99"/align=lae_resv
total[lrsdetail:loss_resv]+total[lrsdetail:loss_paid]+total[lrsdetail:lae_paid]+total[lrsdetail:lae_resv]/column=180/mask="ZZZ,ZZZ,ZZZ.99"/align=total_incurred
sfsvendor_adjust_conni:EXAMINOR_NAME/duplicates/align=adjustor
sfsvendor_adjust_conni:telephone/duplicates/align=telephone
end box

top of report 
LRSSETUP:Agent_NO/left/heading="AGENT NO"/newline
SFSAGENT:NAME/heading="AGENT NAME"/newline
