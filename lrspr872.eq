/*  LRSPR872

    Reserve Changes by a parameter amount

    Date Written : May 2, 2002

    SCIPS.com, Inc. */

description 
Reserve changes (All Causes) by a selected amount - Requires user to enter the amount of change.  Also, this report uses a starting and ending date range.  The reserve will be compared to the prior period;

Define String l_prog_number = "LRSPR872 - Rev 4.00"

define string l_claim_no = str(lrsdetail:claim_no) + trun(sfsline_alias:claim_alpha
)

Include "lrs63cal.inc"

define signed ascii number l_different_reserve = l_prior_resv - l_curr_resv 

define unsigned ascii number l_amount = Parameter/prompt=
"<NL>Enter Reserve Amount to Report<NL>For example: 10000 "

include "lrscollect.inc" and
    lrsdetail:trans_date <= l_ending_date and
      lrsdetail:trans_code < 30

list
/nobanner
/domain="lrsdetail"
/title="Losses With Reserve Changes Equal or Greater Than Selected Amount"
/pagewidth=255
/duplicates
/nodetail
/nodefaults 

Include "lrs88prt.inc"

sorted by lrsdetail:claim_no

Include "lrsresvsel.inc"

Include "rpttopfw.inc"
""/newline             
l_amount/center/heading="Reserve Change Amounts Equal to or Greater Than "

;
/*  END OF FILE */
