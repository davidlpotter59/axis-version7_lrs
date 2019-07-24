/*  LRSPR539

    Claims in Litigation

    SCIPS.com, Inc

Modified By     Date                  Description
*/

description Claims in Litigation ;

Define String l_prog_number = "LRSPR539 - Rev 4.00"
define string l_prog_title  = "Claims in Litigation"

define file alt_sfscause = access sfscause, 
            set sfscause:company_id = lrsdetail:company_id,
            sfscause:line_of_business = lrsdetail:line_of_business,
            sfscause:lob_subline = lrsdetail:lob_subline,
            sfscause:cause_of_loss = lrsdetail:cause_of_loss,
            sfscause:cause_loss_subline = lrsdetail:cause_loss_subline, exact

          
define string l_claim_no = str(lrsdetail:claim_no) + trun(sfsline_alias:claim_alpha
)

Include "lrs63cal.inc"

include "lrscollect.inc"
and lrsdetail:trans_date <= l_ending_date and
    lrssetup:status one of "O", "R" and 
    lrsdetail:trans_code < 30 and
    lrssetup:litigation = "Y" 
    

list
/nobanner
/domain="lrsdetail"
/title="Claims in Litigation"
/pagewidth=240
/duplicates
/nodetail                       
/nopageheadings

Include "lrs53prt.inc"

sorted by  alt_sfscause:line_type /total/newlines
           lrsdetail:claim_no


Include "lrs53clm.inc"

include "scipstop01.inc"

end of alt_sfscause:line_type
if lrssetup:litigation = "Y" then
count[lrssetup:claim_no] "Open Claims"
