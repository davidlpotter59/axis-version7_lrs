/*  LRSPR639

    Losses by Agent - Direct - Selected

    Date Written : November 7, 1992

    WHITE HALL MUTUAL INSURANCE COMPANY */

description Losses by Selected Agent ;

define String l_prog_number = "LRSPR639 - Rev 2.00"

define string l_claim_no = str(lrsdetail:claim_no) + trun(sfsline_alias:claim_alpha
)

define number l_agent_no = parameter /prompt="Enter Agent Code: ";

Include "lrs63cal.inc"

include "lrscollect.inc"
and   (lrsdetail:trans_date <= l_ending_date and
      lrsdetail:trans_code < 30) and
         sfsagent:agent_no = l_agent_no

list
/nobanner
/domain="lrsdetail"
/title="Losses By Agent - DIRECT"
/pagewidth=220
/duplicates

Include "lrs63prt.inc"

sorted by lrssetup:agent_no/newpage/total
          lrsdetail:claim_no/total

Include "lrs63clm.inc"

Include "rpttopag.inc"

;
/*  END OF FILE */
