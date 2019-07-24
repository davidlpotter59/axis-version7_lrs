/*  LRSPR880

    Losses by Claim Number - Direct

    Date Written : March 2, 1997

    SCIPS.com */
                                                   
description Losses By Claim Number - DIRECT - Liability ;

define string l_claim_no = str(lrsdetail:claim_no) + trun(sfsline_alias:claim_alpha
)

Define String l_prog_number = "LRSPR880 - Rev 2.00"

Include "lrs63cal.inc"

define unsigned ascii number l_amount = parameter/prompt=
"Please Enter Attachment Amount : "

where lrsdetail:trans_date <= l_ending_date and
      lrsdetail:trans_code < 30 and
      sfscause:line_type = "L"

list
/nobanner
/domain="lrsdetail"
/title="Losses By Claim Number - DIRECT - Liability"
/nopageheadings 
/pagewidth=255
/duplicates
/nodetail

Include "lrs88prt.inc"

sorted by lrsdetail:claim_no

Include "lrs88sel.inc"

Include "rpttopfw.inc"
""/newline
l_amount/heading="Attachment Point"/center

;
/*  END OF FILE */
