/* lrslt010.eq

   SCIPS.com

   Sept. 4, 2001

   Claim Acknowledgment letter - with holdback and check info

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


define file lrscheck_alt = access lrscheck, set
                    lrscheck:company_id= lrssetup_work:company_id ,
                    lrscheck:claim_no= lrssetup_work:claim_no ,
                    lrscheck:sub_code= lrssetup_work:lrscheck_subcode , exact

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

define string i_name3[50] = lrscheck_alt:payee_name[1]

DEFINE STRING I_REV_NAME3 =
                 TRUN(I_NAME3[(POS("=",I_NAME3)+1),
                 LEN(I_NAME3)])+" "+TRUN(I_NAME3[0,(POS("=",I_NAME3)-1)])

define string i_name4[50] = lrscheck_alt:mailto_name[1] 

DEFINE STRING I_REV_NAME4 =
                 TRUN(I_NAME4[(POS("=",I_NAME3)+1),
                 LEN(I_NAME4)])+" "+TRUN(I_NAME4[0,(POS("=",I_NAME4)-1)])



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

"Dear Insured:"/newline=2
"Please be advised that a check in the amount of "
lrssetup_work:amount/mask="$$,$$$,$$9.99"
"was issued by Farmers "/newline
"Mutual Insurance Company of Salem County.  The amount of the check includes the "/newline
"the depreciation amount of "
lrssetup_work:depreciation_amt /mask="$$,$$$,$$9.99"
"."/newline=2
"Your claim is now paid in full and we will close our file accordingly.  The "/newline
"following information is provided:"/newline=2
"1.  The check was made payable to :"
IF (POS("=",I_NAME3)) <> 0 THEN
        I_REV_NAME
ELSE
        I_NAME3/newline=2

--lrscheck_alt:payee_name[1]/newline=2
"2.  The check was mailed to :"
IF (POS("=",I_NAME4)) <> 0 THEN
        I_REV_NAME
ELSE
        I_NAME4/newline=2

--lrscheck_alt:mailto_name [1]/newline=2
"3.  The check was mailed to the party named in item #3 at the following address:"/newline
lrscheck_alt:address[1]/newline
trun(lrscheck_alt:city) 
lrscheck_alt:str_state 
lrscheck_alt:str_zipcode /newline=2


"Very Truly Yours,"/column=40/newline=4
sfsvendor_alt:name[1]/column=40/newline
sfsvendor_alt:telephone/column=40/newline
"EXT: "/column=40
sfsvendor_alt:extension[1]/newline=2

"CC:"/newline
sfsagent_alt:name[1]/newline
if sfsagent_alt:name[2] <> "" then
     sfsagent_alt:name[2]

    
