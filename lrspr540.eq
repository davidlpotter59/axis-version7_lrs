/*  lrspr540

    scips.com

    may 2, 2002

    claims handled by adjustor listing
*/

description 
Direct Listing of Claims Handled by Adjustor Selected by Reported Date;

define string l_prog_number = "LRSPR540 - Version 4.10"

include "startend.inc"

where (lrssetup:reported_date >= l_starting_date and
       lrssetup:reported_date <= l_ending_date ) and
      lrsdetail:vendor_no <> 0 and
      lrsdetail:trans_code < 30

list
/nobanner
/domain="lrsdetail"
/title="Listing of Claims Handled by Adjustor Selected by Reported Date"
/nodetail
/pagewidth=100

lrssetup:claim_no /column=1
lrssetup:reported_date/column=15
lrssetup:loss_date/column=30  
lrssetup:line_of_business/column=45/heading="Line"
lrssetup:lob_subline/column=51/heading="LOB-Sub"
lrssetup:cause_of_loss/column=60
lrssetup:cause_loss_subline/column=67/heading="Cause-Sub"
lrssetup:status/column=75   


sorted by lrsdetail:vendor_no/newpage 

end of lrsdetail:vendor_no           
box/noheadings 
lrssetup:claim_no /column=1
lrssetup:reported_date/column=15
lrssetup:loss_date/column=30  
lrssetup:line_of_business/column=45
lrssetup:lob_subline/column=51
lrssetup:cause_of_loss/column=60
lrssetup:cause_loss_subline/column=67
lrssetup:status/column=75
switch(lrssetup:status)
case "O"    : "OPEN  "
case "C"    : "CLOSED"
case "R"    : "Reopen"/column=77
end box

include "reporttop.inc"
sfsvendor:name[1]/newline/heading="Claims for "
