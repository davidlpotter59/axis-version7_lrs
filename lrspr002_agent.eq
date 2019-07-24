
/* LRSPR002_agent.EQ 

   april 28, 2009

   SCIPS.com 

   claim status report */

description Status Report ;

DEFINE L_TRANS = SWITCH(lrsdetail:TRANS_TYPE)
                   CASE 1  : 1
                   DEFAULT : 2   


DEFINE STRING I_NAME[50] = lrssummary:claimant


INCLUDE "RENAEQ1.INC"
define unsigned ascii number l_policy_no = parameter/prompt="Enter Policy No "

define file sfsdefault_alias = access sfsdefault,
                                  set sfsdefault:SFS_CODE = "SFS", exact
define string l_company_id[10] = sfsdefault_alias:company_id

define file alt_sfplocation = access sfplocation,
                                 set sfplocation:policy_no    = lrssetup:policy_no,
                                     sfplocation:pol_Year     = lrssetup:pol_year,
                                     sfplocation:end_sequence = lrssetup:end_sequence,
                                     sfplocation:prem_no      = lrssetup:prem_no,
                                     sfplocation:build_no     = lrssetup:build_no, generic

--define file lrssetup_alias = access lrssetup,
--                                set lrssetup:policy_no = l_policy_no, using second index, approximate

 
--define file lrsdetail_alias = access lrsdetail,
--                                 set lrsdetail:company_id = l_company_id,
--                                     lrsdetail:claim_no   = lrssetup_alias:claim_no, generic                                            

define string l_claim_no = str(lrsdetail:claim_no) + sfsline:claim_alpha 

where lrssetup:policy_no = l_policy_no and
      lrsdetail:claim_no = lrssetup:claim_no 

LIST
/DOMAIN="lrsdetail"
/NOBANNER
/PAGEWIDTH=200
/NOREPORTTOTALS
/nopageheadings
/nodetail
/noheadings 
                    
lrsdetail:LOSS_RESV/column=25/MASK="ZZZZZZ9-" --/HEADING="Loss-Resv"

lrsdetail:LOSS_PAID/column=50/MASK="$ZZZZZZZ9.ZZ-" --/HEADING="Loss-Paid"
 
if lrsdetail:ulae = "Y" then
    {
    lrsdetail:LAE_RESV/column=75/MASK="ZZZZZZ9.ZZ-"--/HEADING="ULAE-Resv"
    lrsdetail:LAE_PAID/column=100/MASK="ZZZZZZ9.ZZ-"--/HEADING="ULAE-Paid"
    }
if lrsdetail:alae = "Y" then
    {
    lrsdetail:LAE_RESV/column=125/MASK="ZZZZZZ9.ZZ-"--/HEADING="ALAE-Resv"
    lrsdetail:LAE_PAID/column=150/MASK="ZZZZZZ9.ZZ-"--/HEADING="ALAE-Paid"
    }

SORTED BY lrsdetail:claim_no/TOTAL/heading="CLAIM"/mask="$9,999,999.99"
end of lrsdetail:claim_NO 

SWITCH(lrssummary:status) 
  CASE "O" : "CLAIM OPEN"
  CASE "C" : "CLAIM CLOSED"
  CASE "R" : "CLAIM RE-OPENED"

""/newline                   

top of report 
  "Program Number: LRSPR002"
  sfscompany:name[1]/center
  pagenumber/newline=2/heading="Page"/column=120

TOP OF lrsdetail:claim_no                                   
"STATUS REPORT FOR CLAIM " + l_claim_no/column=49/newline=2
lrssetup:POLICY_NO/HEADING="Policy"/column=45
" - "
sfsline_alias:description/newline=2

if sfsline_alias:lob_code <> "AUTO" then
    {                   
    box/noblanklines/noheadings/column=1
      sfpname:NAME[1]/newline   
    if sfpname:name[2] <> "" then
        sfpNAME:name[2]/newline
    if sfpname:name[3] <> "" then
        sfpname:name[3]/newline
    if alt_sfplocation:address <> "" then
        alt_sfplocation:address/newline
    if alt_sfplocation:address1[1] <> "" then
        alt_sfplocation:address1[1]/newline
    if alt_sfplocation:address1[2] <> "" then
        alt_sfplocation:address1[2]/newline
    if alt_sfplocation:address1[3] <> "" then
        alt_sfplocation:address1[3]/newline
    box/noblanklines/noheadings/squeeze
    alt_sfplocation:city + ", "
    alt_sfplocation:str_state 
    alt_sfplocation:str_zipcode                
    end box/newline 
--    if sfscause:line_type = "L" then
--        {
--        "Claimant: "
--        I_rev_name/newline
--        }
    end box
    }                       
if sfsline_alias:lob_code = "AUTO" then
    {
    box/noblanklines/noheadings/column=1
    "Year:     "
    capvehicle:year/newline
    "Make:     "
    capvehicle:make/newline
    "Model:    "
    capvehicle:model/newline
    "Serial No:"
    capvehicle:serial_no/newline
    "Driver:   "
    lrsdriver:name/newline
--    if sfscause:line_type <> "L" then
--        "Insured:  "
--    else
--        "Claimant: "
--    I_REV_NAME/newline
    end box
    }

box
  /column= 1
box
 /noblanklines
 /noheadings
 /column=60
"Examinor:       "
lrssetup:examiner_no/mask="ZZZZZ"
sfsvendor_alias:name[1]/newline
"Adjustor:       "
lrssetup:adjustor_vendor/mask="ZZZZZ"
sfsvendor1:name[1]/newline
"Coverage Option:"
lrssetup:coverage_vendor/mask="ZZZZZ"
sfsvendor4:name[1]/newline                     
"Litigation:     "
lrssetup:litigation_vendor/mask="ZZZZZ"
sfsvendor2:name[1]/newline                        
"DJ:             "
lrssetup:dj_vendor/mask="ZZZZZ"
sfsvendor3:name[1]/newline
"Subro/Salvage:  "
lrssetup:subro_vendor/mask="ZZZZZ"
sfsvendor5:name[1]/newline
"Cat No:         "
lrssetup:CAT_NO/mask="ZZZZZ"
lrscat:description/newline
"Public Adjustor:"
lrssetup:pub_adjust_no/mask="ZZZZZ"
lrspubadj:name[1]
end box/newlines =2

"Loss-Resv"/column= 25
"Loss-Paid"/column= 50
"ULAE-Resv"/column= 75
"ULAE-Paid"/column= 100
"ALAE-Resv"/column= 125
"ALAE-Paid"/column= 150

end box

box/noblanklines/noheadings/column=120/inline
"Policy Eff Date:"
sfpNAME:EFF_DATE/NEWLINE
"Policy Exp Date:"
sfpNAME:EXP_DATE/NEWLINE
"Date Of Loss:   "
lrssetup:LOSS_DATE/NEWLINE
"Date Reported   "
lrssetup:REPORTED_DATE
end box










/*  END OF FILE  */
