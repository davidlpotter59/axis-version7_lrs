/* lrspr2020f.eq

   scips.com

   October 16, 2006

   daily Assigned Report by Examine
*/
                                         
description Daily Assigned Report - Open Claims per Examiner  ;

include "startend.inc"                   

define string l_prog_number = 
"LRSPR2020f - Open Claims per Examiner  "

define string l_claim_no = str(lrssetup:claim_no) + trun(sfsline:claim_alpha)

define unsigned ascii number l_total_paid = lrssummary:ulae_PAID + lrssummary:alae_paid
define unsigned ascii number l_total_resv = lrssummary:alae_resv + lrssummary:ulae_resv

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

define file alt_sfsvendor3 = access sfsvendor, set sfsvendor:company_id = lrssetup:company_id , 
                                                   sfsvendor:vendor_no = l_vendor_3, generic

define file alt_sfsvendor4 = access sfsvendor, set sfsvendor:company_id = lrssetup:company_id ,
                                                   sfsvendor:vendor_no = l_vendor_4, generic
 
define file alt_sfsvendor5 = access sfsvendor, set sfsvendor:company_id = lrssetup:company_id ,
                                                   sfsvendor:vendor_no = l_vendor_5, generic
 
define file alt_sfsvendor6 = access sfsvendor, set sfsvendor:company_id = lrssetup:company_id ,
                                                   sfsvendor:vendor_no = l_vendor_6, generic
 
define unsigned ascii number l_counter[9]=1;

where lrssetup:examiner_no <> 0 and                
      (lrssetup:status = "O" or
       lrssetup:status = "R") and                     
      lrsdetail:trans_date <= l_ending_date and    
      lrsdetail:trans_date >= l_starting_date 

list
/domain="lrssetup"
/nobanner    
/pagewidth=240  
/title="Daily Assigned Report Sorted by Examiner "
 
box/noblanklines
lrssetup:examiner_no/heading="Examiner-Number"/mask="ZZZZZ"/duplicates
trun(l_claim_no)/heading="Claim No"/duplicates
lrssetup:reported_date/heading="Date-Assigned"
str(lrssetup:cause_of_loss) + lrssetup:cause_loss_subline/heading="Cause-Of Loss"
trun(sfpname:name[1,1,15])/heading="Policy Holder"
lrssetup:loss_date/heading="Date-Of Loss"    
lrssetup:agent_no/noheading 
sfsagent:name[1]/heading="Agent" 
lrssummary:loss_paid /heading = "Losses-Paid"/nozerosuppress/total  
lrssummary:loss_resv /heading = "Loss-Reserves"/nozerosuppress/total  
l_total_paid /heading = "ALAE and-ULAE Paid"/nozerosuppress/total/mask="$$,$$$,$$9.99-"
l_total_resv /heading="ALAE and-ULAE Reserves"/nozerosuppress/total/mask="$$,$$$,$$9-"
end box

switch(lrssetup:status)
  case "O" : "OPEN"/heading="Claim-Status" 
  case "C" : "Closed"
  case "R" : "Reopened"

sorted by lrssetup:examiner_no/newpage/total 
          lrssetup:claim_no/newline
          lrssetup:reported_date 

include "rpttopfw.inc"  
""/newline
alt_sfsvendor5:name[1]/heading="Examiner Adjuster"/newline

end of lrssetup:examiner_no  
""/newline
count[lrssetup:units,lrssetup:examiner_no]/heading="Total Period Claims Assigned"
 
end of report
count[lrssetup:units]/heading ="Total Number of Claims Assigned"
