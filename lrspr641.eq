/*  LRSPR641

    Losses by Cat Number - Direct

    Date Written : February 25, 1993

    WHITE HALL MUTUAL INSURANCE COMPANY */

description Losses by Cat Number - Direct ;
            
define string l_claim_no = str(lrsdetail:claim_no) + trun(sfsline_alias:claim_alpha
)

Define String l_prog_number = "LRSPR641 - Rev 2.00"

Include "lrs63cal.inc"

include "lrscollect.inc"
and   lrsdetail:trans_date <= l_ending_date and
      lrsdetail:trans_code < 30 and
      lrssetup:cat_no <> 0

list
/nobanner
/domain="lrsdetail"
/title="Losses By Cat Number - DIRECT"
/pagewidth=220
/duplicates

Include "lrs64prt.inc"

sorted by lrssetup:cat_no/total/newpage
          lrsdetail:claim_no

Include "lrs63clm.inc"

Include "rpttopfw.inc"

;
/*  END OF FILE */
