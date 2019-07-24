/* lrspr2040.eq

   scips.com

   april 11, 2002

   daily claim log report
*/
                                         
description Daily claim Log ;

include "startend.inc"              

define string l_sort = if lrssetup:tpa_claim = "Y" then "T"
--else if lrssummary:loss_resv = 0 then "R"
else "C"

define string l_sort_str=switch(l_sort)
case "C"  : "Normal Claims"
case "R"  : "Claims with Zero Reserves"
case "T"  : "Third Party Administrator Claims"
default   : "Normal Claims"     

define string l_prog_number = "LRSPR2040 - Daily Claim Log"

where lrssetup:trans_date >= l_starting_date and
      lrssetup:trans_date <= l_ending_date

list
/domain="lrssetup"
/nobanner    
/pagewidth=252  
/nodefaults
/title="Claim Daily Transaction Log - All Status'"

lrssetup:claim_no/heading="Claim No"   
lrssetup:policy_no/heading="Policy No"
sfpname:name[1]/heading="Policy Holder"
lrssetup:agent_no/heading="Agent No"
sfsagent:name[1]/heading="Agent Name"
switch(lrssetup:status)
  case "O" : "Open"/heading="Claim Status" 
  case "R" : "Reopen"
  case "C" : "Closed"
  case "X" : "Record Only"
  default  : "Unknown"
lrssetup:trans_date/heading="Original-Setup Date"
lrssetup:loss_date/heading="Date Of-Loss" 
lrssummary:loss_resv/heading="Loss-Reserve"
lrssummary:loss_paid/heading="Loss-Paid"

sorted by l_sort/newpage/total
          lrssetup:trans_date /total 
          lrssetup:claim_no    

end of claim_no
if total[lrssummary:loss_resv] = 0 then 
    "Warning No Reserve"/newline/column=25  
else
    null 

include "rpttopfw.inc"
