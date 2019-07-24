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
/pagewidth=132
/duplicates
/nodetail 

Include "lrs10prtx.inc"

sorted by l_adjustor

Include "lrs10clmx.inc"

/*  END OF FILE */
