/*  LRSPR547

    Property Losses by Claim Number - Direct

    Date Written : October 5, 1993
                   November 1, 2000 -- created from lrspr537

    SCIPS.com, Inc

Modified By     Date                  Description
   DLP          09/05/2000          added standard report heading
*/

description 
Direct Incurred Property Losses by Claim Number ;

Define String l_prog_number = "LRSPR547 - Rev 2.00"
define string l_claim_no = str(lrsdetail:claim_no) + trun(sfsline_alias:claim_alpha
)

define string l_litigation = switch(lrssetup:litigation)
case "Y" : "Claims in Litigation"
default  : "Claims not in Litigation"

Include "lrs63calprop.inc"

include "lrscollect.inc"
 and lrsdetail:trans_date <= l_ending_date and
      lrsdetail:trans_code < 30 and
      sfsline:line_type <> "L"

list
/nobanner
/domain="lrsdetail"
/title="Direct Property Losses By Claim Number"
--/pagewidth=220
/duplicates
/nodetail                       

Include "lrs53prt.inc"

sorted by   l_litigation/newpage
            lrsdetail:claim_no

Include "lrs53clm3.inc"

include "reporttop.inc"
""/newline
if lrssetup:litigation = "Y" then
"Claims that are in Litigation"
else
"Claims that are not in Litigation"/newline
