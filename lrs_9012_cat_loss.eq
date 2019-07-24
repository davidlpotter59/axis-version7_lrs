/* lrs_9012_cat_loss.eq

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

LRSSETUP:POLICY_NO/heading="POLICY NO"/column=1 
sfsline_heading:description/heading="POLICY-TYPE"/column=15 
sfpname:pol_year/heading="POLICY-YEAR"/column=30 
SFPNAME:NAME[1]/column=55/heading="NAMED INSURED" 
lrsdetail:claim_no/column=70/heading="CLAIM NO." 
lrssetup:status/column=80/heading="STATUS" 
lrssetup:loss_date/column=90 
sfscause:description/column=100/heading="CAUSE-OF LOSS" 
lrsdetail:loss_resv/mask="ZZZ,ZZZ,ZZZ.99"/column=115 
lrsdetail:loss_paid/mask="ZZZ,ZZZ,ZZZ.99"/column=130 
lrsdetail:lae_paid/mask="ZZZ,ZZZ,ZZZ.99"/column=145 
lrsdetail:lae_resv/mask="ZZZ,ZZZ,ZZZ.99"/column=160 
lrsdetail:loss_resv+lrsdetail:loss_paid+lrsdetail:lae_paid+lrsdetail:lae_resv/heading="TOTAL-INCURRED"/total/mask="ZZZ,ZZZ,ZZZ.99"/column=180 
sfsvendor_adjust_conni:EXAMINOR_NAME/DUPLICATES/HEADING="OUTSIDE ADJUSTER" /COLUMN=200
sfsvendor_adjust_conni:telephone/DUPLICATES/HEADING="TELEPHONE NUMBER"

sorted by LRSSETUP:POLICY_NO
          lrsdetail:claim_no

end of lrsdetail:claim_no 
box/noblanklines/noheadings LRSSETUP:POLICY_NO /COLUMN=1
sfsline_heading:description /COLUMN=15
sfpname:pol_year /COLUMN=30
SFPNAME:NAME[1]/COLUMN=55
lrsdetail:claim_no/column=70
lrssetup:status/column=80
lrssetup:loss_date/column=90
sfscause:description /column=100
TOTAL[lrsdetail:loss_resv]/mask="ZZZ,ZZZ,ZZZ.99"/column=115
TOTAL[lrsdetail:loss_paid]/mask="ZZZ,ZZZ,ZZZ.99"/column=130
total[lrsdetail:lae_paid]/column= 145/mask="ZZZ,ZZZ,ZZZ.99"
total[lrsdetail:lae_resv]/column= 160/mask="ZZZ,ZZZ,ZZZ.99"
total[lrsdetail:loss_resv]+total[lrsdetail:loss_paid]+total[lrsdetail:lae_paid]+total[lrsdetail:lae_resv]/column=180/mask="ZZZ,ZZZ,ZZZ.99"
sfsvendor_adjust_conni:EXAMINOR_NAME/duplicates/COLUMN=200
sfsvendor_adjust_conni:telephone/duplicates
end box

top of report 
LRSSETUP:Agent_NO/left/heading="AGENT NO"/newline
SFSAGENT:NAME/heading="AGENT NAME"/newline
