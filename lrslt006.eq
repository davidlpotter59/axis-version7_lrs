/* lrslt006.eq

   SCIPS.com

   Sept. 4, 2001

   Claim Acknowledgment letter - First Notice to responsible carrier

*/

define file sfpname_alt = access sfpname, set
                        sfpname:policy_no= lrssetup:policy_no ,
                        sfpname:pol_year= lrssetup:pol_year ,
                      sfpname:end_sequence= lrssetup:end_sequence ,exact

define file sfscause_alt = access sfscause, set
                sfscause:company_id= lrssetup:company_id ,
                sfscause:line_of_business = lrssetup:line_of_business ,
                sfscause:lob_subline= lrssetup:lob_subline ,
                sfscause:cause_of_loss= lrssetup:cause_of_loss ,
                sfscause:cause_loss_subline= lrssetup:cause_loss_subline ,
generic


define file sfsvendor_alt = access sfsvendor, set
                         sfsvendor:company_id = lrssetup:company_id,
                         sfsvendor:vendor_no = lrssetup:examiner_no , exact

define unsigned ascii number l_adjustor[5] = lrssetup:vendor_no[2]

define file sfsvendor_alt2 = access sfsvendor, set
                         sfsvendor:company_id= lrssetup:company_id ,
                         sfsvendor:vendor_no= l_adjustor ,exact

define file sfsagent_alt = access sfsagent, set
                              sfsagent:company_id= lrssetup:company_id ,
                              sfsagent:agent_no= lrssetup:agent_no, exact

define string i_name[50] = lrssetup:name[1]

include "renaeq1.inc" 

define string i_name2[50] = lrssetup:claimant

DEFINE STRING I_REV_NAME2 =
                 TRUN(I_NAME2[(POS("=",I_NAME2)+1),
                 LEN(I_NAME2)])+" "+TRUN(I_NAME2[0,(POS("=",I_NAME2)-1)])

--where lrssetup:claim_no = 5412001

list
/nobanner
/domain="lrssetup_work"
/pagewidth=255
/pagelength=0
/nopageheadings
/noheadings

""/newline=7
todaysdate/mask="MM/DD/YYYY"/newline=2
include "renaeq2.inc" /newline
sfpname_alt:address[1]/newline
if sfpname_alt:address[2] <> "" then
     sfpname_alt:address[2]/newline
if sfpname_alt:address[3] <> "" then
     sfpname_alt:address[3]/newline
trun(sfpname_alt:city)
sfpname_alt:str_state
sfpname_alt:str_zipcode /newline=2
"Re:   Claim No: "
lrssetup:claim_no/column=20/newline
"     Policy No: " 
lrssetup:policy_no /column=20/newline
"     Loss Date: "
lrssetup:loss_date /column= 20/newline
"       Insured: "
Include "renaeq2.inc"/column=20/newline
"      Claimant: " 
IF (POS("=",I_NAME2)) <> 0 THEN
        I_REV_NAME
ELSE
        I_NAME2/column=20/newline
"          Type: "
sfscause_alt:description/column=20/newline=2

"Dear Sir/Madame: "/newline=2
"Our company insures the above party.  We have made a payment to our insured for the "/newline
"damages resulting from this occurrence which total "
lrssetup_work:amount/mask="$$,$$$,$$9.99" 
" .  On the basis of the "/newline
"information we have concerning the facts of this occurrence, it is our opinion that "/newline
"your insured is legally responsible for the damages."/newline=2
"Enclosed please find copies of the documents needed to pursue subrogation against "/newline
"your client."/newline=2
"Please forward a check for "
lrssetup_work:amount/mask="$$,$$$,$$9.99"
" made payable to Farmers Mutual Fire Insurance "/newline
"Company of Salem County and forward to 125 West Broadway, Salem New Jersey,  08079."/newline
"Attn: "
sfsvendor_alt:name[1]/newline=2
"If you have any questions, or wish to discuss this further please feel free to contact "/newline
"me at "
sfsvendor_alt:telephone 
"EXT: "
sfsvendor_alt:extension[1]
"."/newline=2

"Very Truly Yours,"/column=40/newline=4
sfsvendor_alt:name[1]/column=40/newline
"Subrogation Dept. "/column=40/newline=2


sfsvendor_alt:name[1]/newline
if sfsvendor_alt:name[2] <> "" then
       sfsvendor_alt:name[2]/newline   
if sfsvendor_alt:name[3] <> "" then
       sfsvendor_alt:name[3]/newline
if sfsvendor_alt:po_box <> "" then
       sfsvendor_alt:po_box /newline
if sfsvendor_alt:address[1] <> "" then
         sfsvendor_alt:address[1]/newline
sfsvendor_alt:city_state
sfsvendor_alt:zipcode /newline
"Telephone: "
sfsvendor_alt:telephone[1]/newline=2

    
