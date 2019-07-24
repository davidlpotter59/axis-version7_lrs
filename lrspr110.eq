/*  LRSPR110

    Losses by Adjustor - Not Attorneys only (3,4,5,6 types) - Direct

    Date Written : February 11, 2004

    SCIPS.com */

description 
Direct Losses By Adjustor - No Attorneys - Transaction Date Processing not INCURRED ;
            
define unsigned ascii number l_adjustor[5] = lrsdetail:vendor_no  

define string l_claim_no = str(lrsdetail:claim_no) + trun(sfsline_alias:claim_alpha)
          
define file alt_sfsvendor = access sfsvendor, set
                            sfsvendor:company_id = lrsdetail:company_id,
                            sfsvendor:vendor_no = l_adjustor, generic
 
Define String l_prog_number = "LRSPR110 - Rev. 4.10"

Include "lrs10cal.inc"

where lrsdetail:trans_code one of 16
      and l_adjustor <> 0 
      and alt_sfsvendor:vendor_type not one of 3,4,5,6
      and (lrsdetail:trans_date >= l_starting_date 
      and  lrsdetail:trans_date <= l_ending_date)

list
/nobanner
/domain="lrsdetail"
/title="Direct Losses By Adjustor - NO Attorneys - Transaction Date Processing not INCURRED"
/pagewidth=250
/duplicates 

Include "lrs10prt.inc"

sorted by l_adjustor/newpage/total/heading="ADJUSTOR"
          lrsdetail:claim_no
          lrsdetail:cause_of_loss

Include "lrs10clm.inc"

Include "rpttopfw.inc"
""/newline
l_adjustor/noheading
alt_sfsvendor:name[1]/noheading/duplicates
sfsventype:description/newline/heading="Vendor Type"/column=70
