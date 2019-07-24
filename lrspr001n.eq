/* LRSPR001N.EQ

   SCIPS.com

   May 11, 2001

   loss daily register - Ceded   */

description 
Claims Net Daily Transaction Register; 

DEFINE L_TRANS = SWITCH(LRSDETAIL:TRANS_TYPE)                  CASE 1  : 1
                   DEFAULT : 5

DEFINE STRING L_PROG_NUMBER = "LRSPR001N - Rev. 4.10"

define string l_claim_no = str(lrsdetail:claim_no) + sfsline_alias:claim_alpha 
             
DEFINE DATE L_STARTING_DATE = PARAMETER/prompt="Enter Starting Date: "
            L_ENDING_DATE = PARAMETER/prompt="Enter Ending Date: "

WHERE LRSDETAIL:TRANS_DATE => L_STARTING_DATE AND
      LRSDETAIL:TRANS_DATE <= L_ENDING_DATE  

LIST
/DOMAIN="LRSDETAIL"
/NOBANNER
/PAGEWIDTH=250
/DUPLICATES
/title = "NET LOSS TRANSACTION REGISTER"
/nopageheadings

LRSDETAIL:TRANS_DATE/width=11
LRSDETAIL:VENDOR_NO/width=6
l_claim_no/heading="Claim No"/width=13
LRSSETUP:POLICY_NO/width=10
LRSSETUP:NAME[1]
str(LRSdetail:CAUSE_of_LOSS) + " " + lrsdetail:cause_loss_subline/heading=
"Cause of Loss"
str(LRSDETAIL:line_of_business) + " " + lrsdetail:lob_subline/heading=
"Line-Of-Business"   
lrsdetail:reins_co/heading="Treaty"/mask="ZZZZ"
LRSDETAIL:TRANS_CODE
if lrsdetail:trans_code not one of 17, 18 then
    val(lrscheck:check_no)/mask="ZZZZZZZ"
LRSDETAIL:LOSS_RESV/MASK="ZZZZZZZ-"
LRSDETAIL:LOSS_PAID/MASK="ZZZZZZZ.99-"
LRSDETAIL:LAE_RESV/MASK="ZZZZZ-"
LRSDETAIL:LAE_PAID/MASK="ZZZZZ.99-"

SORTED BY 
          LRSDETAIL:CLAIM_NO/newlines=2/total  
          LRSDETAIL:TRANS_DATE
           

INCLUDE "rpttopfw.inc"
""/NEWLINE
