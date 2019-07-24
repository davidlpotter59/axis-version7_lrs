/* lrspr2020.eq

   scips.com

   april 11, 2002

   daily Adjuster Assigned Report
*/
                                         
description Daily Adjuster Assigned Report ;

include "startend.inc"                   

define string l_prog_number = "LRSPR2020 Daily Adjuster Assigned Report"

define string l_claim_no = str(lrssetup:claim_no) + trun(sfsline:claim_alpha)

define unsigned ascii number l_vendor_1[5] = lrssetup:vendor_no[5]
                             l_vendor_2[5] = lrssetup:vendor_no[3]
                             l_vendor_3[5] = lrssetup:vendor_no[4]
                             l_vendor_4[5] = lrssetup:vendor_no[6]
                             l_vendor_5[5] = lrssetup:vendor_no[1]
                             l_vendor_6[5] = lrssetup:vendor_no[2]
 
define file alt_sfsvendor1 = access sfsvendor, set sfsvendor:company_id = lrssetup:company_id,
                                                   sfsvendor:vendor_no = l_vendor_1, generic

define file alt_sfsvendor2 = access sfsvendor, set sfsvendor:company_id = lrssetup:company_id,
                                                   sfsvendor:vendor_no = l_vendor_2, generic

define file alt_sfsvendor3 = access sfsvendor, set sfsvendor:company_id = lrssetup:company_id,
                                                   sfsvendor:vendor_no = l_vendor_3, generic

define file alt_sfsvendor4 = access sfsvendor, set sfsvendor:company_id = lrssetup:company_id,
                                                   sfsvendor:vendor_no = l_vendor_4, generic
 
define file alt_sfsvendor5 = access sfsvendor, set sfsvendor:company_id = lrssetup:company_id,
                                                   sfsvendor:vendor_no = l_vendor_5, generic
 
define file alt_sfsvendor6 = access sfsvendor, set sfsvendor:company_id = lrssetup:company_id,
                                                   sfsvendor:vendor_no = l_vendor_6, generic
 
where lrssetup:status = "O" and
      lrssetup:status_date >= l_starting_date and
      lrssetup:status_date <= l_ending_date 
list
/domain="lrssetup"
/nobanner    
/pagewidth=252  
/nodefaults

trun(l_claim_no)/heading="Claim No"   
lrssetup:reported_date/heading="Date-Assigned"
str(lrssetup:cause_of_loss) + lrssetup:cause_loss_subline/heading="Cause-Of Loss"
--lrssetup:policy_no/heading="Policy No"/column=15
trun(sfpname:name[1,1,15])/heading="Policy Holder"
lrssetup:loss_date/heading="Date-Of Loss"
lrssummary:loss_resv/heading="Loss-Resv"
lrssummary:ulae_resv/heading="ULAE-Resv"
lrssummary:alae_resv/heading="ALAE-Resv"
--lrssetup:agent_no/heading="Agent No"
trun(sfsagent:name[1,1,15])/heading="Agent Name"
switch(lrssetup:status)
  case "O" : "OPEN"/heading="Claim Status" 
lrssetup:loss_date/heading="Date Of-Loss"

"Examinor: "/column=120
l_vendor_5/column=140/mask="ZZZZZ"
alt_sfsvendor5:name[1,1,15]/newline
                                  
"Adjuster: "/column=120
l_vendor_6/column=140/mask="ZZZZZ"
alt_sfsvendor6:name[1,1,15]/newline
                                  
"Coverage Opinion: "/column=120
l_vendor_1/column=140/mask="ZZZZZ"
alt_sfsvendor1:name[1,1,15]/newline
                                  
"Litigation:       "/column=120
l_vendor_2/column=140/mask="ZZZZZ"
alt_sfsvendor2:name[1,1,15]/newline

"DJ:               "/column=120
l_vendor_3/column=140/mask="ZZZZZ"
alt_sfsvendor3:name[1,1,15]/newline

"Subro/Salvage:    "/column=120
l_vendor_4/column=140/mask="ZZZZZ"
alt_sfsvendor4:name[1,1,15]/newline=2

sorted by lrssetup:claim_no   

include "rpttopfw.inc"
