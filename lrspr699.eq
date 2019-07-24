/*  LRSPR639

    Losses by Agent - Direct - Selected

    Date Written : April 22, 2003

    SCIPS.com, Inc */

description Losses by Selected Agent - Period Paid Only ;

define String l_prog_number = "LRSPR699 - Rev 4.00"

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
/title="Losses By Agent - DIRECT - Paid Only"
/pagewidth=80
/duplicates
/nodetail 

l_claim_no/heading="Claim No"
lrssetup:policy_no/column=13
str(lrsdetail:cause_of_loss) + " " + lrsdetail:cause_loss_subline/heading=
"Cause"
lrssetup:loss_date/heading="Date-of Loss"
str(lrsdetail:Line_of_business) + " " + lrsdetail:lob_subline/heading=
"Line"
lrsdetail:vendor_no/heading="Adj-No"
lrsdetail:trans_code/heading="Trans-Code"
l_loss_paid/heading="Paid"

sorted by lrssetup:agent_no/newpage/total
          lrsdetail:claim_no

end of lrsdetail:claim_no
l_claim_no/noheading
lrssetup:policy_no/column=13/noheading 
str(lrsdetail:cause_of_loss) + " " + lrsdetail:cause_loss_subline
lrssetup:loss_date/noheading
str(lrsdetail:Line_of_business) + " " + lrsdetail:lob_subline/noheading
lrsdetail:vendor_no/noheading
lrsdetail:trans_code/noheading
total[l_loss_paid,lrsdetail:claim_no]/noheading/align=l_loss_paid

top of page
"Program Number: "
l_prog_number/noheading
"Printed by:"/column=62
username/noheading/newline
"For The Period:"/column=35/newline
str(l_starting_date,"MM/DD/YYYY") + " - " + str(l_ending_date,"MM/DD/YYYY")
/column=35
""/newline=2
sfpname:agent_no/noheading
sfsagent:name/noheading
""/newline

/*  END OF FILE */
