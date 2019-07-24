define unsigned ascii number l_claim_no=parameter/prompt="Enter Claim Number"

define string i_name=sfpname:name[1]  
include "renaeq1.inc"

-- second name
define string i_namea=sfpname:name[2]
include "renaeq1a.inc"

-- third name
define string i_nameb=sfpname:name[3]
include "renaeq1b.inc"

define file asfscause = access sfscause, set sfscause:company_id= 
lrssetup:company_id,
sfscause:line_of_business= lrssetup:line_of_business,
sfscause:lob_subline= lrssetup:lob_subline,
sfscause:cause_of_loss= lrssetup:cause_of_loss,
sfscause:cause_loss_subline= lrssetup:cause_loss_subline, approximate 

where lrssetup:claim_no = l_claim_no 
list
/nobanner
/domain="lrssetup"
/nodefaults
/nopageheadings 
/pagelength=0
/noduplicates 
/pagewidth=255

lrssetup:claim_no/column=1/mask='"ZZZZZZZZZZZ","'
i_rev_name/column=16/mask='X(50)","'
asfscause:description/mask='X(50)","'/column=70/noduplicates 
lrssetup:policy_no/column=124/mask='ZZZZZZZZZ","'
lrssetup:loss_date/column=137/mask='MM/DD/YYYY","'/newline
i_rev_namea/column=1/mask='X(50)","'/newline
i_rev_nameb/column=1/mask='X(50)","'/newline 
sfpname:address[1]/column=1/mask='X(50)","'/newline
sfpname:address[2]/column=1/mask='X(50)","'/newline 
sfpname:address[3]/column=1/mask='X(50)","'/newline
'#"' -- end of report deliminator

top of report

'"Claim","'/column=1
'Name","'/column=10
'Cause","'/column=20       
'Policy","'/column=30
'Loss-date"'/column=40
'Name2"'/column=50
'Name3"'/column=60
'Address1"'/column=70
'Address2"'/column=80
