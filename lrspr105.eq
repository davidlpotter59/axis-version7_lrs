/*  LRSPR105

    Losses by Adjustor - Direct

    Date Written : February 26, 1993

    SCIPS.com */

description Losses By Adjustor ;
            
define unsigned ascii number l_adjustor[5] = lrsdetail:vendor_no  

define string l_claim_no = str(lrsdetail:claim_no) + trun(sfsline_alias:claim_alpha)
          
define file alt_sfsvendor = access sfsvendor, set
                            sfsvendor:company_id = lrsdetail:company_id,
                            sfsvendor:vendor_no = l_adjustor, generic
 
Define String l_prog_number = "LRSPR105 - Rev. 4.00"

Include "lrs10cal.inc"

where lrsdetail:trans_code < 30 and
      l_adjustor <> 0 

list
/nobanner
/domain="lrsdetail"
/title="Losses By Adjustor"
/pagewidth=250
/duplicates
--/nodefaults 

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

;
/*  END OF FILE */
