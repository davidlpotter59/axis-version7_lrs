/* LRSPR003.EQ

   SCIPS.com

   May 11, 2001

   loss daily register   */

description Totals by Transaction Register ;

DEFINE L_TRANS = SWITCH(LRSDETAIL:TRANS_TYPE)
                   CASE 1  : 1
                   DEFAULT : 5

DEFINE STRING L_PROG_NUMBER = "LRSPR001NEW - Rev. 2.00"

define string l_claim_no = str(lrsdetail:claim_no) + sfsline_alias:claim_alpha 
             
include "startend.inc"

WHERE LRSDETAIL:TRANS_DATE => L_STARTING_DATE AND
      LRSDETAIL:TRANS_DATE <= L_ENDING_DATE and
      lrsdetail:trans_code < 30 and
      lrsdetail:preload not one of 1 
--      sfsline:lob_code not one of "WORK", "LOST", "MEDICAL"
LIST
/DOMAIN="LRSDETAIL"
/NOBANNER
/PAGEWIDTH=250
/DUPLICATES
/title = "LOSS TRANSACTION REGISTER"
/nopageheadings    

--LRSDETAIL:VENDOR_NO/width=6
l_claim_no/heading="Claim No"/width=13 
LRSDETAIL:TRANS_DATE/width=11
LRSSETUP:POLICY_NO/width=10
LRSSETUP:NAME[1]
str(LRSdetail:CAUSE_of_LOSS) + " " + lrsdetail:cause_loss_subline/heading=
"Cause of Loss"
str(LRSDETAIL:line_of_business) + " " + lrsdetail:lob_subline/heading=
"Line-Of-Business"
LRSDETAIL:TRANS_CODE
--if lrsdetail:trans_code not one of 17, 18 then
--    lrscheck:check_no
LRSDETAIL:LOSS_RESV
LRSDETAIL:LOSS_PAID
LRSDETAIL:LAE_RESV
LRSDETAIL:LAE_PAID

SORTED BY --LRSDETAIL:TRANS_DATE/NEWPAGE/TOTAL/HEADING="COMBINED"
         -- L_TRANS/TOTAL/HEADING=""
            LRSDETAIL:TRANS_CODE/total/newpage/newlines=2 
            LRSDETAIL:CLAIM_NO         
            LRSDETAIL:TRANS_DATE
--END OF L_TRANS
--IF L_TRANS = 1 THEN
--    BOX
--    ""/NEWLINE=2
--"- - - - - - - REINSURANCE INFORMATION - - - - - - -"/COLUMN=85
--    END BOX/NEWLINE

--INCLUDE "rpttopfw.inc"
--""/NEWLINE

--;

/*  END OF FILE  */
