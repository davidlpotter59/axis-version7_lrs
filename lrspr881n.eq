/*  LRSPR881n

    Losses by Claim Number - Direct

    Date Written : March 2, 1997

    SCIPS.com */
                                                             
description 
Losses By Claim Number - direct incurred - $ select direct losses reported only by the range selected => $ Property  - Negative;

define string l_claim_no = str(lrsdetail:claim_no) + trun(sfsline_alias:claim_alpha
)

Define String l_prog_number = "LRSPR881n - Rev 1.00"

Include "lrs63cal.inc"
define signed ascii number l_amount = parameter/prompt=
"<NL>Enter Excess Amount to report<NL>for example: 20000 to report on <NL> all claims that have an incurred amount $20,000 or more: "

where lrsdetail:trans_date >= l_starting_date and
      lrsdetail:trans_date <= l_ending_date and
      lrsdetail:trans_code < 30 and
      sfscause:line_type <> "L"

list
/nobanner
/domain="lrsdetail"
/title="Losses By Claim Number - DIRECT - Property"
/pagewidth=255
/duplicates
/nodetail
/nopageheadings 
/nototals
/pagelength=0

Include "lrs88nprt.inc"

sorted by lrsdetail:claim_no

Include "lrs88nsel.inc"

Include "rpttopfw.inc"
""/newline 
l_amount/center/heading="Incurred Amounts Equal to or Greater Than "

;
/*  END OF FILE */
