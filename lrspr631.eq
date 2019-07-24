/*  LRSPR631

    Losses by Claim Number - Direct

    Date Written : November 7, 1992

    WHITE HALL MUTUAL INSURANCE COMPANY */

description Losses by Claim Number - Direct - Detail ;
             
define string l_claim_no = str(lrsdetail:claim_no) + trun(sfsline_alias:claim_alpha
)

Define String l_prog_number = "LRSPR631 - Rev 2.00"

Include "lrs63cal.inc"

include "lrscollect.inc"
and   lrsdetail:trans_date <= l_ending_date and
      lrsdetail:trans_code < 30

list
/nobanner
/domain="lrsdetail"
/title="Losses By Claim Number - DIRECT"
/pagewidth=220
/duplicates

Include "lrs63prt.inc"

sorted by lrsdetail:claim_no

Include "lrs63clm.inc"

Include "rpttopfw.inc"

;
/*  END OF FILE */
