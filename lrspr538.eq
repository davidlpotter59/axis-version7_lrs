/*  LRSPR538

    Public Adjustors by Agent

    SCIPS.com, Inc

Modified By     Date                  Description
*/

description 
Incurred Direct Public Adjustor Claims by Agent ;

Define String l_prog_number = "LRSPR538 - Rev 4.10"

define string l_claim_no = str(lrsdetail:claim_no) + trun(sfsline_alias:claim_alpha
)

Include "lrs63cal.inc"

include "lrscollect.inc"
and lrsdetail:trans_date <= l_ending_date and
    lrsdetail:trans_code < 30 and
    lrssetup:pa = "Y"

list
/nobanner
/domain="lrsdetail"
/title="Incurred Direct Public Adjustor Losses by Agent"
--/pagewidth=250
/duplicates
/nodetail                       
/nopageheadings

Include "lrs53prt.inc"

sorted by   lrssetup:agent_no/newpage
            lrssetup:pub_adjust_no /newlines=2
            lrsdetail:claim_no

Include "lrs53clm.inc"

include "reporttop.inc"
sfsagent:name[1]/heading="Agent"/column=1

top of lrssetup:pub_adjust_no 
""/newline
lrspubadj:name[1]/column=5/newline=2/heading="Public Adjustor Name"
