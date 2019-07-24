define unsigned ascii number l_claim_no=parameter/prompt="Enter Claim Number"

define string I_name=sfpname:name[1]  

include "renaeq1.inc"

where lrssetup:claim_no = l_claim_no 

list
/nobanner
/domain="lrssetup"
/nodefaults
/nopageheadings 
/pagelength=0
/pagewidth=255

'"'
lrssetup:claim_no/mask="ZZZZZZZZZZZ"/column=2
'","'
trun(i_rev_name)/column=17
'","'/column=68
trun(sfpname:address[1])/column=71
'","'/column=102
trun(sfpname:address[2])/column=105
'","'/newline/column=1
trun(sfpname:city)/column=4 
'","'/newline/column=35
sfpname:str_state/column=38
'","'/newline/column=40
str(val(str_zipcode),"ZZZZZ-ZZZZ")/column=43

'","'/column=53
lrssetup:reported_date/mask="M(15) DD, YYYY"/column=56
'"'/column=78
"#"/column=79 -- end of record

top of report
'"'
"Claim"
'","'
"Name"
'","'
"Address"
'","'
"Address2"
'","'
"City"
'","'
"State"
'","'
"Zipcode"
'","'
"Date"
'"'
