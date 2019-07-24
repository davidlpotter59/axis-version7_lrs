/* lrspr2020s.eq

   scips.com

   april 11, 2002

   daily Assigned Report by Subro/Salvage Adjustor
*/
                                         
description Daily Assigned Report - Sorted by Subro / Salvage Adjustor  ;

include "startend.inc"                   

define string l_prog_number = 
"LRSPR2020d Daily Assigned Report - Subro / Salvage Adjustor  "

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
 
define unsigned ascii number l_counter[9]=1;

where lrssetup:status = "O" and
      lrssetup:status_date >= l_starting_date and
      lrssetup:status_date <= l_ending_date and
      lrssetup:Subro_vendor <> 0

list
/domain="lrssetup"
/nobanner    
/pagewidth=252  
/title="Daily Assigned Report Sorted by Subro / Salvage Adjustor "
/nodefaults 
--/duplicates 

box/noblanklines
lrssetup:examiner_no/heading="Subro/Salvage-Number"/duplicates
trun(l_claim_no)/heading="Claim No" /duplicates   
lrssetup:reported_date/heading="Date-Assigned"
str(lrssetup:cause_of_loss) + lrssetup:cause_loss_subline/heading="Cause-Of Loss"
trun(sfpname:name[1,1,15])/heading="Policy Holder"
lrssetup:loss_date/heading="Date-Of Loss"         
lrssetup:agent_no/noheading 
sfsagent:name[1]/heading="Agent" 
lrssummary:loss_resv/heading="Loss-Resv"/noduplicates 
lrssummary:ulae_resv/heading="ULAE-Resv"/noduplicates  
lrssummary:alae_resv/heading="ALAE-Resv"/noduplicates  
end box
switch(lrssetup:status)
  case "O" : "OPEN"/heading="Claim Status" 
  case "C" : "Closed"
  case "R" : "Reopened"

sorted by lrssetup:subro_vendor/newpage/total 
          lrssetup:reported_date /total/newlines=2
          lrssetup:claim_no   

include "rpttopfw.inc"  
""/newline
alt_sfsvendor4:name[1]/heading="Subro/Salvage Adjustor"/newline=2

end of lrssetup:reported_date 
""/newline
count[lrssetup:units,lrssetup:reported_date]/heading="Total Reported Date Claims Assigned"

end of lrssetup:subro_vendor 
""/newline
count[lrssetup:units,lrssetup:subro_vendor]/heading=
"Total Period Claims Assigned"
