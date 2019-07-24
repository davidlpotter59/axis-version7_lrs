/*  LRSPR871

    Liability Losses by Claim Number - Direct

    Date Written : March 2, 1997

    SCIPS.com, Inc. */

description 
Losses by claim no - direct incurred - $ select direct losses reported only by the range selected => $ Liability ;

Define String l_prog_number = "LRSPR871 - Rev 2.00"

define string l_claim_no = str(lrsdetail:claim_no) + trun(sfsline_alias:claim_alpha
)

Include "lrs63cal.inc"

define unsigned ascii number l_amount = Parameter/prompt=
"<NL>Enter Excess Amount to Report<NL>For example: 20000 to report on<NL>all claims that have an incurred amount $20,000 or more: "

include "lrscollect.inc" and
    lrsdetail:trans_date <= l_ending_date and
      lrsdetail:trans_code < 30 and
      sfscause:line_type = "L" 

list
/nobanner
/domain="lrsdetail"
/title="Liability Losses By Claim Number - DIRECT"
/pagewidth=255
/duplicates
/nodetail
/nodefaults 

Include "lrs88prt.inc"

sorted by lrsdetail:claim_no

Include "lrs88sel.inc"

Include "rpttopfw.inc"
""/newline             
l_amount/center/heading="Incurred Amounts Equal to or Greater Than "

;
/*  END OF FILE */
